;;; init-lsp.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs lsp configuration
;;
;;; Code:


;; LspEmacs
(use-package
  lsp-mode
  :ensure t
  :defer t
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (dolist (dir '("[/\\\\]\\target\\'")) ;; Rust
    (push dir lsp-file-watch-ignored-directories))
  :commands (lsp lsp-deferred)
  :hook
  (before-save-hook . lsp-format-buffer)
  (before-save-hook . lsp-organize-imports)
  :config
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  :custom
  (lsp-keymap-prefix "C-c l")
  (lsp-prefer-flymake nil)
  (read-process-output-max (* 1024 1024))
  (lsp-keep-workspace-alive nil)
  (lsp-inlay-hint-enable t)
  (lsp-eldoc-render-all t))
;; -LspEmacs

;; LspUI
(use-package
  lsp-ui
  :ensure t
  :after lsp-mode
  :diminish
  :custom-face
  (lsp-ui-doc-background ((t (:background nil))))
  (lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic)))))
  :bind
  (:map lsp-ui-mode-map
	([remap lsp-find-definitions] . #'lsp-ui-peek-find-definitions)
	([remap xref-find-definitions] . #'lsp-ui-peek-find-definitions)
	([remap lsp-find-references] . #'lsp-ui-peek-find-references)
	([remap xref-find-references] . #'lsp-ui-peek-find-references)
	("C-c l u" . lsp-ui-imenu))
  :config
  :custom
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-show-code-actions t)
  (lsp-ui-sideline-update-mode 'line)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-header t)
  (lsp-ui-doc-border (face-foreground 'default))
  (lsp-ui-peek-enable t)
  (lsp-ui-peek-show-directory t)
  (lsp-ui-imenu-enable t))
;; -LspUI

;; LspDap
(use-package
  dap-mode
  :diminish
  :ensure t
  :bind
  (:map dap-mode-map
	("<f12>" . dap-debug)
	("<f7>" . dap-continue)
	("<f8>" . dap-next)
	("<M-f11>" . dap-step-in)
	("<C-M-f11>" . dap-step-out)
	("<f6>" . dap-breakpoint-toggle))
  :config
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (tooltip-mode 1)
  (dap-ui-controls-mode 1))
;; -LspDap


(provide 'init-lsp)
;;; init-lsp.el ends here
