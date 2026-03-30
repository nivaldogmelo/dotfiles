;;; init-internal.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs configs for internal improvements
;;
;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GC Setup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (use-package
;;   gcmh
;;   :ensure t
;;   :config
;;   (setq gcmh-high-cons-threshold (* 128 1000 1000))
;;   (setq gcmh-verbose t)
;;   (gcmh-mode 1))

(use-package gc-maybe
  :vc (:url "https://github.com/bcardoso/gc-maybe/")
  :demand t
  :config
  ;; Default values
  (setopt gc-maybe-cons-threshold (* 200 1024 1024))
  (setopt gc-maybe-cons-percentage 0.2)
  (setopt gc-maybe-idle-delay 8)
  (setopt gc-maybe-idle-restore 5)

  ;; Enable mode to set the idle timer and minibuffer hooks
  (gc-maybe-mode +1)

  ;; Optionally log GC data in a buffer
  ;; (setopt gc-maybe-log-stats-in-buffer t)

  ;; Advice example
  ;; (advice-add 'org-ql-select :before #'gc-maybe-raise-threshold-briefly)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Async Setup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; AsyncEmacs
(use-package
  async
  :ensure t
  :config
  (autoload 'dired-async-mode "dired-async.el" nil t)
  (async-bytecomp-package-mode 1)
  (dired-async-mode 1))
;; -AsyncEmacs

;; UI

;;; Clean up UI
(tool-bar-mode -1)
(scroll-bar-mode -1)

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

;; -UI

(provide 'init-internal)
;;; init-internal.el ends here
