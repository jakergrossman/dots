;; Package Manager
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

(when (< emacs-major-version 27)
  (package-initialize))
