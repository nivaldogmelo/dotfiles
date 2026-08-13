;;; lang-rust.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs rust configuration
;;
;;; Code:

;; Mode

;;; Disable lsp format buffer on save
;; (defun disable-before-save-hook ()
;;   (remove-hook 'before-save-hook 'lsp-format-buffer t))

(use-package
  rustic
  :ensure t
  :bind (:map rustic-mode-map
	      ("C-c C-c o" . lsp-rust-analyzer-open-cargo-toml)
	      ("C-c C-c C-d" . lsp-rust-analyzer-open-external-docs)
	      ("C-c s" . lsp-rust-analyzer-status))
  :config
  ;; uncomment for less flashiness
  ;; (setq lsp-eldoc-hook nil)
  ;; (setq lsp-enable-symbol-highlighting nil)
  ;; (setq lsp-signature-auto-activate nil)

  ;; comment to disable rustfmt on save
  (setq rustic-format-on-save nil)
  ;; (add-hook 'rustic-mode-hook #'disable-before-save-hook)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

(defun rk/rustic-mode-hook ()
  "Make sure that the buffer is saved without confirmation when running rustic-cargo-run."
  (when buffer-file-name
    (setq-local buffer-save-without-query t))
  (keymap-global-set "C-c C-c C-a" 'rustic-cargo-add))

;;; LSP
(defun rust-lsp-setup ()
  "Setup lsp-mode for Rust."
  (setq lsp-rust-analyzer-cargo-watch-command "clippy")
  (setq lsp-rust-analyzer-exclude-dirs ["**/target" ".git"])
  ;; enable / disable the hints as you prefer:
  ;; These are optional configurations. See https://emacs-lsp.github.io/lsp-mode/page/lsp-rust-analyzer/#lsp-rust-analyzer-display-chaining-hints for a full list
  (setq lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (setq lsp-rust-analyzer-display-chaining-hints t)
  (setq lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (setq lsp-rust-analyzer-display-closure-return-type-hints t)
  (setq lsp-rust-analyzer-display-parameter-hints nil)
  (setq lsp-rust-analyzer-display-reborrow-hints nil))

;;; Debugger
(defun rk/rustic-debugger-setup ()
  "Setup dap-mode for Rust."
  (setq dap-gdb-debug-program '("rust-gdb" "-i" "dap")))

(add-hook 'rustic-mode #'rk/rustic-debugger-setup)

(provide 'lang-rust)
;;; lang-rust.el ends here
