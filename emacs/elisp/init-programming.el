;;; init-programming.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs general programming configuration
;;
;;; Code:


;; DeleteWhitespaceOnSave
(add-hook 'before-save-hook 'whitespace-cleanup)
;; -DeleteWhitespaceOnSave

;; LineNumbers
(add-hook 'prog-mode-hook (lambda () (display-line-numbers-mode 1)))
(add-hook 'text-mode-hook (lambda () (display-line-numbers-mode 1)))
;; -LineNumbers


;; SetupAbsolute/RelativeLineNumbers
(defun my/display-relative-numbers ()
  (setq display-line-numbers 'relative))

(defun my/display-absolute-numbers ()
  (setq display-line-numbers t))

(add-hook 'evil-insert-state-entry-hook #'my/display-relative-numbers)
(add-hook 'evil-insert-state-exit-hook #'my/display-absolute-numbers)
;; -SetupAbsolute/RelativeLineNumbers

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
