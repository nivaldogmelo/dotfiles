;;; init-terraform.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs terraform configuration
;;
;;; Code:


;; TerraformMode
(use-package
  terraform-mode
  :ensure t)
;; -TerraformMode

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

(add-hook 'terraform-mode-hook #'setup-lsp-terraform)
;; -TerraformLsp


(provide 'init-terraform)
;;; init-terraform.el ends here
