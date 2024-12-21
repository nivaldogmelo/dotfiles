;;; init-rust.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs rust configuration
;;
;;; Code:


;; RusticMode
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
  (setq rustic-format-on-save t)
  (add-hook 'rustic-mode-hook #'disable-before-save-hook)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

;; Disable lsp format buffer on save
(defun disable-before-save-hook ()
  (remove-hook 'before-save-hook 'lsp-format-buffer t))

(defun rk/rustic-mode-hook ()
  ;; so that run C-c C-c C-r works without having to confirm, but don't try to
  ;; save rust buffers that are not file visiting. Once
  ;; https://github.com/brotzeit/rustic/issues/253 has been resolved this should
  ;; no longer be necessary.
  (when buffer-file-name
    (setq-local buffer-save-without-query t))
  (keymap-global-set "C-c C-c C-a" 'rustic-cargo-add))

;; -RusticMode

;; RustProjectile
(projectile-register-project-type 'rust '("Cargo.toml")
				  :project-file "Cargo.toml"
				  :compile "cargo build"
				  :test "cargo test"
				  :run "cargo run")
;; -RustProjectile

;; RustLsp
(defun rust-lsp-setup ()
  (setq lsp-rust-analyzer-cargo-watch-command "clippy")
  ;; enable / disable the hints as you prefer:
  ;; These are optional configurations. See https://emacs-lsp.github.io/lsp-mode/page/lsp-rust-analyzer/#lsp-rust-analyzer-display-chaining-hints for a full list
  (setq lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (setq lsp-rust-analyzer-display-chaining-hints t)
  (setq lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (setq lsp-rust-analyzer-display-closure-return-type-hints t)
  (setq lsp-rust-analyzer-display-parameter-hints nil)
  (setq lsp-rust-analyzer-display-parameter-hints nil)
  (setq lsp-rust-analyzer-display-reborrow-hints nil))

(add-hook 'rustic-mode-hook #'rust-lsp-setup)
;; -RustLsp


(provide 'init-rust)
;;; init-rust.el ends here
