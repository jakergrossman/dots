; -*- lexical-binding: t -*-

;; configuration utilities
(load "~/.emacs.d/rc.el")

;; expand tabs to spaces
(setq-default indent-tabs-mode nil)

;;;; APPEARANCE

(rc/require-theme 'gruber-darker)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(setq-default display-line-numbers 'relative)
(show-paren-mode 1)

;; smooth scrolling
(when (>= emacs-major-version 29)
  (pixel-scroll-precision-mode 1))

;; don't show startup screen
(setq inhibit-startup-screen t)

(setq visible-bell 1)

;; whitespace mode
(defun rc/setup-whitespace-handling ()
  (interactive)
  (whitespace-mode 1)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace)
  (setq whitespace-style '(face spaces space-mark))
  (set-face-attribute 'whitespace-space nil :background nil :foreground "gray30"))

(setq rc/whitespace-modes '(lisp-mode
                            c-mode
                            emacs-lisp-mode
                            python-mode
                            matlab-mode))

(dolist (mode rc/whitespace-modes)
  (add-hook (intern (concat (symbol-name mode) "-hook")) 'rc/setup-whitespace-handling))

;; Don't have red outline around modeline
(set-face-attribute 'mode-line nil :box nil)

(rc/require 'hl-todo)
(global-hl-todo-mode)

;; don't spam customize-* in version-controlled file >:(
(setq custom-file "~/.emacs.d/custom.el")
(rc/load custom-file t)

;; always ask for yes/no in full
(defalias 'y-or-n-p 'yes-or-no-p)

;;;; PACKAGES

;; dired
(require 'dired-x)

;; ls flags for dired output
(when (not (string= system-type "darwin"))
  (setq dired-use-ls-dired t))

;; open dired for the current file's directory
(rc/set-keys "C-x C-j" 'dired-jump)

;; slime
(rc/require 'slime)
(setq inferior-lisp-program "/usr/local/bin/sbcl")

;; magit
(rc/require 'magit)

;; better completion
(rc/require 'ido-completing-read+)
(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)

;; evil mode
(setq evil-want-C-u-scroll t) ; why this isn't the default is beyond me
(rc/require 'evil)
(evil-mode t)
(evil-set-initial-state 'dired-mode 'emacs)

;; multi-cursor support
(rc/require 'multiple-cursors)

(rc/set-keys "C-S-c C-S-c" 'mc/edit-lines
             "C->"         'mc/mark-next-like-this
             "C-<"         'mc/mark-previous-like-this
             "C-c C-<"     'mc/mark-all-like-this)

(defun rc/switch-to-minibuffer ()
  "Switch to the minibuffer window, if it is active"
  (interactive)
  (cond
   ((active-minibuffer-window)
    (select-frame-set-input-focus (window-frame (active-minibuffer-window)))
    (select-window (active-minibuffer-window)))
   (t (message "The minibuffer is not active!!!"))))

(rc/set-user-keys "C-c M" 'rc/switch-to-minibuffer)

;; select languages allowed for inline ORG blocks
(rc/register-org-babel-languages "+lisp" "+shell" "+C")
(setf org-confirm-babel-evaluate nil)

;; custom modes
(add-to-list 'load-path "~/.emacs.d/modes/")
(require 'jflex-mode)
(require 'cup-mode)
(require 'gitignore-mode)

;; racket- and racket repl-modes
(rc/require 'racket-mode 'geiser-racket 'quack)

(defconst rc/roman-greek-alist
  '((?a . #x03B1)   ; α GREEK SMALL   LETTER ALPHA
    (?b . #x03B2)   ; β GREEK SMALL   LETTER BETA
    (?g . #x03B3)   ; γ GREEK SMALL   LETTER GAMMA
    (?d . #x0394)   ; Δ GREEK CAPITAL LETTER DELTA
    (?e . #x03B5)   ; ε GREEK SMALL   LETTER EPSILON
    (?t . #x03B8)   ; θ GREEK SMALL   LETTER THETA
    (?l . #x03BB)   ; λ GREEK SMALL   LETTER LAMBDA
    (?m . #x03BC)   ; μ GREEK SMALL   LETTER MU
    (?r . #x03C1)   ; ρ GREEK SMALL   LETTER RHO
    (?s . #x03C3)   ; σ GREEK SMALL   LETTER SIGMA
    (?p . #x03C6)   ; φ GREEK SMALL   LETTER PHI
    (?w . #x03C9))  ; ω GREEK SMALL   LETTER OMEGA
  "Association list from Latin letters to Greek counterparts.
Only letters frequently used as variables (by me) are available.")

;; map `C-c C-g LETTER` to the Greek counterpart to
;; LETTER in rc/roman-greek-alist
(dolist (key rc/roman-greek-alist)
  (rc/set-keys (concat "C-c C-g " (string (car key)))
               (λ (insert-char (cdr key)))))

;; company-mode
(rc/require 'company 'slime-company)

;; company mode everywhere
(add-hook 'after-init-hook 'global-company-mode)

;; kinda slow completion...
(setq company-idle-delay 2)

;; ...but can manually prompt completion anyways
(rc/set-user-keys "C-c p" 'company-complete)
