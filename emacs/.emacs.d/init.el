;; Identifying Information
(setq user-full-name "Jake Grossman"
      user-mail-address "jakergrossman@gmail.com")

;; Garbage Collection/Large File Threshold
(setq gc-cons-threshold             50000000  ; 50 MB
      large-file-warning-threshold 100000000) ; 100 MB

;; Startup Metrics
(defun rc/uptime (&optional after-init)
  (interactive)
  (let* ((startup-time (time-subtract after-init-time before-init-time))
         (ftime (float-time startup-time))
         (strtime (if after-init (emacs-uptime) (format "%.2f seconds" ftime))))
    (message "%s with %d GC passes" strtime gcs-done)))
(add-hook 'emacs-startup-hook #'rc/uptime)

(package-install 'use-package)

(setq use-package-always-ensure t)
(use-package diminish :ensure t)

;; Clean whitespace on buffer save
(add-hook 'before-save-hook 'whitespace-cleanup)

;; set up load path
;; everything under .emacs.d/elisp can be found
(let ((default-directory (expand-file-name "elisp" user-emacs-directory)))
  (add-to-list 'load-path default-directory)
  (normal-top-level-add-subdirs-to-load-path))

(require 'init-nav)
(require 'init-appearance)
(require 'init-completion)
(require 'init-misc)
(require 'init-verilog)
