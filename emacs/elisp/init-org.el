;;; init-org.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs org configuration
;;
;;; Code:


;; OrgEmacs
(use-package org
  :defer t
  )
;; -OrgEmacs

;; EvilOrg
(use-package
  evil-org
  :ensure t
  :after org
  :hook (org-mode . evil-org-mode)
  :config (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))
;; -EvilOrg

;; OrgLanguage
(use-package
  ob-go
  :ensure t)

(org-babel-do-load-languages 'org-babel-load-languages '((emacs-lisp . t)
							 (go . t)
							 (python . t)
							 (shell . t)))
;; -OrgLanguage


(provide 'init-org)
;;; init-org.el ends here
