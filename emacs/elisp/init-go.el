;;; init-go.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs golang configuration
;;
;;; Code:


;; CompanyGo
(use-package
  company-go
  :ensure t)
;; -CompanyGo

;; ProjectileGo
(use-package
  go-projectile
  :ensure t
  :config
  (setq go-projectile-tools
	'((gocode    . "github.com/mdempsky/gocode")
	  (golint    . "golang.org/x/lint/golint")
	  (godef     . "github.com/rogpeppe/godef")
	  (errcheck  . "github.com/kisielk/errcheck")
	  (godoc     . "golang.org/x/tools/cmd/godoc")
	  (gogetdoc  . "github.com/zmb3/gogetdoc")
	  (goimports . "golang.org/x/tools/cmd/goimports")
	  (gorename  . "golang.org/x/tools/cmd/gorename")
	  (gomvpkg   . "golang.org/x/tools/cmd/gomvpkg")
	  (guru      . "golang.org/x/tools/cmd/guru"))))

(projectile-register-project-type 'go '("go.mod")
				  :project-file "go.mod"
				  :compile "go build"
				  :test "go test ./..."
				  :run "go run main.go"
				  :test-suffix "_test")
;; -ProjectileGo

;; GoMode
(use-package
  go-mode
  :ensure t
  :after company-go)

(defun setup-go-mode ()
  (progn
    (setq lsp-register-custom-settings '(("gopls.completeUnimported" t t)
					 ("gopls.usePlaceholders" t t)
					 ("gopls.staticcheck" t t)))
    (set (make-local-variable 'company-backends) '(company-go))
    (company-mode)
    (lsp-deferred)))
(add-hook 'go-mode-hook #'setup-go-mode)
;; (add-hook 'go-mode-hook #'lsp-deferred)

;; (add-hook 'go-mode-hook
;;       (lambda ()

;; (add-hook 'go-mode-hook
;;	  (lambda ()
;; -GoMode

;; DapGo
(add-to-list 'load-path "~/.emacs.d/custom-libs/go")

(require 'dap-dlv-go)
;; -DapGo


(provide 'init-go)
;;; init-go.el ends here
