;;; rc.el --- -*- lexical-binding: t -*-
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
  "Concatenate a list of symbols or strings, `intern'ing the result.

Symbols are converted to string via `symbol-name', and arguments that
are not strings or symbols are silently ignored."
  (intern (apply #'concat (mapcar (φ (x) (cond
                                          ((symbolp x) (symbol-name x))
                                          ((stringp x) x)))
                                  components))))

(defconst rc/latin-greek-alist
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

(cl-loop for (key . code) in rc/latin-greek-alist
         do (define-key 'iso-transl-ctl-x-8-map (string key) (string code)))

(defun rc/load (path &optional ignorep)
  "Load a file from PATH.

If ignore is nil, emit an error when a file can not be loaded"
  (interactive "FFile Path: ")
  (cond
   ((file-exists-p path) (load path))
   ((not ignorep)
    (let ((continue (yes-or-no-p (format "%s could not be loaded. Continue? " path))))
      (when (not continue) (error "Could not load %s" path))))))

(cl-defmacro rc/all ((item-name items &key (key #'identity)) &body predicate)
  "Return whether PREDICATE evaluates true for every elements of ITEMS.

While evaluating PREDICATE, ITEM-NAME is bound to the result of applying
KEY to each element in ITEMS.

KEY is a single-argument function applied to each element to retrieve the
value to evaluate with PREDICATE."
  (cl-with-gensyms (tmp)
    `(cl-loop for ,tmp in ,items
              for ,item-name = (funcall ',key ,tmp)
              always (progn ,@predicate))))

(defun rc/allp (predicate list)
  "Return whether PREDICATE is true for all elements in LIST."
  (cl-loop for item in list always (funcall predicate item)))

(cl-defmacro rc/any ((item-name items &key (key #'identity)) &body predicate)
  "Return whether PREDICATE evaluates true for any elements of ITEMS.

While evaluating PREDICATE, ITEM-NAME is bound to the result of applying
KEY to each element in ITEMS.

KEY is a single-argument function applied to each element to retrieve the
value to evaluate with PREDICATE."
  (cl-with-gensyms (tmp)
    `(cl-loop for ,tmp in ,items
              for ,item-name = (funcall ',key ,tmp)
              thereis (progn ,@predicate))))

(defun rc/anyp (predicate list)
  "Return whether PREDICATE is true for any elements in LIST."
  (cl-loop for item in list thereis (funcall predicate item)))

(cl-defmacro rc/none ((item-name items &key (key #'identity)) &body predicate)
  "Return whether PREDICATE evaluates true for no elements of ITEMS.

While evaluating PREDICATE, ITEM-NAME is bound to the result of applying
KEY to each element in ITEMS.
.
KEY is a single-argument function applied to each element to retrieve the
value to evaluate with PREDICATE."
  (cl-with-gensyms (tmp)
    `(cl-loop for ,tmp in ,items
              for ,item-name = (funcall ',key ,tmp)
              never (progn ,@predicate))))

(defun rc/nonep (predicate list)
  "Return whether PREDICATE is true for no elements in LIST."
  (cl-loop for item in list never (funcall predicate item)))

(cl-defun rc/dirs (&optional (root default-directory) filters)
  "Return all subdirectories of ROOT that do not match any of the
regexp patterns in the list FILTERS."
  (when (file-exists-p root)
    (let (dirs
          visited
          (pending (list root)))
      ;; This loop does a breadth-first tree walk on ROOT's subtree,
      ;; putting each subdir into DIRS as its contents are examined.
      (while pending
        (push (pop pending) dirs)
        (let* ((default-directory (car dirs))
               (files (directory-files default-directory))
               (attrs (file-attribute-file-identifier
                       (file-attributes default-directory))))
          (unless (member attrs visited)
            (push attrs visited)
            (dolist (file files)
              (and (not (member file '("." "..")))
                   (rc/none (re filters) (string-match re file))
                   (file-directory-p file)
                   (setq pending (nconc pending (list (expand-file-name file)))))))))

      ;; don't include ROOT
      (cdr (nreverse dirs)))))

(defun rc/conf-concat (&rest components)
  "Wraps `concat' and `file-name-as-directory' to build
a path from COMPONENTS."
  (let ((default-directory user-emacs-directory))
    (expand-file-name
     (apply #'concat
            (when components
              (append (mapcar #'file-name-as-directory
                              (cl-subseq components 0 (1- (length components))))
                      (last components)))))))

(provide 'rc)
