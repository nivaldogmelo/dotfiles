;;; qol.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Configuration that improves quality of life in Emacs
;;
;;; Code:

;; KeybindsConfiguration

(global-set-key (kbd "C-c k") 'kill-buffer-and-window)

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
  ("C-i" . 'evil-normal-state)
  ("<f9>" . 'evil-local-mode))

(use-package
  evil-collection
  :ensure t
  :init (setq evil-collection-setup-minibuffer t))

(when (not (display-graphic-p))
  (global-set-key (kbd "C-c q") 'evil-normal-state)
)
;; -KeybindsConfiguration

;; GeneralQOL

;;; Remember last place in file
(save-place-mode 1)

;;; MouseSupport
(xterm-mouse-mode 1)

(when (not (display-graphic-p))
  (setq xterm-mouse-mode t)
)

;;; Show possible keybindings
(use-package
  which-key
  :ensure t)
(which-key-mode)

;;; Hide unnecessary mode line indicators
(use-package
  diminish
  :ensure t)

;;; Undo Changes
(use-package
  undo-tree
  :diminish unto-tree-mode
  :init (global-undo-tree-mode)
  :config
  (evil-set-undo-system 'undo-tree)
  :custom
  (undo-tree-visualizer-diff t)
  (undo-tree-history-directory-alist `(("." . ,(expand-file-name ".backup" user-emacs-directory))))
  (undo-tree-visualizer-timestamps t))

;;; Autoclose Parens
(use-package smartparens
  :ensure smartparens  ;; install the package
  :hook (prog-mode text-mode markdown-mode) ;; add `smartparens-mode` to these hooks
  :config
  ;; load default config
  (require 'smartparens-config))

;;; Wrap surroundings in evil mode `veS"`
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))


;;; Display Line Numbers
(add-hook 'prog-mode-hook (lambda () (display-line-numbers-mode 1)))
(add-hook 'text-mode-hook (lambda () (display-line-numbers-mode 1)))

(defun my/display-set-relative ()
  (setq display-line-numbers 'relative))     ; or 'visual

(defun my/display-set-absolute ()
  (setq display-line-numbers t))

(add-hook 'evil-insert-state-entry-hook #'my/display-set-absolute)
(add-hook 'evil-insert-state-exit-hook #'my/display-set-relative)

(use-package iedit
  :ensure t)

;; -GeneralQOL

;; FileHandler

;;; Remember last place in file
(save-place-mode 1)

;;; Keep recent files list
(use-package recentf
  :hook (after-init . recentf-mode)
  :custom
  (recentf-max-saved-items 200)
  (recentf-exclude '((expand-file-name package-user-dir)
		      ".cache"
		      ".cask"
		      ".elfeed"
		      "recentf"
		      "bookmarks"
		      "COMMIT_EDITMSG\\'")))

;;; Revert buffers when the underlying file has changed
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

;; Delete Whitespace On Save
(add-hook 'before-save-hook 'whitespace-cleanup)
;; -FileHandler

;; Helm
(use-package
  helm
  :ensure t
  :bind
  ("M-x" . helm-M-x) ;; Bind helm to execute-extended-command
  ("C-x C-f" . helm-find-files) ;; Bind helm to find-file
  :config (helm-mode))


;;; XRef integration
(use-package
  helm-xref
  :ensure t)

;;; HelmKeybinds
(define-key evil-ex-shortcut-map "e" 'helm-find-files)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)
;; -Helm

;; LineMode
;;; Doomline
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-lsp-icon t)
  (doom-modeline-lsp t)
  (doom-modeline-indent-info nil)
  (doom-modeline-buffer-encoding nil)
  (doom-modeline-env-version t)
  (doom-modeline-buffer-file-name-style 'relative-to-project)
  (doom-modeline-vcs-display-function #'doom-modeline-vcs-name)
  (doom-modeline-vcs-max-length 15)
  (doom-modeline-height 20)
  (doom-modeline-modal t)
  (doom-modeline-modal-modern-icon t))

;;; Nyan Cat in mode line
(use-package nyan-mode
  :ensure t
  :hook (after-init . nyan-mode)
  :custom
  (nyan-animate-nyancat t)
  (nyan-animation-frame-interval 0.08)
  (nyan-wavy-trail t)
  (nyan-bar-length 20)
  :bind
  ("C-c n s" . 'nyan-start-music)
  ("C-c n t" . 'nyan-stop-music))
;; -LineMode

;; ProgModeKeybinds
(add-hook 'prog-mode-hook 'evil-local-mode)
(global-set-key (kbd "<f9>") 'evil-local-mode)
;; -ProgModeKeybinds

;; ManipulateWindows
(global-set-key (kbd "M-]") 'enlarge-window-horizontally)
(global-set-key (kbd "M-[") 'shrink-window-horizontally)
(global-set-key (kbd "M-o") 'split-window-horizontally)
;; -ManipulateWindows


(provide 'qol)
;;; qol.el ends here
