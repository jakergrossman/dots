;; add maps to repeat-mode
(defun repeatize (keymap)
  "Add `repeat-mode' support to a KEYMAP"
  (map-keymap
   (lambda (_key cmd)
     (when (symbolp cmd)
       (put cmd 'repeat-map keymap)))
   (symbol-value keymap)))

;; jump around, jump around. Jump up, jump up and get down
(use-package avy
  :bind
  ;; darken IMMEDIATELY instead of after choosing a char (yes, it's hacky)
  ("C-=" . (lambda ()
             (interactive)
             (unwind-protect
                 (progn
                   (let ((avy-background t))
                     ;; avy-background=t required (because avy--make-backgrounds
                     ;; does the checking for some reason...)
                     (avy--make-backgrounds (avy-window-list)))

                   (let ((avy-background nil))
                     ;; avy-background=nil required so as to not double dip (and
                     ;; in the process, become unable to undarken)
                     (call-interactively 'avy-goto-char)))

               ;; catch quit from pre-character select or no matches
               (avy--done)))))

(use-package multiple-cursors
  :config
  (bind-keys
   :map prog-mode-map
   :prefix "C-c m"
   :prefix-map multiple-cursors-map
   ("n"  . mc/mark-next-like-this)
   ("p"  . mc/mark-previous-like-this)
   ("<"  . mc/mark-all-like-this)
   ("a"  . mc/edit-beginnings-of-lines)
   ("e"  . mc/edit-ends-of-lines)
   ("\"" . mc/skip-to-next-like-this)
   (":"  . mc/skip-to-previous-like-this)
   ("l"  . mc/edit-lines))
  (repeatize 'multiple-cursors-map))

(use-package rg
  :config
  (rg-enable-default-bindings))

(use-package ace-window
  :bind ("C-x o" . ace-window))

;; like `:h single-repeat` in vim
(use-package dot-mode
  :delight
  :config
  (global-dot-mode))


(mapc #'repeatize
      '(multiple-cursors-map))

(repeat-mode)

(provide 'init-nav)
