(use-package verilog-mode
  :bind (:map verilog-mode-map
              (";" . self-insert-command)
              (":" . self-insert-command))

  :init
  ;; setup linter
  (let ((linter (cl-find-if (lambda (n) (locate-file n exec-path exec-suffixes 1))
                            '("verilator" "verilator_bin" "verilator_bin.exe"))))
    (setq verilog-linter
          (if linter
              (concat linter " --lint-only")
            "")))

  :custom
  (verilog-auto-newline nil)
  (verilog-indent-level-module 2)
  (verilog-indent-level-behavioral 2)
  (verilog-indent-level-declaration 2)
  (verilog-indent-level-directive 2))

(provide 'init-verilog)
