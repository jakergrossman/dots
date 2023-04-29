;; jump around, jump around. Jump up, jump up and get down
(use-package avy
  :bind
  ("C-=" . avy-goto-char)
  :config
  (setq avy-background t))

(defun newline-and-indent-same-level ()
  "Insert a newline, then indent to the same column as the current line."
  (interactive)
  (let ((col (save-excursion
               (back-to-indentation)
               (current-column))))
    (newline)
    (indent-to-column col)))

(defun erase-tab-spaces-at-tab-stop ()
  "If the number of spaces is exactly a tab stop, erase a tab-width amount of space"
  (interactive)
  (if (and
       (looking-back "^[ ]+")
       (= (% (current-column) tab-width) 0))
      (delete-backward-char tab-width)
    (delete-backward-char 1)))

(defun forward-kill-whitespace-or-word ()
  "If `point' is followed by whitespace kill that.
Otherwise call `kill-word'"
  (interactive)
  (if (looking-at "[ \t\n]")
      (let ((pos (point)))
        (re-search-forward "[^ \t\n]" nil t)
        (backward-char)
        (kill-region pos (point)))
    (kill-word)))

(provide 'init-nav)
