;;; docker.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs configuration to handler docker operations
;;
;;; Code:

;; Tools
(use-package
  docker
  :ensure t
  :bind ("C-c d" . docker))
;; -Tools

;; Dockerfile
(use-package
  dockerfile-mode
  :ensure t)

;; Needed for LSP
;; npm install -g dockerfile-language-server-nodejs
;; -Dockerfile

(provide 'docker)
;;; docker.el ends here
