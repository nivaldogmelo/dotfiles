;;; ide.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs setup for coding projects
;;
;;; Code:

;; Projectile
(use-package
  projectile
  :ensure t
  :init (projectile-mode +1)
  :bind (:map projectile-mode-map
	      ("M-p" . projectile-command-map)
	      ("C-c p" . projectile-command-map)))
;;; Clean old projects
;;; (projectile-cleanup-know-projects)

;;; HelmIntegration
(use-package
  helm-projectile
  :ensure t)

;;; Automatically fetch projects
(use-package
  projectile-git-autofetch
  :init (projectile-git-autofetch-mode 1)
  :custom
  (projectile-git-autofetch-projects 'open))

;; -Projectile

;; Treemacs
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
		  treemacs-eldoc-display                 'simple
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
		  treemacs-width                         30
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

;;; Evil Integration
(use-package
  treemacs-evil
  :after (treemacs evil)
  :ensure t)

;;; Projectile Integration
(use-package
  treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

;;; Magit Integration
(use-package
  treemacs-magit
  :after (treemacs magit)
  :ensure t)

;;; Icons
(use-package
  treemacs-nerd-icons
  :ensure t
  :config
  (treemacs-load-theme "nerd-icons"))

(use-package
  treemacs-icons-dired
  :after (treemacs dired)
  :ensure t
  :config (treemacs-icons-dired-mode))

;;; Open current dir at Treemacs
(defun my/treemacs-client-setup (frame)
  "If a new client frame opens with a dired buffer (e.g. from `emacsclient -nc .`), open Treemacs."
  (select-frame-set-input-focus frame)
  (with-selected-frame frame
    ;; Delay to allow frame/buffers to fully initialize
    (run-at-time
     "0.3 sec" nil
     (lambda ()
       (let* ((dired-buf
	       (seq-find (lambda (buf)
			   (with-current-buffer buf
			     (and (eq major-mode 'dired-mode)
				  (file-directory-p default-directory))))
			 (buffer-list frame))))
	 (if dired-buf
	     (let* ((dir (with-current-buffer dired-buf default-directory))
		    (dirname (file-name-nondirectory (directory-file-name dir))))
	       (message "Dired buffer detected for directory: %s\nName: %s" dir dirname)
	       ;; You could call treemacs, e.g.:
	       (treemacs-add-and-display-current-project-exclusively)
	       ;; (treemacs-add-project-to-workspace dir dirname)
	       (treemacs-select-window)
	       ;; (treemacs-add-and-display-current-project-exclusively)
	       (kill-buffer dired-buf) ;; Optional: close dired buffer
	       )
	   (message "No dired buffer with a directory found in new frame.")))))))

(add-hook 'after-make-frame-functions #'my/treemacs-client-setup)
;; -Treemacs

;; GeneralSettings
(use-package
  dotenv-mode
  :ensure t
)
(add-to-list 'auto-mode-alist '("\\.env\\..*\\'" . dotenv-mode))

(use-package
  editorconfig
  :ensure t)
;; -GeneralSettings

(provide 'ide)
;;; ide.el ends here
