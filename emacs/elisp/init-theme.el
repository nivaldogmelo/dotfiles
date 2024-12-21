;;; init-theme.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs theme configuration
;;
;;; Code:


;; ThemeEmacs
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'dracula-pro-vanhelsing t)

;; Fonts
;; (set-frame-font "Cascadia Code")
(set-frame-font "CaskaydiaCove Nerd Font")

(use-package
  nerd-icons
  :ensure t)

(use-package
  nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

;; Icons in GUI
;; (use-package
;;   all-the-icons
;;   :ensure t)
;; -ThemeEmacs


(provide 'init-theme)
;;; init-theme.el ends here
