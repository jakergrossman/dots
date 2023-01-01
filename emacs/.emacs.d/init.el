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

;; configuration modules
(add-to-list 'load-path "/home/goby/.emacs.d/elisp")
(use-package rc :ensure nil)
(use-package appearance :ensure nil)
(use-package core :ensure nil)
(use-package editor :ensure nil)
