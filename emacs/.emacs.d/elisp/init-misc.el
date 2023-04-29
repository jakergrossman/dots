;; backup files in their own directory
(setq backup-directory-alist '(("." . "~/.cache/emacs")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; Don't blow up VC files with custom
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file t))

(bind-keys
 :map global-map
 ("C-c K" . kill-this-buffer)
 ("C-c r" . replace-string)
 ("C-c R" . replace-regexp)
 ("C-c c" . compile)
 ("C-c C" . recompile))

(use-package magit :defer)

(provide 'init-misc)
