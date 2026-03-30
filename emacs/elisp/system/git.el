;;; git.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs configuration to handler git
;;
;;; Code:


;; HelmIntegration
(use-package
  helm-ls-git
  :ensure t
  :bind
  ("C-x C-g" . helm-browse-project))
;; -HelmIntegration

;; Magit
(use-package
  magit
  :ensure t
  :custom
  (magit-diff-refine-hunk t)
  (magit-diff-paint-whitespace t)
  (magit-git-executable "/usr/bin/git")
  :bind
  (:map magit-status-mode-map
	("M-RET" . magit-diff-visit-file-other-frame)))

;;; Delta Config
(use-package magit-delta
  :hook (magit-mode . magit-delta-mode))

;;; TODO integration
(use-package
  magit-todos
  :after magit
  :config
  (magit-todos-mode 1))

;; -Magit


(provide 'git)
;;; git.el ends here
