;;; init-programming.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs general programming configuration
;;
;;; Code:


;; DeleteWhitespaceOnSave
(add-hook 'before-save-hook 'whitespace-cleanup)
;; -DeleteWhitespaceOnSave

;; TextFolding
(use-package
  origami
  :commands (origami-mode)
  :ensure t
  :hook (prog-mode . origami-mode)
  :custom
  (origami-show-fold-header t)
  :bind
  (:map origami-mode-map
	("<backtab>" . origami-recursively-toggle-node)
	("C-c <backtab>" . origami-toggle-all-nodes)))
;; -TextFolding

;; EnvFile
(use-package
  dotenv-mode
  :ensure t
)
(add-to-list 'auto-mode-alist '("\\.env\\..*\\'" . dotenv-mode))
;; -EnvFile

(provide 'init-programming)
;;; init-programming.el ends here
