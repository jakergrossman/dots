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

(defun rc/setup-whitespace-mode ()
  (global-whitespace-mode 1)
  (setq whitespace-style '(face spaces space-mark))
  (set-face-attribute 'whitespace-space nil :background 'unspecified :foreground "gray75"))

(defvar after-load-theme-hook nil
  "Hook that is run after a color theme is loaded using `load-theme'.")

(defadvice load-theme (after run-after-load-theme-hook activate)
  "Run `after-load-theme-hook'."
  (run-hooks 'after-load-theme-hook))

(add-hook 'after-load-theme-hook #'rc/setup-whitespace-mode)

(provide 'appearance)
