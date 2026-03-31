;;; lang-yaml.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs yaml configuration
;;
;;; Code:

;; Mode
(use-package
  yaml-mode
  :ensure t
  :config
  (font-lock-add-keywords 'yaml-mode
			  `((,yaml-hash-key-re . (1 font-lock-function-name-face)))))


(provide 'lang-yaml)
;;; lang-yaml.el ends here
