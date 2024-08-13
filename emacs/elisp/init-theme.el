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
(set-frame-font "Cascadia Code")

;; Icons in GUI
(use-package
  all-the-icons
  :ensure t)
;; -ThemeEmacs


(provide 'init-theme)
;;; init-theme.el ends here
