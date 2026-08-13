;;; terminal.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs configuration to provide a terminal interface
;;
;;; Code:

;; Ghostel
(use-package
  ghostel
  :ensure t
  :bind (
    :map project-prefix-map
     ("m" . ghostel-project)
     ("M" . ghostel-project-list-buffers)
  )
  :config
  (evil-set-initial-state 'ghostel-mode 'emacs)
)
;; -Ghostel

(provide 'terminal)
;;; terminal.el ends here
