;;; init-projectile.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs projectile configuration
;;
;;; Code:


;; ProjectileEmacs
(use-package
  projectile
  :ensure t
  :init (projectile-mode +1)
  :bind (:map projectile-mode-map
	      ("C-c p" . projectile-command-map)))

;; Automated Project Discovery
(setq projectile-project-search-path '("~/code/"))
;; -ProjectileEmacs

;; ProjectileHelm
(use-package
  helm-projectile
  :ensure t
  :bind (:map evil-ex-map
	      ("p" . helm-projectile-grep)
	      ("f" . helm-projectile-find-file)))
;; -ProjectileHelm


(provide 'init-projectile)
;;; init-projectile.el ends here
