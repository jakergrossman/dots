;;; completion.el

(provide 'completion)

(use-package ido-completing-read+
  :config
  (ido-mode 1)
  (ido-everywhere 1)
  (ido-ubiquitous-mode 1))

(use-package company
  :hook(after-init-hook . global-company-mode)
  :config (setq company-idle-delay 1)
  :bind (("C-c p" . 'company-complete)))
