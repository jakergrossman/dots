;;;; https://github.com/rexim/dotfiles/blob/9ca2e60a2f52a00eb24592cb47f2329a7c8d6aa1/.emacs.rc/rc.el

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(defvar rc/package-contents-refreshed nil)

(defun rc/package-refresh-contents-once ()
  (when (not rc/package-contents-refreshed)
    (setq rc/package-refresh-contents-once t)
    (package-refresh-contents)))

(defun rc/require-one-package (package)
  (when (not (package-installed-p package))
    (rc/package-refresh-contents-once)
    (package-install package)))

(defun rc/require (&rest packages)
  (dolist (package packages)
    (rc/require-one-package package)))

(defun rc/require-theme (theme)
  (let ((theme-package (intern (concat (symbol-name theme) "-theme"))))
    (rc/require theme-package)
    (load-theme theme t)))

(defun rc/load (path &optional ignore)
  (cond
   ((file-exists-p path) (load path))
   ((not ignore)
      (let ((response (read-from-minibuffer (format "%s could not be loaded. Continue? [Y/n]: " path))))
        (when (not (string-prefix-p "y" (downcase response)))
          (error "Could not load %s" path))))))
