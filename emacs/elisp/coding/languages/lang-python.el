;;; lang-python.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs python configuration
;;
;;; Code:

;; LSP Setup
;; Requires `pip install -U jedi-language-server`
(use-package
  lsp-jedi
  :ensure t)
(add-hook 'python-mode-hook #'lsp-deferred)

;; Jupyter Configs
(use-package
  ein
  :ensure t)

;; Debugger
(require 'dap-python)

(setq dap-python-debugger 'debugpy)

(provide 'lang-python)
;;; lang-python.el ends here
