;;; lang-go.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs go configuration
;;
;;; Code:

;; Mode
(use-package
  go-mode
  :ensure t)

;; Projectile integration
(use-package
  go-projectile
  :ensure t)

(projectile-register-project-type 'go '("go.mod")
				  :project-file "go.mod"
				  :compile "go build"
				  :test "go test ./..."
				  :run "go run main.go"
				  :test-suffix "_test")

;; Lsp Setup
(defun go/setup-lsp ()
  (progn
    (lsp-deferred)))
(add-hook 'go-mode-hook #'go/setup-lsp)

;;; Debugger
(require 'dap-dlv-go)



(provide 'lang-go)
;;; lang-go.el ends here
