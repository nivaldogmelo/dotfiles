;;; init-dired.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs dired configuration
;;
;;; Code:


;; Dired

;; Revert buffers when the underlying file has changed
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

;; -Dired


(provide 'init-dired)
;;; init-dired.el ends here
