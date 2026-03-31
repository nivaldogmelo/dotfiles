;;; lang-nginx.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs nginx configuration
;;
;;; Code:

;; Mode
(use-package
  nginx-mode
  :ensure t
  :config
  (add-hook 'nginx-mode-hook
	    (lambda ()
	      (setq indent-tabs-mode nil)
	      (setq nginx-indent-level 2)
	      (lsp-deferred))))
  ;; :command nginx-mode)

(add-to-list 'auto-mode-alist '("/nginx/sites-\\(?:available\\|enabled\\)/" . nginx-mode))


(provide 'lang-nginx)
;;; lang-nginx.el ends here
