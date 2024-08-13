;;; init-cl.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs Common Lisp configuration
;;
;;; Code:


;; CommonLispMode
(use-package
  adjust-parens
  :ensure t)
(add-hook 'lisp-mode-hook #'adjust-parens-mode)

;; Snippets
(use-package
  common-lisp-snippets
  :ensure t)
;; -CommonLispMode


(provide 'init-cl)
;;; init-cl.el ends here
