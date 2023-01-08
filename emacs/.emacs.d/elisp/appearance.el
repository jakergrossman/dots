;;; appearance.el
;;;
;;; Visual settings of the Emacs editor (not files)

;; set up theme path
(dolist (dir (rc/dirs (rc/conf-concat "elisp" "themes")))
  (when dir
    (add-to-list 'custom-theme-load-path dir)))

(load-theme 'adwaita)

;; disable tool bar, menu bar, scroll bar
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)

;; show matching parentheses
(show-paren-mode 1)

;; straight to scratch buffer
(setq inhibit-startup-screen t)

;; flash frame to represent bell
(setq visible-bell 1)

(add-to-list 'after-init-hook 'global-hl-line-mode)

(when (>= emacs-major-version 29)
  (pixel-scroll-precision-mode 1))

(set-face-attribute 'default nil :height 150)

(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (ansi-color-apply-on-region compilation-filter-start (point)))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(defun rc/setup-whitespace ()
  (interactive)
  (whitespace-mode 1)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace)
  (setq whitespace-style '(face spaces space-mark))
  (set-face-attribute 'whitespace-space nil :background nil :foreground "gray75"))

(setq ed/whitespace-modes '(lisp-mode
                            c-mode
                            emacs-lisp-mode
                            python-mode))

(dolist (mode ed/whitespace-modes)
  (add-hook (rc/symbol-cat mode "-hook") 'rc/setup-whitespace))

(provide 'appearance)
