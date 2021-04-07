(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes '(misterioso))
 '(custom-safe-themes
   '("2540689fd0bc5d74c4682764ff6c94057ba8061a98be5dd21116bf7bf301acfb" default))
 '(fci-rule-color "#14151E")
 '(jdee-server-dir "/home/nivaldogmelo/.emacs.d/jdee-server")
 '(package-selected-packages
   '(which-key simple-httpd treemacs-all-the-icons pyvenv elpy flycheck company-lsp yasnippet lsp-ui lsp-mode lua-mode oauth2 company-irony jenkins-watch ac-slime slime dockerfile-mode yafolding origami groovy-mode ac-html web-mode company-terraform company-go company grip-mode markdown-mode terraform-mode jdee auto-complete yaml-mode parrot docker kubernetes minimap smartparens smartparens-config kaolin-themes treemacs-magit treemacs-icons-dired centaur-tabs go-complete flymake-go flycheck-gometalinter go-autocomplete go-mode wakatime-mode afternoon-theme aggressive-indent bash-completion powerline))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#d54e53")
     (40 . "goldenrod")
     (60 . "#e7c547")
     (80 . "DarkOliveGreen3")
     (100 . "#70c0b1")
     (120 . "DeepSkyBlue1")
     (140 . "#c397d8")
     (160 . "#d54e53")
     (180 . "goldenrod")
     (200 . "#e7c547")
     (220 . "DarkOliveGreen3")
     (240 . "#70c0b1")
     (260 . "DeepSkyBlue1")
     (280 . "#c397d8")
     (300 . "#d54e53")
     (320 . "goldenrod")
     (340 . "#e7c547")
     (360 . "DarkOliveGreen3")))
 '(vc-annotate-very-old-color nil)
 '(wakatime-cli-path "/usr/bin/wakatime")
 '(wakatime-python-bin nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
          Your version of Emacs does not support SSL connections,
          which is unsafe because it allows man-in-the-middle attacks.
          There are two things you can do about this warning:
          1. Install an Emacs version that does support SSL and be safe.
          2. Remove this warning from your init file so you won't see it again."))
          ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
          (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
          ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
          (when (< emacs-major-version 24)
            ;; For important compatibility libraries like cl-lib
            (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; Enable line numbers
(global-linum-mode 1)
;; Mapping to navigate between windows
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)
;; Set window split on vertical as default
(setq split-width-threshold 1)
;; Set bind to change window split
(global-set-key (kbd "C-x |") 'toggle-window-split)
;; Auto-refresh bufffers
(global-auto-revert-mode t)
;; Uncomment region
(global-set-key (kbd "C-;") 'comment-dwim)
;; Untabify except on Makefiles
(defun untabify-except-makefiles ()
  "Replace tabs with spaces except in makefiles."
  (unless (derived-mode-p 'makefile-mode)
    (untabify (point-min) (point-max))))
(add-hook 'before-save-hook 'untabify-except-makefiles)
;; Setup for exercism
(setq-default indent-tabs-mode nil)

(global-wakatime-mode)

;(autoload 'enable-paredit-mode "paredit"
;  "Turn on pseudo-structural editing of Lisp code."
;  t)
;(add-hook 'emacs-lisp-mode-hook       'enable-paredit-mode)
;(add-hook 'lisp-mode-hook             'enable-paredit-mode)
;(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
;(add-hook 'scheme-mode-hook           'enable-paredit-mode)

;; Write backupds to ~/.emacs.d/backup/
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying      t  ; Don't de-link hard links
      version-control        t  ; Use version numbers on backups
      delete-old-versions    t  ; Automatically delete excess backups
      kept-new-versions      20 ; How many of the newest versions to keep
      kept-old-version       5) ; How many of the old versions to keep


(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
    (let* ((this-win-buffer (window-buffer))
           (next-win-buffer (window-buffer (next-window)))
           (this-win-edges (window-edges (selected-window)))
           (next-win-edges (window-edges (next-window)))
           (this-win-2nd (not (and (<= (car this-win-edges)
                                       (car next-win-edges))
                                   (<= (cadr this-win-edges)
                                       (cadr next-win-edges)))))
           (splitter
             (if (= (car this-win-edges)
                    (car (window-edges (next-window))))
               'split-window-horizontally
               'split-window-vertically)))
      (delete-other-windows)
      (let ((first-win (selected-window)))
        (funcall splitter)
        (if this-win-2nd (other-window 1))
        (set-window-buffer (selected-window) this-win-buffer)
        (set-window-buffer (next-window) next-win-buffer)
        (select-window first-win)
        (if this-win-2nd (other-window 1))))))

;; Emacs get environment variables from host
(use-package exec-path-from-shell
  :ensure t)
(exec-path-from-shell-initialize)

;; Install all-the-icons
(use-package all-the-icons
  :ensure t)

;; Install projectile
(use-package projectile
  :ensure t
  :bind
    (:map global-map
      ("C-x a" . projectile-add-known-project)
      ("C-x d" . projectile-remove-known-project)
      ("C-x x" . projectile-test-project)
      ("C-x c" . projectile-compile-project)
      ("C-x r" . projectile-run-project)
      ("C-x e" . projectile-replace)))

(projectile-mode +1)

;; Install treemacs
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                 (if (treemacs--find-python3) 3 0)
      treemacs-deferred-git-apply-delay      0.5
      treemacs-display-in-side-window        t
      treemacs-eldoc-display                 t
      treemacs-file-event-delay              5000
      treemacs-file-follow-delay             0.2
      treemacs-follow-after-init             t
      treemacs-git-command-pipe              ""
      treemacs-goto-tag-strategy             'refetch-index
      treemacs-is-never-other-window         nil
      treemacs-max-git-entries               5000
      treemacs-missing-project-action        'ask
      treemacs-no-png-images                 nil
      treemacs-no-delete-other-windows       t
      treemacs-project-follow-cleanup        nil
      treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
      treemacs-recenter-distance             0.1
      treemacs-recenter-after-file-follow    nil
      treemacs-recenter-after-tag-follow     nil
      treemacs-recenter-after-project-jump   'always
      treemacs-recenter-after-project-expand 'on-distance
      treemacs-show-cursor                   nil
      treemacs-show-hidden-files             t
      treemacs-silent-filewatch              nil
      treemacs-silent-refresh                nil
      treemacs-sorting                       'alphabetic-desc
      treemacs-space-between-root-nodes      t
      treemacs-tag-follow-cleanup            t
      treemacs-tag-follow-delay              1.5)

  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-fringe-indicator-mode t)
  (pcase (cons (not (null (executable-find "git")))
               (not (null (treemacs--find-python3))))
    (`(t . t)
     (treemacs-git-mode 'deferred))
    (`(t . _)
     (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

;; Centaur tabs config
(use-package centaur-tabs
  :ensure t
  :demand
  :config
    (centaur-tabs-mode t)
    (centaur-tabs-headline-match)
    (setq centaur-tabs-style "wave")
    (setq centaur-tabs-set-icons t)
    (setq centaur-tabs-set-bar 'left)
    (setq centaur-tabs-height 32)
    (setq centaur-tabs-set-modified-marker t)
  :bind
    (:map global-map 
      ("C-x p" . centaur-tabs-backward)
      ("C-x n" . centaur-tabs-forward)))

;; Integration with projectile
(centaur-tabs-group-by-projectile-project)

;; Set kaolin-theme
(use-package kaolin-themes
  :ensure t
  :config
  (load-theme 'kaolin-dark t)
  (kaolin-treemacs-theme))
;; If t, enable italic style in comments.
(setq kaolin-themes-italic-comments t)
;; When t, will display colored hl-line style instead monochrome.     
(setq kaolin-themes-hl-line-colored t)       
;; Enable distinct background for fringe and line numbers.
(setq kaolin-themes-distinct-fringe t)  
;; Enable distinct colors for company popup scrollbar.
(setq kaolin-themes-distinct-company-scrollbar t)
;; Show git-gutter indicators as solid lines
(setq kaolin-themes-git-gutter-solid t)

;; Auto closes brackets/parenthesis/quotes
(use-package smartparens
  :ensure t)
(smartparens-global-mode 1)

;; Install Kubernetes-el
(use-package kubernetes
  :ensure t
  :commands (kubernetes-overview)
  :bind
  (:map global-map
        ("C-c k o" . kubernetes-overview)
        ("C-c k n" . kubernetes-set-namespace)
        ("C-c k d p" . kubernetes-describe-pod)
        ("C-c k e" . kubernetes-exec-into)
        ("C-c k l" . kubernetes-logs-follow)))

;; Install docker-el
(use-package docker
  :ensure t
  :bind ("C-c d" . docker))
(use-package dockerfile-mode
  :ensure t)

;; Parrot
(use-package parrot
  :ensure t
  :config
  (parrot-mode)
  (parrot-set-parrot-type 'default)
  :bind
    (:map global-map
          ("C-c p" . parrot-start-animation)))

;; Git integration
(use-package magit
  :ensure t
  :bind
  (:map global-map
        ("C-c g s" . magit-status)
        ("C-c g a" . magit-stage)
        ("C-c g C-a" . magit-unstage-file)
        ("C-c g C-r" . magit-unstage-all)
        ("C-c g l" . magit-log-current)
        ("C-c g c" . magit-commit-create)
        ("C-c g f" . magit-fetch-all)
        ("C-c g p" . magit-pull-from-upstream)
        ("C-c g b" . magit-branch)
        ("C-c g r" . magit-rebase)
        ("C-c g m" . magit-merge)
        ("C-c g o" . magit-push)))

;; lsp Config
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (go-mode . lsp-deferred))

;; Set up before-save hookts to format buffer and add/delete imports.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; Fancier overlays
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :init)


(setq lsp-ui-doc-enable nil
      lsp-ui-peek-enable t
      lsp-ui-sideline-enable t
      lsp-ui-imenu-enable t
      lsp-ui-flycheck-enable t)

;; Snippet support
(use-package yasnippet
  :ensure t
  :commands yas-minor-mode
  :hook (go-mode . yas-minor-mode))

;; Autocomplete
(use-package auto-complete
  :ensure t)
(use-package popup
  :ensure t)
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-lenght 1))
(add-hook 'after-init-hook 'global-company-mode)

(use-package company-lsp
  :ensure t
  :commands company-lsp)

;; C/C++ integration
(use-package company-irony
  :ensure t)
(eval-after-load 'company
                   '(add-to-list 'company-backends 'company-irony))

;; Yaml integration
(use-package yaml-mode
  :ensure t)

;; Terraform integration
(use-package terraform-mode
  :ensure t)
(use-package company-terraform
  :ensure t)
(company-terraform-init)

;; Golang integration
(use-package go-mode
  :ensure t)
(exec-path-from-shell-copy-env "GOPATH")
(add-hook 'completion-at-point-functions 'go-complete-at-point)
(add-to-list 'load-path "/home/nivaldogmelo/.emacs.d/custom-libs")
(setq go-fmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)

;; Java integration
(use-package jdee
  :ensure t)

;; Groovy integration
(use-package groovy-mode
  :ensure t)

;; Markdown integration
(use-package markdown-mode
  :ensure t)
(use-package grip-mode
  :ensure t
  :hook ((markdown-mode org-mode) . grip-mode))

;; HTML integration
(use-package web-mode
  :ensure t)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; Lisp integration
(use-package slime
  :ensure t)
(setq inferior-lisp-program "/usr/bin/sbcl")
(setq slime-contribs '(slime-fancy))
(use-package ac-slime
  :ensure t)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))

;; Lua integration
(use-package lua-mode
  :ensure t)

;; Python integration
(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable))

;; ReactJS integration
(use-package flycheck
  :ensure t)

(use-package avy
  :ensure t)

(use-package which-key
  :ensure t)
