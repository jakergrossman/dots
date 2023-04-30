(use-package diminish)

;; theme
(use-package hc-zenburn-theme
  :config
  (load-theme 'hc-zenburn t))

;; font
(cl-flet ((font-p (font) (find-font (font-spec :name font))))
  (let* ((fonts '("Hack" "Source Code Pro" "Fira Code"))
         (font-name (or (cl-find-if #'font-p fonts) "monospace")))
    (set-frame-font (concat font-name "-12") nil t)))

;; Tabs are 4 spaces
(setq-default tabs-width 4
              indent-tabs-mode nil)

;; indent markers
(use-package highlight-indent-guides
  :hook prog-mode
  :diminish highlight-indent-guides-mode

  :init
  (defalias 'hig-mode 'highlight-indent-guides-mode)

  :custom
  (highlight-indent-guides-method 'character)
  (highlight-indent-guides-auto-character-face-perc 75))

(setq inhibit-startup-screen t)

;; Highlight line, line number, status bar info
(global-hl-line-mode +1)
(line-number-mode +1)
(global-display-line-numbers-mode 1)
(column-number-mode t)
(size-indication-mode t)

;; disable tool bar, menu bar, scroll bar
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)

(defalias 'yes-or-no-p 'y-or-n-p)

(provide 'init-appearance)
