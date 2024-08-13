;;; init-python.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs python configuration
;;
;;; Code:


;; PythonLsp
;; Requires `pip install -U jedi-language-server`
(use-package
  lsp-jedi
  :ensure t)
(add-hook 'python-mode-hook #'lsp-deferred)
;; -PythonLsp


(provide 'init-python)
;;; init-python.el ends here
