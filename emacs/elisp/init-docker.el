;;; init-docker.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs Docker configuration
;;
;;; Code:


;; DockerMode
(use-package
  docker
  :ensure t)

;; Enable mode
(use-package
  dockerfile-mode
  :ensure t)
;; -DockerMode
;; TODO: tramp integration


(provide 'init-docker)
;;; init-docker.el ends here
