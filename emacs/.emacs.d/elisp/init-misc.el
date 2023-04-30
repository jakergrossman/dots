;; backup files in their own directory
(setq backup-directory-alist '(("." . "~/.cache/emacs")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; Clean whitespace on buffer save
(add-hook 'before-save-hook 'whitespace-cleanup)

(setq visible-bell 1)

(bind-keys
 :map global-map
 ("C-c K" . kill-this-buffer)
 ("C-c r" . replace-string)
 ("C-c R" . replace-regexp)
 ("C-c c" . compile)
 ("C-c C" . recompile))

(use-package magit :defer)

(provide 'init-misc)
