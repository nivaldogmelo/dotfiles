;;; init-async.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs async configuration
;;
;;; Code:


;; AsyncEmacs
(use-package
  async
  :ensure t
  :config
  (autoload 'dired-async-mode "dired-async.el" nil t)
  (async-bytecomp-package-mode 1)
  (dired-async-mode 1))
;; -AsyncEmacs


(provide 'init-async)
;;; init-async.el ends here
