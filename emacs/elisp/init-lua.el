;;; init-lua.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs lua configuration
;;
;;; Code:


;; LuaMode
(use-package
  lua-mode
  :ensure t)
;; -LuaMode

;; LuaLsp
(defun setup-lsp-lua ()
  (progn
    (setq lsp-clients-lua-language-server-bin "/usr/bin/lua-language-server")
    (setq lsp-clients-lua-language-server-install-dir "/usr/lib/lua-language-server/")
    (lsp-deferred)))

(add-hook 'lua-mode-hook #'setup-lsp-lua)
;; -LuaLsp


(provide 'init-lua)
;;; init-lua.el ends here
