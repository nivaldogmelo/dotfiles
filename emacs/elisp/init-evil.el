;;; init-evil.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs evil configuration
;; Need to be called before undo-tree
;;
;;; Code:


;; EvilEmacs
;;
(use-package
  evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-esc-delay 0)
  :hook
  (prog-mode . evil-local-mode)
  :bind
  ("<f9>" . 'evil-local-mode))

;; Setup Evil Collection
(use-package
  evil-collection
  :ensure t
  :init (setq evil-collection-setup-minibuffer t))
;; -EvilEmacs


(provide 'init-evil)
;;; init-evil.el ends here
