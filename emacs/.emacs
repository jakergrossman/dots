(package-initialize)

;; configuration utilities
(load "~/.emacs.rc/rc.el")

;; expand tabs to spaces
(setq-default indent-tabs-mode nil)

;;;; APPEARANCE

(rc/require-theme 'gruber-darker)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(setq-default display-line-numbers 'relative)
(show-paren-mode)

;; don't show startup screen
(setq inhibit-startup-screen t)

(setq visible-bell 1)

;; space dots
(global-whitespace-mode)
(setq whitespace-style '(face spaces space-mark))

;; Don't have red outline around modeline
(set-face-attribute 'mode-line nil :box nil)

(rc/require 'hl-todo)
(hl-todo-mode)

;;;; PACKAGES

;; dired
(require 'dired-x)

;; ls flags for dired output
(setq dired-listing-switches "-aDghlo --group-directories-first")

;; slime
(rc/require 'slime)
           

(setq inferior-lisp-program "/usr/local/bin/sbcl")

;; magit
(rc/require 'magit)

;;;; MAPPINGS

;; open dired for the current file's directory
(global-set-key (kbd "C-x C-j") 'dired-jump)