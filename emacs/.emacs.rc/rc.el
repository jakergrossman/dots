;;;; https://github.com/rexim/dotfiles/blob/9ca2e60a2f52a00eb24592cb47f2329a7c8d6aa1/.emacs.rc/rc.el

(package-initialize)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(defvar rc/package-contents-refreshed nil)
(defun rc/package-refresh-contents-once ()
  "Refresh package contents the first time this functions is called"
  (when (not rc/package-contents-refreshed)
    (setq rc/package-contents-refreshed t)
    (package-refresh-contents)))

(defun rc/require-one-package (package)
  "Require a single package, refreshing the contents if required"
  (when (not (package-installed-p package))
    (rc/package-refresh-contents-once)
    (package-install package)))

(defun rc/require (&rest packages)
  "Require one or more PACKAGES"
  (dolist (package packages)
    (rc/require-one-package package)))

(defun rc/require-theme (theme &optional theme-package)
  "Require a theme. If THEME-PACKAGE is nil, the name of the theme's package is assumed to be THEME-theme"
  (let ((theme-package (or theme-package (intern (concat (symbol-name theme) "-theme")))))
    (rc/require theme-package)
    (load-theme theme t)))

(defun rc/load (path &optional ignore)
  "Load a file from PATH. Ignores non-existent file if IGNORE is non-nil"
  (interactive "FFile path: ")
  (cond
   ((file-exists-p path) (load path))
   ((not ignore)
    (let ((continue (yes-or-no-p (format "%s could not be loaded. Continue? " path))))
      (when (not continue) (error "Could not load %s" path))))))

(defun rc/set-keys (keys func)
  "Shorthand for keybindings"
  (global-set-key (kbd keys) func))

;; cl-lib is not installed by default on Windows,
;; but is required for cl-loop
(rc/require 'cl-lib)
(defun rc/set-keys (&rest mappings)
  "Given an alist MAPPINGS => (KEYS ACTION), map each KEYS to ACTION"
  (cl-loop for (keys action) on mappings by #'cddr
           do (global-set-key (kbd keys) action)))
