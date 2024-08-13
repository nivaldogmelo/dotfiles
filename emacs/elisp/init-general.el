;;; init-general.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs general configuration
;;
;;; Code:


;; Backupfiles
(setq backup-directory-alist `(("." . ,(expand-file-name "backups" user-emacs-directory))))
;; Slower but safer
;; (setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)
;; -BackupFiles

;; History
(use-package recentf
  :hook (after-init . recentf-mode)
  :custom
  (recentf-max-saved-items 200)
  (recentf-exclude '((expand-file-name package-user-dir)
		      ".cache"
		      ".cask"
		      ".elfeed"
		      "recentf"
		      "bookmarks"
		      "COMMIT_EDITMSG\\'")))

;; Remember last place in file
(save-place-mode 1)

;; -History

;; CustomSetVariables
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)
;; -CustomSetVariables


;; MouseSupport
(xterm-mouse-mode 1)
;; -MouseSupport

;; Helpers
(use-package
  diminish
  :ensure t)

(use-package
  which-key
  :ensure t)
(which-key-mode)
;; -Helpers

;; AutocloseParens
(use-package smartparens
  :ensure smartparens  ;; install the package
  :hook (prog-mode text-mode markdown-mode) ;; add `smartparens-mode` to these hooks
  :config
  ;; load default config
  (require 'smartparens-config))
;; -AutocloseParens


(provide 'init-general)
;;; init-general.el ends here
