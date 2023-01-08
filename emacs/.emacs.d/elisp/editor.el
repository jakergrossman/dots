;;; editor.el
;;;
;;; settings for text editing

(setq c-default-style "linux")
(setq-default indent-tabs-mode nil)

(use-package dired-x :ensure nil)

(defun rc/switch-to-minibuffer ()
  "Switch to the minibuffer window, if it is active"
  (interactive)
  (cond
   ((active-minibuffer-window)
    (select-frame-set-input-focus (window-frame (active-minibuffer-window)))
    (select-window (active-minibuffer-window)))

   (t (message "The minibuffer is not active!"))))

;;;; completion
(use-package ido-completing-read+
  :config
  (setq-default ido-enable-flex-matching t)
  (setq ido-vertical-define-keys 'C-n-and-C-p-only)
  (ido-mode 1)
  (ido-vertical-mode 1)
  (ido-everywhere 1)
  (ido-ubiquitous-mode 1))

(use-package company
  :hook (after-init . global-company-mode)
  :custom
  (company-idle-delay 0)
  :bind (:map company-mode-map
         ("C-c p" . company-complete)))

(use-package company-fuzzy
  :hook (company-mode . global-company-fuzzy-mode))

(use-package rg
  :bind (:map prog-mode-map
         ("C-c t" . rg-project)))

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

;; loose global keybindings not associated with a package
(bind-keys
 :map global-map
 ("C-c M" . rc/switch-to-minibuffer)
 ("C-c K" . kill-this-buffer)
 ("C-c r" . replace-string)
 ("C-c R" . replace-regexp))

(provide 'editor)
