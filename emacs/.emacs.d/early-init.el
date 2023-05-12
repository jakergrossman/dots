; -*- lexical-binding: t; -*-

;; Package Manager Sources
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

;; Identifying Information
(setq user-full-name "Jake Grossman"
      user-mail-address "jakergrossman@gmail.com")

;; Garbage Collection/Large File Threshold
(setq gc-cons-threshold             50000000  ; 50 MB
      large-file-warning-threshold 100000000) ; 100 MB

;; Refresh package contents every 24 hours
(defvar emacs-timestamp-file (expand-file-name ".package-timestamp" user-emacs-directory))
(defvar emacs-package-refresh-interval 24)

(defun rc/need-refresh-p ()
  "Determine with `package-refresh-contents` is required."
  (cond
   ((not (file-exists-p emacs-timestamp-file))
    ;; does not exist, create it
    (with-temp-file emacs-timestamp-file)
    t)

   (t
    ;; file exists, check if > refresh-
    (let* ((attr (file-attributes emacs-timestamp-file))
           (mod (nth 5 attr))
           (delta (float-time (time-since mod))))
      (> delta (* emacs-package-refresh-interval 60 60))))))

(when (rc/need-refresh-p)
  (package-refresh-contents)
  (set-file-times emacs-timestamp-file (current-time)))

(defconst my-lisp-dir (expand-file-name "elisp" user-emacs-directory)
  "Directory of personal configuration")

(defconst my-site-lisp-dir (expand-file-name "site-lisp" user-emacs-directory))

(defun add-subdirs-to-load-path (root)
  (let ((default-directory root))
    (add-to-list 'load-path root)
    (normal-top-level-add-subdirs-to-load-path)))

;; Provide consistency with older emacs versions that DONT call
;; package initialize between early-init.el and init.el
(when (< emacs-major-version 27)
  (package-initialize))
