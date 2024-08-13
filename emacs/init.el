;;; init.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs Configuration
;;
;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Setup ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up load path
(defun update-load-path (folder)
  "Add FOLDER to the load path."
  (add-to-list 'load-path folder)
  (dolist (f (directory-files folder))
    (let ((name (concat folder "/" f)))
      (when (and (file-directory-p name)
		 (not (string-prefix-p "." f))
		 (not (string-prefix-p ".." f)))
	(update-load-path name)))))

(update-load-path (expand-file-name "elisp" user-emacs-directory))
(update-load-path (expand-file-name "custom-libs" user-emacs-directory))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; GC ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package
  gcmh
  :ensure t
  :config
  (setq gcmh-high-cons-threshold (* 128 1000 1000))
  (setq gcmh-verbose t)
  (gcmh-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Load ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Package Management
(require 'init-packages)

;; Asynchronous processing
(require 'init-async)

;; General Config
(require 'init-general)

(require 'init-rss)

(require 'init-evil)

(require 'init-undo)

(require 'init-helm)

(require 'init-vterm)

(require 'init-tramp)

;; UI
(require 'init-ui)

(require 'init-doomline)

(require 'init-theme)

;; Keybinds
(require 'init-keybinds)

;; Text Editing
(require 'init-org)

(require 'init-markdown)

;; General Programming
(require 'init-programming)

(require 'init-yasnippet)

(require 'init-magit)

(require 'init-projectile)

(require 'init-treemacs)

(require 'init-lsp)

(require 'init-flycheck)

(require 'init-company)

(require 'init-copilot)

;; Programming Languages

(require 'init-elisp)

(require 'init-go)

(require 'init-rust)

(require 'init-terraform)

(require 'init-python)

(require 'init-arduino)

(require 'init-cpp)

(require 'init-cl)

(require 'init-docker)

(require 'init-yaml)

(require 'init-nginx)

(require 'init-lua)

(provide 'init)
;;; init.el ends here
