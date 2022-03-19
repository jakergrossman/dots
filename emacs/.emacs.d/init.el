; -*- lexical-binding: t -*-

;; Configure package.el to include MELPA
(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)
(package-initialize)

;; always follow symlinks
(setq vc-follow-symlinks t)

;; Load configuration
(org-babel-load-file "~/.emacs.d/config.org")
