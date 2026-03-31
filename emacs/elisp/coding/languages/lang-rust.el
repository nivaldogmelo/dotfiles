;;; lang-rust.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs rust configuration
;;
;;; Code:

;; Mode

;;; Disable lsp format buffer on save
(defun disable-before-save-hook ()
  (remove-hook 'before-save-hook 'lsp-format-buffer t))

(use-package
  rustic
  :ensure t
  :bind (:map rustic-mode-map
	      ("C-c s" . lsp-rust-analyzer-status))
  :config
  ;; uncomment for less flashiness
  ;; (setq lsp-eldoc-hook nil)
  ;; (setq lsp-enable-symbol-highlighting nil)
  ;; (setq lsp-signature-auto-activate nil)

  ;; comment to disable rustfmt on save
  ;; (setq rustic-format-on-save t)
  (add-hook 'rustic-mode-hook #'disable-before-save-hook)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

(defun rk/rustic-mode-hook ()
  ;; so that run C-c C-c C-r works without having to confirm, but don't try to
  ;; save rust buffers that are not file visiting. Once
  ;; https://github.com/brotzeit/rustic/issues/253 has been resolved this should
  ;; no longer be necessary.
  (when buffer-file-name
    (setq-local buffer-save-without-query t))
  (keymap-global-set "C-c C-c C-a" 'rustic-cargo-add))

;;; LSP 
(defun rust-lsp-setup ()
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
  (setq dap-gdb-debug-program '("rust-gdb" "-i" "dap")))

(add-hook 'rustic-mode #'rk/rustic-debugger-setup)

(provide 'lang-rust)
;;; lang-rust.el ends here
