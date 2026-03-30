;;; docker.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs configuration to handler docker operations
;;
;;; Code:

;; DockerMode
(use-package
  docker
  :ensure t
  :bind ("C-c d" . docker))

(provide 'docker)
;;; docker.el ends here
