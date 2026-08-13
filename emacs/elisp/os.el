;;; os.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; How Emacs interacts with the operating system
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

;; AutoSaveFiles
(setq auto-save-file-name-transforms `((".*" ,(expand-file-name "saves" user-emacs-directory) t)))
;; -AutoSaveFiles


;; EnvSync
(exec-path-from-shell-initialize)
;; -EnvSync

;; RipGrep
(use-package
  rg
  :ensure t)
;; -RipGrep

(provide 'os)
;;; os.el ends here
