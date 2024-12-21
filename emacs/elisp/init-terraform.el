;;; init-terraform.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs terraform configuration
;;
;;; Code:

;; TerraformCompany
(use-package
  company-terraform
  :ensure t)

(add-hook 'terraform-mode-hook (lambda ()
				 (set (make-local-variable 'company-backends)
				      '(company-terraform))
				 (company-mode)))
(add-hook 'terraform-mode-hook (lambda ()
				 (company-terraform-init)))
;; -TerraformCompany


;; TerraformDocs
(use-package
  terraform-doc
  :ensure t)
;; -TerraformDocs

;; TerraformLsp
(defun setup-lsp-terraform ()
  (progn
    (lsp-register-client
     (make-lsp-client :new-connection (lsp-stdio-connection '("/usr/bin/terraform-ls" "serve"))
		   :major-modes '(terraform-mode)
		   :server-id 'terraform-ls))
    (lsp-deferred)))

;; -TerraformLsp

;; TerraformMode
(use-package
  terraform-mode
  :ensure t
  :config
  (add-hook 'terraform-mode-hook 'terraform-format-on-save-mode)
  (add-hook 'terraform-mode-hook #'setup-lsp-terraform)
  (setq lsp-enable-links t)
  )
;; -TerraformMode

(provide 'init-terraform)
;;; init-terraform.el ends here
