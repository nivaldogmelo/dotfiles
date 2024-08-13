;;; init-magit.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs magit configuration
;;
;;; Code:


;; MagitEmacs
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
;; -MagitEmacs

;; MagitTODO
(use-package
  magit-todos
  :after magit
  :custom
  (magit-todos-keyword-suffix " ?([p^)]+):")
  (magit-todos-keywords '("jww" "FIXME"))
  (magit-todos-exclude-globs '(".git/" "/archive/"))
  :config
  (magit-todos-mode 1))
;; -MagitTODO


(provide 'init-magit)
;;; init-magit.el ends here
