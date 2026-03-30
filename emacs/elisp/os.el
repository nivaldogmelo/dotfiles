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


;; EnvSync
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(exec-path-from-shell-initialize)
;; -EnvSync

;; RipGrep
(use-package
  rg
  :ensure t)
;; -RipGrep

(provide 'os)
;;; os.el ends here
