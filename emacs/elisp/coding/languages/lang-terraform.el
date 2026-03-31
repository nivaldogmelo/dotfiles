;;; lang-terraform.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs terraform configuration
;;
;;; Code:

;; Mode
(defun tf/setup-lsp-terraform ()
  (progn
    (setq lsp-disabled-clients '(tfls))
	(lsp-deferred)))

(use-package
  terraform-mode
  :ensure t
  :config
  (add-hook 'terraform-mode-hook 'terraform-format-on-save-mode)
  (add-hook 'terraform-mode-hook #'setup-lsp-terraform)
  (setq lsp-enable-links t))

;; Terraform Docs
(use-package
  terraform-doc
  :ensure t)

(provide 'lang-terraform)
;;; lang-terraform.el ends here
