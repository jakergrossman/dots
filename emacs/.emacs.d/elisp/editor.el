;;; editor.el
;;;
;;; settings for text editing

(setq c-default-style "linux")
(setq-default indent-tabs-mode nil)

(use-package dired-x
  :ensure nil
  :config (rc/unset-keys "C-x C-j")
  :bind (("C-c C-j" . 'dired-jump)))

(defun rc/switch-to-minibuffer ()
  "Switch to the minibuffer window, if it is active"
  (interactive)
  (cond
   ((active-minibuffer-window)
    (select-frame-set-input-focus (window-frame (active-minibuffer-window)))
    (select-window (active-minibuffer-window)))

   (t (message "The minibuffer is not active!"))))

(rc/set-user-keys "C-c M" 'rc/switch-to-minibuffer)

;;;; completion
(use-package ido-completing-read+
  :config
  (ido-mode 1)
  (ido-everywhere 1)
  (ido-ubiquitous-mode 1))

(use-package company
  :hook (after-init . global-company-mode)
  :config (setq company-idle-delay 0)
  :bind (("C-c p" . 'company-complete)))

(use-package rg
  :bind (("C-c t" . rg-project)))

(rc/set-user-keys "C-c K" 'kill-this-buffer
                  "C-c r" 'replace-string
                  "C-c R" 'replace-regexp)

(use-package undo-tree
  :hook (after-init . global-undo-tree-mode))

(use-package slime
  :custom
  (inferior-lisp-program "sbcl"))

;; (use-package paredit
;;   :hook ((lisp-mode . paredit-mode)
;;          (emacs-lisp-mode . paredit-mode)
;;          (scheme-mode . paredit-mode)))

(defun rc/load-this-file ()
  (interactive)
  (cond
   ((buffer-file-name)
    (load-file buffer-file-name))
   ((yes-or-no-p "Current buffer is not a file. Evaluate buffer? ")
    (eval-buffer))))

(cl-defun rc/find-conf-file (filename &optional wildcard)
  "Wrapper around `find-file' starting in `user-emacs-directory'."
  (interactive (list (read-file-name "Find File: " user-emacs-directory)))
  (find-file filename wildcard))

(provide 'editor)
