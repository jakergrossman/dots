;;; editor.el
;;;
;;; settings for text editing

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

(provide 'editor)
