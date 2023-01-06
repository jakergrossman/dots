;;; rc.el -*- lexical-binding: t -*-
;;;
;;; Emacs configuration configuration

(require 'cl-lib)

(cl-defmacro λ (&body body)
  "Anonymous closure shorthand with no arguments."
  `(lambda () (interactive) ,@body))

(cl-defmacro φ ((&rest args) &body body)
  "Anonymous closure shorthand with arguments."
  `(lambda (,@args) (interactive) ,@body))

(defun rc/error (fmt &rest args)
  "Issue a warning with type (RC) and level :ERROR."
  (apply #'lwarn `((rc) :error ,fmt ,@args)))

(defun rc/symbol-cat (&rest components)
  "Concatenate a list of symbols  or strings, `intern'ing the result.

Symbols are converted to string via `symbol-name', and arguments that
are not strings or symbols are silently ignored."
  (intern (apply #'concat (mapcar (φ (x) (cond
                                          ((symbolp x) (symbol-name x))
                                          ((stringp x) x)))
                                  components))))

(defun rc/set-keys (&rest mappings)
  "Given a property list MAPPINGS => (KEYS ACTION)*, map each KEYS to ACTION"
  (when (eq (mod (length mappings) 2) 1)
    (rc/error "Odd number of arguments to RC/SET-KEYS (%s)" (length mappings))
    (return-from rc/set-keys))
  (cl-loop for (keys action) on mappings by #'cddr
           do (global-set-key (kbd keys) action)))

(defun rc/set-user-keys (&rest mappings)
  "Like `rc/set-keys', but asserts that the only mappings present
are those reserved for users: C-c followed by a letter and <f5>-<f9>.

If any mapping is not a reserved mapping, no keys are mapped and an error is emitted."
  (cl-loop with valid-format = "^\\(C-c\s+[a-zA-Z]\\|<f[5-9]>\\)"
           for (keys action) on mappings by #'cddr
           for errorp = (not (string-match-p valid-format keys))

           when errorp
           collect keys into errors

           unless errorp
           append (list keys action) into validated

           finally (if errors
                       (rc/error "The following keymaps were not reserved user mappings: %S" errors)
                     (apply #'rc/set-keys validated))))

(defun rc/unset-keys (&rest mappings)
  (dolist (map mappings)
    (global-unset-key (kbd map))))

(defconst rc/roman-greek-alist
  '((?a . #x03B1)   ; α GREEK SMALL   LETTER ALPHA
    (?b . #x03B2)   ; β GREEK SMALL   LETTER BETA
    (?g . #x03B3)   ; γ GREEK SMALL   LETTER GAMMA
    (?d . #x0394)   ; Δ GREEK CAPITAL LETTER DELTA
    (?e . #x03B5)   ; ε GREEK SMALL   LETTER EPSILON
    (?t . #x03B8)   ; θ GREEK SMALL   LETTER THETA
    (?l . #x03BB)   ; λ GREEK SMALL   LETTER LAMBDA
    (?m . #x03BC)   ; μ GREEK SMALL   LETTER MU
    (?r . #x03C1)   ; ρ GREEK SMALL   LETTER RHO
    (?s . #x03C3)   ; σ GREEK SMALL   LETTER SIGMA
    (?p . #x03C6)   ; φ GREEK SMALL   LETTER PHI
    (?w . #x03C9))  ; ω GREEK SMALL   LETTER OMEGA
  "Association list from Latin letters to unicode Greek counterparts.")


(dolist (key rc/roman-greek-alist)
  (rc/set-keys (concat "C-c g " (string (car key)))
               (λ (insert-char (cdr key)))))

(defun rc/load (path &optional ignorep)
  "Load a file from PATH.
If ignore is nil, emit an error when a file can not be loaded"
  (interactive "FFile Path: ")
  (cond
   ((file-exists-p path) (load path))
   ((not ignorep)
    (let ((continue (yes-or-no-p (format "%s could not be loaded. Continue? " path))))
      (when (not continue) (error "Could not load %s" path))))))

(cl-defun rc/edit-conf (&optional (relpath user-emacs-directory))
  "Wrapper around `find-file' starting in `user-emacs-directory'"
  (interactive "fFile Path: ")
  (find-file relpath))

(provide 'rc)
