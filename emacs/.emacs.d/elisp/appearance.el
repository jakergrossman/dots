;;; appearance.el
;;;
;;; Visual settings of the Emacs editor (not files)

(provide 'appearance)

;; disable tool bar, menu bar, scroll bar
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

;; no modeline outline, column number
(set-face-attribute 'mode-line nil :box nil)
(column-number-mode 1)

;; show matching parentheses
(show-paren-mode 1)

;; straight to scratch buffer
(setq inhibit-startup-screen t)

;; flash frame to represent bell
(setq visible-bell 1)

(use-package gruber-darker-theme
  :ensure t
  :config (load-theme 'gruber-darker))
