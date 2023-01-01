;;; editor.el
;;;
;;; settings for text editing

(provide 'editor)

(setq c-default-style "linux")
(setq-default indent-tabs-mode nil)

(use-package dired-x
  :ensure nil
  :config (rc/unset-keys "C-x C-j")
  :bind (("C-c C-j" . 'dired-jump)))

(defun ed/setup-whitespace ()
  (interactive)
  (whitespace-mode 1)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace)
  (setq whitespace-style '(face spaces space-mark))
  (set-face-attribute 'whitespace-space nil :background nil :foreground "gray30"))

(setq ed/whitespace-modes '(lisp-mode
                            c-mode
                            emacs-lisp-mode
                            python-mode))

(dolist (mode ed/whitespace-modes)
  (add-hook (rc/symbol-cat mode "-hook") 'ed/setup-whitespace))

(defun ed/switch-to-minibuffer ()
  "Switch to the minibuffer window, if it is active"
  (interactive)
  (cond
   ((active-minibuffer-window)
    (select-frame-set-input-focus (window-frame (active-minibuffer-window)))
    (select-window (active-minibuffer-window)))

   (t (message "The minibuffer is not active!"))))

(rc/set-user-keys "C-c M" 'ed/switch-to-minibuffer)

(use-package completion :ensure nil)
