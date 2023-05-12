;; Completion
(use-package company
  :delight
  :hook prog-mode
  :bind (:map company-active-map
              ("<tab>" . company-complete-selection))

  :custom
  (company-idle-delay 0.1)
  (company-minimum-prefix-length 2)
  (company-tooltip-align-annotations t)
  (company-tooltip-limit 7))


(use-package company-fuzzy
  :hook company-mode
  :delight)

(use-package ido-completing-read+
  :disabled t
  :config
  (ido-everywhere 1)
  (ido-ubiquitous-mode 1)
  :custom
  (ido-enable-flex-matching t)
  (ido-vertical-define-keys 'C-n-and-C-p-only))

(use-package ido-vertical-mode
  :disabled t
  :after ido-completing-read+
  :config
  (ido-vertical-mode 1))

(use-package ivy
  :delight
  :config
  (ivy-mode)
  (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
  (setq ivy-initial-inputs-alist nil))

(use-package counsel
  :after ivy
  :delight
  :config
  (counsel-mode))

(use-package flx :requires ivy)

(provide 'init-completion)
