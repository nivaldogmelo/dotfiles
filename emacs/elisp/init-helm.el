;;; init-helm.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs helm configuration
;;
;;; Code:


;; Helm

(use-package
  helm
  :ensure t
  :bind
  ("M-x" . helm-M-x) ;; Bind helm to execute-extended-command
  ("C-x C-f" . helm-find-files) ;; Bind helm to find-file
  :config (helm-mode))

;; Git integration
(use-package
  helm-ls-git
  :ensure t
  :bind
  ("C-x C-g" . helm-browse-project))

;; XRef integration
(use-package
  helm-xref
  :ensure t)

;; -Helm


(provide 'init-helm)
;;; init-helm.el ends here
