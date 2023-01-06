;;; init.el
;;;
;;; Bootstrap use-package and load configuration packages
(require 'package)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(package-initialize)
(package-install 'use-package)
(require 'use-package)
(setq use-package-always-ensure t)

(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file t))

;; set up load path
;; everything under .emacs.d/elisp can be found
(let ((default-directory (expand-file-name "elisp" user-emacs-directory)))
  (add-to-list 'load-path default-directory)
  (normal-top-level-add-subdirs-to-load-path))

;; configuration modules
(require 'rc)
(require 'appearance)
(require 'core)
(require 'editor)
(require 'vcs)
(require 'lsp)
(require 'tree-sitter)
