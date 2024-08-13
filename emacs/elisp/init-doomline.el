;;; init-doomline.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs doomline configuration
;;
;;; Code:


;; Doomline

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-buffer-file-name-style 'relative-to-project)
  (doom-modeline-vcs-display-function #'doom-modeline-vcs-name)
  (doom-modeline-vcs-max-length 15)
  (doom-modeline-height 20)
  (doom-modeline-modal t)
  (doom-modeline-modal-modern-icon t))

;; -Doomline


(provide 'init-doomline)
;;; init-doomline.el ends here
