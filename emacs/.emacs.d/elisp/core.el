;;; core.el
;;;
;;; core Emacs configuration

(provide 'core)

;; always ask yes and no in full
(fset 'y-or-n-p 'yes-or-no-p)

;; backup files in their own directory
(setq backup-directory-alist '(("." . "~/.cache/emacs")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)
