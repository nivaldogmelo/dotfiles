;;; init-keybinds.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs keybinds configuration
;;
;;; Code:


;; HelmKeybinds
(define-key evil-ex-map "e" 'helm-find-files)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)
;; -HelmKeybinds

;; ProgModeKeybinds
(add-hook 'prog-mode-hook 'evil-local-mode)
(global-set-key (kbd "<f9>") 'evil-local-mode)
;; -ProgModeKeybinds


(provide 'init-keybinds)
;;; init-keybinds.el ends here
