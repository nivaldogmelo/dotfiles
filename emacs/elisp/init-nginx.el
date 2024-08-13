;;; init-nginx.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs nginx configuration
;;
;;; Code:


;; NginxMode
(use-package
  nginx-mode
  :ensure t)
;; -NginxMode

;; NginxLsp
(defun setup-lsp-nginx ()
  (progn
    (lsp-register-client
     (make-lsp-client :new-connection (lsp-stdio-connection '("nginx-language-server"))
	:major-modes '(nginx-mode)
	:server-id 'nginx-language-server))
    (lsp-deferred)))

(add-hook 'nginx-mode-hook #'setup-lsp-nginx)
;; -NginxLsp


(provide 'init-nginx)
;;; init-nginx.el ends here
