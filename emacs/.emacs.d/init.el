(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file t))

(eval-when-compile
  (unless (package-installed-p 'use-package)
    (package-install 'use-package))
  (require 'use-package))

(setq use-package-always-ensure t)

;; set up load path
;; everything under .emacs.d/elisp can be found
(add-subdirs-to-load-path my-lisp-dir)
(add-subdirs-to-load-path my-site-lisp-dir)

;;; Main configuration entry point:

(require 'init-nav)
(require 'init-appearance)
(require 'init-completion)
(require 'init-misc)
(require 'init-verilog)
(require 'init-common-lisp)
