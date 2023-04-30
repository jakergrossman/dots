(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file t))

(unless (package-installed-p 'use-package)
  (package-install 'use-package)
  (require 'use-package))

(setq use-package-always-ensure t)

;; set up load path
;; everything under .emacs.d/elisp can be found
(let ((elisp-dir (expand-file-name "elisp" user-emacs-directory)))
  (add-to-list 'load-path elisp-dir)
  (normal-top-level-add-subdirs-to-load-path))

;;; Main configuration entry point:

(require 'init-nav)
(require 'init-appearance)
(require 'init-completion)
(require 'init-misc)
(require 'init-verilog)
(require 'init-common-lisp)
