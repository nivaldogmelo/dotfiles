;;; init-cpp.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs c/cpp configuration
;;
;;; Code:


;; LanguageLsp
(defun setup-lsp-cpp ()
  (progn
    (lsp-register-client
     (make-lsp-client :new-connection (lsp-tramp-connection "clangd")
		:major-modes '(c-mode)
		:remote? t
		:server-id 'clangd-remote))
    (lsp-deferred)))

(add-hook 'c-mode-hook #'setup-lsp-cpp)
(add-hook 'c++-mode-hook #'setup-lsp-cpp)
;; -LanguageLsp

;; DapMode
(add-to-list 'load-path "~/.emacs.d/custom-libs/cpp")
(require 'dap-cpptools)
;; -DapMode


(provide 'init-cpp)
;;; init-cpp.el ends here
