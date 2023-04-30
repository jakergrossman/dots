;; Completion
(use-package company
  :diminish company-mode
  :hook prog-mode
  :bind (:map company-active-map
              ("<tab>" . company-complete-selection))

  :custom
  (company-idle-delay 0.2)
  (company-minimum-prefix-length 2)
  (company-tooltip-align-annotations t)
  (company-tooltip-limit 7))

(use-package company-fuzzy
  :hook company-mode
  :diminish company-fuzzy-mode)

(use-package ido-completing-read+
  :config
  (ido-everywhere 1)
  (ido-ubiquitous-mode 1)
  :custom
  (ido-enable-flex-matching t)
  (ido-vertical-define-keys 'C-n-and-C-p-only))

(use-package ido-vertical-mode
  :after ido-completing-read+
  :config
  (ido-vertical-mode 1))

(provide 'init-completion)
