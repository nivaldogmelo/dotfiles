;;; init-treemacs.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs treemacs configuration
;;
;;; Code:


;; TreemacsEmacs
(use-package
  treemacs
  :ensure t
  :defer t
  :init (with-eval-after-load 'winum (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config (progn
	    (setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
		  treemacs-deferred-git-apply-delay      0.5
		  treemacs-directory-name-transformer    #'identity
		  treemacs-display-in-side-window        t
		  treemacs-eldoc-display                 t
		  treemacs-file-event-delay              2000
		  treemacs-file-extension-regex          treemacs-last-period-regex-value
		  treemacs-file-follow-delay             0.2
		  treemacs-file-name-transformer         #'identity
		  treemacs-follow-after-init             t
		  treemacs-expand-after-init             t
		  treemacs-git-command-pipe              ""
		  treemacs-goto-tag-strategy             'refetch-index
		  treemacs-indentation                   2
		  treemacs-indentation-string            " "
		  treemacs-is-never-other-window         nil
		  treemacs-max-git-entries               5000
		  treemacs-missing-project-action        'ask
		  treemacs-move-forward-on-expand        nil
		  treemacs-no-png-images                 nil
		  treemacs-no-delete-other-windows       t
		  treemacs-project-follow-cleanup        nil
		  treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist"
									   user-emacs-directory)
		  treemacs-position                      'left
		  treemacs-read-string-input             'from-child-frame
		  treemacs-recenter-distance             0.1
		  treemacs-recenter-after-file-follow    nil
		  treemacs-recenter-after-tag-follow     nil
		  treemacs-recenter-after-project-jump   'always
		  treemacs-recenter-after-project-expand 'on-distance
		  treemacs-litter-directories            '("/node_modules" "/.venv" "/.cask" "/target")
		  treemacs-show-cursor                   t
		  treemacs-show-hidden-files             t
		  treemacs-silent-filewatch              nil
		  treemacs-silent-refresh                nil
		  treemacs-sorting                       'alphabetic-asc
		  treemacs-space-between-root-nodes      t
		  treemacs-tag-follow-cleanup            t
		  treemacs-tag-follow-delay              1.5
		  treemacs-user-mode-line-format         nil
		  treemacs-user-header-line-format       nil
		  treemacs-width                         35
		  treemacs-width-is-initially-locked     t
		  treemacs-workspace-switch-cleanup      nil)
	    (treemacs-follow-mode t)
	    (treemacs-filewatch-mode t)
	    (treemacs-git-commit-diff-mode t)
	    (treemacs-fringe-indicator-mode 'always)
	    (pcase (cons (not (null (executable-find "git")))
			 (not (null treemacs-python-executable)))
	      (`(t . t)
	       (treemacs-git-mode 'deferred))
	      (`(t . _)
	       (treemacs-git-mode 'simple))))
  :bind (:map global-map
	      ("M-0"       . treemacs-select-window)
	      ("C-x t 1"   . treemacs-delete-other-windows)
	      ("C-x t t"   . treemacs)
	      ("C-x t B"   . treemacs-bookmark)
	      ("C-x t C-t" . treemacs-find-file)
	      ("C-x t M-t" . treemacs-find-tag)))
;; -TreemacsEmacs

;; TreemacsIntegrations
(use-package
  treemacs-evil
  :after (treemacs)
  :ensure t)

(use-package
  treemacs-nerd-icons
  :ensure t
  :config
  (treemacs-load-theme "nerd-icons"))

(use-package
  treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package
  treemacs-icons-dired
  :after (treemacs dired)
  :ensure t
  :config (treemacs-icons-dired-mode))

(use-package
  treemacs-magit
  :after (treemacs magit)
  :ensure t)
;; -TreemacsIntegrations


(provide 'init-treemacs)
;;; init-treemacs.el ends here
