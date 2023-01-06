;;; kernel-mode.el --- Linux kernel helpers

;; Version: 1.0
;; Author: Jake Grossman <jakergrossman@gmail.com>
;; Keywords: Linux, C

;; This file is distributed under the terms of The Unlicense:
;;
;; This is free and unencumbered software released into the public domain.
;;
;; Anyone is free to copy, modify, publish, use, compile, sell, or
;; distribute this software, either in source code form or as a compiled
;; binary, for any purpose, commercial or non-commercial, and by any
;; means.
;;
;; In jurisdictions that recognize copyright laws, the author or authors
;; of this software dedicate any and all copyright interest in the
;; software to the public domain. We make this dedication for the benefit
;; of the public at large and to the detriment of our heirs and
;; successors. We intend this dedication to be an overt act of
;; relinquishment in perpetuity of all present and future rights to this
;; software under copyright law.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
;; IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
;; OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
;; ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
;; OTHER DEALINGS IN THE SOFTWARE.
;;
;; For more information, please refer to <http://unlicense.org/>

(require 'cl-lib)

;;;; PUBLIC DECLARATIONS

(defgroup kernel nil
  "Support for Linux kernel development."
  :group 'languages)

(defvar kernel-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c C-k i") 'kernel-insmod)
    (define-key map (kbd "C-c C-k r") 'kernel-rmmod)
    (define-key map (kbd "C-c C-k l") 'kernel-lsmod)
    (define-key map (kbd "C-c C-k t") 'kernel-taint-reason)
    map)
  "Keymap for `kernel-mode'")

(define-minor-mode kernel-mode
  "Toggle kernel minor mode for working with the linux kernel.

When kernel mode is enabled, commands for compiling, loading,
and interacting with kernel sources and modules are enabled

\\{kernel-mode-map}"
  :group 'languages
  :init-value nil
  :lighter " Kernel"
  :interactive '(c-mode))

(cl-defstruct kernel-modinfo
  "Module info for a loaded Linux kernel module"
  (name nil
        :read-only t
        :type '(string)
        :documentation "Unique name of a loaded Linux module")

  (mem-size 0
            :read-only t
            :type '(integer)
            :documentation "Memory size of the module, in bytes")

  (ref-count 0
             :read-only t
             :type '(integer)
             :documentation "Reference count of the module")

  (depends nil
           :read-only t
           :type '(list symbol)
           :documentation "List of symbols for other modules that depend on this modules")

  (load-state nil
              :read-only t
              :type '(symbol)
              :documentation "Load state of the module; one of LIVE, LOADING, or UNLOADING")

  (mem-offset nil
              :read-only t
              :type '(integer)
              :documentation "Kernel memory offset for module (if available)")

  (taints nil
        :read-only t
        :type '(list symbol)
        :documentation "List of tags indicating why the kernel thinks this module taints the image"))

(cl-defmacro kernel-with-sudo (&body body)
  (declare (indent defun))
  `(with-temp-buffer
    (cd "/sudo::/")
    ,@body))

(defun kernel-loaded-modinfo ()
  "Return a list of module info for loaded Linux kernel modules."
  (let* ((mod-info-raw
          (with-temp-buffer
            (insert-file-contents "/proc/modules")
            (buffer-string)))
         (mod-info (delete "" (split-string mod-info-raw "\r?\n"))))
    (mapcar #'kernel--modinfo-from-string mod-info)))

(cl-defmacro kernel-with-modinfo ((var module-name) &body body)
  (declare (indent defun))
  (let ((mod-info-sym (gensym))
        (mod-sym (gensym)))
    `(when (or t (symbolp ,module-name))
       (let* ((,mod-info-sym (kernel-loaded-modinfo))
              (,var (cl-loop for ,mod-sym in ,mod-info-sym
                             if (equal (kernel-modinfo-name ,mod-sym) ,module-name)
                             return ,mod-sym)))
       ,@body))))

(cl-defmacro completing-read-module ()
  `(completing-read "Module: " (mapcar #'symbol-name (kernel-lsmod))))

(defun kernel--taint-id-to-string (id)
  (cl-case id
    (P "Proprietary module has been loaded")
    (F "Module has been forcibly loaded")
    (S "SMP with CPUs not designed for SMP")
    (R "User forced a module unload")
    (M "System experienced a machine check exception")
    (B "System has hit bad_page")
    (U "Userspace-defined naughtiness")
    (D "Kernel has oopsed before")
    (A "ACPI table overridden")
    (W "Taint on warning")
    (C "modules from drivers/staging are loaded")
    (I "Working around severe firmware bug")
    (O "Out-of-tree module has been loaded")
    (E "Unsigned module has been loaded")
    (t "Unknown taint reason")))

(defun kernel-taint-reason (module-name &optional interactivep)
  "Return a list of reasons the kernel has indicated the specified
module taints the kernel."
  (interactive (list (completing-read-module) t))
  (kernel-with-modinfo (mod (intern module-name))
    (when (not mod)
      (error "%s is not a loaded module!" module-name))

    (let ((reasons (cl-loop for tag in (kernel-modinfo-taints mod)
                            for reason = (kernel--taint-id-to-string tag)
                            when reason
                            collect (cons tag reason))))
      (when interactivep
        ;; print it all nice-like for the user
        (message (string-join
                  (mapcar (lambda (r) (concat (symbol-name (car r))
                                              " - "
                                              (cdr r)))
                          reasons)
                  "\n")))
      reasons)))

(defun kernel-lsmod (&optional print-info)
  "Return a list of loaded Linux kernel modules.

When run interactively or PRINT-INFO is non-nil, display the result using
`princ'."
  (interactive "p")
  (let ((modules (mapcar #'kernel-modinfo-name (kernel-loaded-modinfo))))
    (when print-info
      (princ modules))
    modules))

(defun kernel-insmod (module-path)
  "Insert a module into the Linux kernel."
  (interactive "fModule File: ")
  (kernel-with-sudo
    (compile (concat "sudo insmod " (shell-quote-argument module-path)))))

(defun kernel-rmmod (module)
  "Remove a module from the Linux kernel."
  (interactive (completing-read-module))
;    (completing-read "Module: " (mapcar #'symbol-name (kernel-lsmod)))))

  (kernel-with-sudo
    (compile (concat "sudo rmmod " (shell-quote-argument module)))))

;;;; "PRIVATE" DECLARATIONS

(defun kernel--parse-taints (str)
  (let ((re "\\([A-Z]+\\)"))
    (when (string-match re str)
      (cl-loop for c across (substring str (match-beginning 0) (match-end 0))
               collect (intern (string c))))))

(defun kernel--modinfo-from-string (str)
  "Parse a line of module information (as presented from /proc/modules)"
  (let ((parts (split-string str)))
    (make-kernel-modinfo
     :name (intern (nth 0 parts))
     :mem-size (string-to-number (nth 1 parts))
     :ref-count (string-to-number (nth 2 parts))
     :depends (if (string-equal (nth 3 parts) "-")
                  nil
                (mapcar #'intern (delete "" (split-string (nth 3 parts) ","))))
     :load-state (intern (upcase (nth 4 parts)))
     :mem-offset (string-to-number (string-remove-prefix "0x" (nth 5 parts)))
     :taints (kernel--parse-taints (nth 6 parts)))))

(provide 'kernel-mode)
