(package-initialize)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(defun rc/error (fmt &rest args)
  "Issue a warning with type (RC) and level :ERROR"
  (apply #'lwarn `((rc) :error ,fmt ,@args)))

;; Package handling inspired by Tsoding:
;; https://github.com/rexim/dotfiles/blob/9ca2e60a2f52a00eb24592cb47f2329a7c8d6aa1/.emacs.rc/rc.el

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

(defun rc/set-keys (&rest mappings)
  "Given a property list MAPPINGS => (KEYS ACTION)*, map each KEYS to ACTION"
  (when (eq (mod (length mappings) 2) 1)
    (rc/error "Odd number of arguments to RC/SET-KEYS (%s)" (length mappings))
    (return-from rc/set-keys))
  (cl-loop for (keys action) on mappings by #'cddr
           do (global-set-key (kbd keys) action)))

(defun rc/set-user-keys (&rest mappings)
  "Like RC/SET-KEYS, but asserts that the only mappings present
are those reserved for users: C-c followed by a letter and <f5>-<f9>.

If any mapping is not a reserved mapping, no keys are mapped and an error is emitted."
  (cl-loop for (keys action) on mappings by #'cddr
           for errorp = (not (string-match-p "\\(C-c\s+[a-zA-Z]\\|<f[5-9]>\\)" keys))

           when errorp
           collect keys into errors

           unless errorp
           append (list keys action) into validated

           finally (if errors
                       (rc/error "The following keymaps were not reserved user mappings: %S" errors)
                       (apply #'rc/set-keys validated))))

(defun rc/register-org-babel-languages (&rest lang-specs)
  "Register languages with org-babel.

Each item in LANG-SPECS is a string specifier for a language
preceded by either '+' or '-' (enabled or disabled, respectively):

  '+lisp'   ; enable lisp
  '-C'      ; disable C"
  (org-babel-do-load-languages
   'org-babel-load-languages
   (cl-loop with spec-format = "^[+-][a-zA-Z_-]+$"
            for spec in lang-specs
            for is-malformed = (not (and (stringp spec)
                                         (string-match spec-format spec)))

            when is-malformed
            do (rc/error "Org Babel specifier is malformed, ignoring (%s)" spec)

            unless is-malformed
            collect (cons (intern (cl-subseq spec 1))
                          (cl-ecase (aref spec 0)
                            (?+ t)
                            (?- nil))))))
