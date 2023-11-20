;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;;(package-refresh-contents)

;; Setup Use-Package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Misc ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mouse Support
(xterm-mouse-mode 1)

;; Enable line numbers
(add-hook 'prog-mode-hook (lambda () (display-line-numbers-mode 1)))
(add-hook 'text-mode-hook (lambda () (display-line-numbers-mode 1)))

;; Asynchronous processing
(use-package
  async
  :ensure t
  :config (autoload 'dired-async-mode "dired-async.el" nil t)
  (dired-async-mode 1))

;; Snippets
(use-package
  yasnippet
  :ensure t
  :config (yas-reload-all))
(add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
(use-package
  yasnippet-snippets
  :ensure t)

;; Auto closes brackets/parenthesis/quotes
(use-package
  smartparens
  :ensure t)
(smartparens-global-mode 1)

;; Handle Backup files
(setq backup-directory-alist `(("." . "~/.emacs_saves")))
;; Slower but safer
;; (setq backup-by-copying t)
(setq delete-old-versions t kept-new-versions 6 kept-old-versions 2 version-control t)

;; Delete whitespace on sabe
(add-hook 'before-save-hook 'whitespace-cleanup)

;; Make interface cleaner
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Remember recent files
(recentf-mode 1)

;; Remember last place in file
(save-place-mode 1)

;; Move customization variables to a separate file
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; Revert buffers when the underlying file has changed
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

;; Prevent undo tree files from polluting your git repo
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))

;;PDF Support
(use-package
  pdf-tools
  :defer t
  :commands (pdf-view-mode pdf-tools-install)
  :mode ("\\.[pP][dD][fF]\\'" . pdf-view-mode)
  :magic ("%PDF" . pdf-view-mode)
  :config
  (pdf-tools-install)
  (define-pdf-cache-function pagelabels)
  :hook ((pdf-view-mode-hook . (lambda () (display-line-numbers-mode -1)))
	 (pdf-view-mode-hook . pdf-tools-enable-minor-mode))
  :ensure t)

(use-package
  origami
  :ensure t
  :hook (prog-mode . origami-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Evil ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setup Evil
(use-package
  evil
  :ensure t
  :init (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-esc-delay 0))

;; Setup Evil Collection
(use-package
  evil-collection
  :ensure t
  :init (setq evil-collection-setup-minibuffer t))

;; Setup redo
(use-package
  undo-tree
  :ensure t
  :config (global-undo-tree-mode))

;; Bind undo-tree with evil-undo-system
(evil-set-undo-system 'undo-tree)

(add-hook 'prog-mode-hook 'evil-local-mode)
(global-set-key (kbd "<f9>") 'evil-local-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Helm ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Install
(use-package
  helm
  :ensure t
  :config (helm-mode)
  (global-set-key (kbd "M-x") 'helm-M-x) ;; Bind helm to execute-extended-command
  (global-set-key (kbd "C-x C-f") 'helm-find-files) ;; Bind helm to find-file
  )

(use-package
  helm-xref
  :ensure t)

;; Useful keybinds
(define-key evil-ex-map "e" 'helm-find-files)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Powerline ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Install
(use-package
  powerline
  :ensure t
  :config (powerline-default-theme))

;; Integrate with Evil
(use-package
  powerline-evil
  :ensure t)

(use-package
  airline-themes
  :ensure t
  ;; :config (load-theme 'airline-deus)
  :config (load-theme 'airline-base16_dracula)
  (setq airline-helm-colors t)
  (setq airline-hide-vc-branch-on-inactive-buffers t))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Terminal ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Install
(use-package
  vterm
  :ensure t)

;; Enable Yank
(add-hook 'vterm-mode-hook (lambda ()
			     (evil-define-key 'insert vterm-mode-map (kbd "C-c y") #'term-paste)
			     (evil-define-key 'normal vterm-mode-map (kbd "p") #'term-paste)))

;; Multiple instances
(use-package
  multi-vterm
  :ensure t
  :config (add-hook 'vterm-mode-hook (lambda ()
				       (setq-local evil-insert-state-cursor 'box)
				       (evil-insert-state)))
  (define-key vterm-mode-map [return]                      #'vterm-send-return)

  (setq vterm-keymap-exceptions nil)
  (evil-define-key 'insert vterm-mode-map (kbd "C-e")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-f")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-a")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-v")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-b")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-w")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-u")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-d")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-n")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-m")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-p")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-j")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-k")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-r")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-t")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-g")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-c")      #'vterm--self-insert)
  (evil-define-key 'insert vterm-mode-map (kbd "C-SPC")    #'vterm--self-insert)
  (evil-define-key 'normal vterm-mode-map (kbd "C-d")      #'vterm--self-insert)
  (evil-define-key 'normal vterm-mode-map (kbd ",c")       #'multi-vterm)
  (evil-define-key 'normal vterm-mode-map (kbd ",n")       #'multi-vterm-next)
  (evil-define-key 'normal vterm-mode-map (kbd ",p")       #'multi-vterm-prev)
  (evil-define-key 'normal vterm-mode-map (kbd "i")        #'evil-insert-resume)
  (evil-define-key 'normal vterm-mode-map (kbd "o")        #'evil-insert-resume)
  (evil-define-key 'normal vterm-mode-map (kbd "<return>") #'evil-insert-resume)
  (setq multi-vterm-dedicated-window-height-percent 30))

(evil-global-set-key 'normal (kbd "zi") 'multi-vterm-dedicated-toggle)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Tramp ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setup gcloud ssh
(add-to-list 'tramp-methods '("gssh" (tramp-login-program        "gssh")
			      (tramp-login-args           (("%h")))
			      (tramp-async-args           (("-q")))
			      (tramp-remote-shell         "/bin/sh")
			      (tramp-remote-shell-args    ("-c"))
			      (tramp-gw-args              (("-o" "GlobalKnownHostsFile=/dev/null")
							   ("-o" "UserKnownHostsFile=/dev/null")
							   ("-o" "StrictHostKeyChecking=no")))
			      (tramp-default-port         22)))

;; Speed Up
(setq remote-file-name-inhibit-cache nil)
(setq vc-ignore-dir-regexp (format "%s\\|%s" vc-ignore-dir-regexp tramp-file-name-regexp))
(setq tramp-verbose 1)
;; (setq projectile-mode-line "Projectile")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Elisp ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Format
(use-package
  elisp-format
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Org ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Evil integration
(use-package
  evil-org
  :ensure t
  :after org
  :hook (org-mode . evil-org-mode)
  :config (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

;; Language integration
(use-package
  ob-go
  :ensure t)

(org-babel-do-load-languages 'org-babel-load-languages '((emacs-lisp . t)
							 (go . t)
							 (python . t)
							 (shell . t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Magit ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Instalation
(use-package
  magit
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Projectile ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Install
(use-package
  projectile
  :ensure t
  :init (projectile-mode +1)
  :bind (:map projectile-mode-map
	      ("C-c p" . projectile-command-map)))

;; Automated Project Discovery
(setq projectile-project-search-path '("~/code/"))

;; Useful keybinds
(define-key evil-ex-map "g" 'helm-projectile-grep)
(define-key evil-ex-map "f" 'helm-projectile-find-file)

;; Helm integration
(use-package
  helm-projectile
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Treemacs ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package
  treemacs
  :ensure t
  :defer t
  :init (with-eval-after-load 'winum (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config (progn
	    (setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
		  treemacs-deferred-git-apply-delay      0.5 treemacs-directory-name-transformer
		  #'identity treemacs-display-in-side-window        t treemacs-eldoc-display t
		  treemacs-file-event-delay              5000 treemacs-file-extension-regex
		  treemacs-last-period-regex-value treemacs-file-follow-delay             0.2
		  treemacs-file-name-transformer         #'identity treemacs-follow-after-init t
		  treemacs-expand-after-init             t treemacs-git-command-pipe ""
		  treemacs-goto-tag-strategy             'refetch-index treemacs-indentation 2
		  treemacs-indentation-string            " " treemacs-is-never-other-window nil
		  treemacs-max-git-entries               5000 treemacs-missing-project-action 'ask
		  treemacs-move-forward-on-expand        nil treemacs-no-png-images nil
		  treemacs-no-delete-other-windows       t treemacs-project-follow-cleanup nil
		  treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist"
									   user-emacs-directory)
		  treemacs-position                      'left treemacs-read-string-input
		  'from-child-frame treemacs-recenter-distance             0.1
		  treemacs-recenter-after-file-follow    nil treemacs-recenter-after-tag-follow nil
		  treemacs-recenter-after-project-jump   'always
		  treemacs-recenter-after-project-expand 'on-distance treemacs-litter-directories
		  '("/node_modules" "/.venv" "/.cask") treemacs-show-cursor                   nil
		  treemacs-show-hidden-files             t treemacs-silent-filewatch nil
		  treemacs-silent-refresh                nil treemacs-sorting 'alphabetic-asc
		  treemacs-space-between-root-nodes      t treemacs-tag-follow-cleanup            t
		  treemacs-tag-follow-delay 1.5 treemacs-user-mode-line-format         nil
		  treemacs-user-header-line-format nil treemacs-width                         35
		  treemacs-width-is-initially-locked t Treemacs-workspace-switch-cleanup      nil)
	    (treemacs-follow-mode t)
	    (treemacs-filewatch-mode t)
	    (treemacs-git-commit-diff-mode t)
	    (treemacs-fringe-indicator-mode 'always)
	    (pcase (cons (not (null (executable-find "git")))
			 (not (null treemacs-python-executable)))
	      (`(t . t)
	       (treemacs-git-mode 'deferred))
	      (`(t . _)
	       (treemacs-git-mode 'simple))))
  :bind (:map global-map
	      ("M-0"       . treemacs-select-window)
	      ("C-x t 1"   . treemacs-delete-other-windows)
	      ("C-x t t"   . treemacs)
	      ("C-x t B"   . treemacs-bookmark)
	      ("C-x t C-t" . treemacs-find-file)
	      ("C-x t M-t" . treemacs-find-tag)))

(use-package
  treemacs-evil
  :after (treemacs-evil)
  :ensure t)

(use-package
  treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package
  treemacs-icons-dired
  :after (treemacs dired)
  :ensure t
  :config (treemacs-icons-dired-mode))

(use-package
  treemacs-magit
  :after (treemacs magit)
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Theme ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Modus Themes
(use-package
  modus-themes
  :ensure t)

;; Modus theme customization
;;;; Mode Line
(setq modus-themes-mode-line '(accented borderless padded))
(setq modus-themes-variable-pitch-ui t)

;;;; Selection Regions
(setq modus-themes-region '(bg-only))

;;;; Syntax highlighting
(setq modus-themes-bold-constructs t)
(setq modus-themes-italic-constructs t)
(setq modus-themes-paren-match '(bold intense))
(setq modus-themes-syntax '(alt-syntax))
(setq modus-themes-lang-checkers '(background straight-underline))
(setq modus-themes-completions '((matches . (extrabold intense))
				 (selection . (semibold))
				 (popup . (accented))))

;; Load Theme
(use-package
  doom-themes
  :ensure t
  :config (setq doom-themes-enable-bold t doom-themes-enable-italic t)
  ;; (load-theme 'modus-operandi t)
  ;; (load-theme 'doom-dracula t)

  ;; Flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom treemacs theme (all-the-icons is required)
  (setq doom-themes-treemacs-theme "doom-dracula")
  ;; Correct org-mode's native fontification
  (doom-themes-org-config))

(defun light-mode ()
  (interactive)
  (load-theme 'doom-solarized-light))

(defun dark-mode ()
  (interactive)
  (load-theme 'doom-acario-dark))

(defun blue-mode ()
  (interactive)
  (load-theme 'doom-solarized-dark))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'dracula-pro-vanhelsing t)

;; Fonts
(set-frame-font "Cascadia Code")

;; Icons in GUI
(use-package
  all-the-icons
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Email ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load
					;(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
					;(require 'mu4e)

;; Enable alerts
					;(use-package mu4e-alert
					;  :ensure t
					;  :after mu4e
					;  :init
					;  (setq mu4e-alert-interesting-mail-query
					;	"flag:unread maildir:/INBOX")
					;  (mu4e-alert-enable-mode-line-display)
					;  (mu4e-alert-enable-notifications))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; LSP ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package
  which-key
  :ensure t)
(which-key-mode)

;; Install
(use-package
  lsp-mode
  :ensure t
  :init (setq lsp-keymap-prefix "C-c l")
  :config (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 1024))
  :commands (lsp lsp-deferred))

;; UI
(use-package
  lsp-ui
  :ensure t
  :config (setq lsp-ui-sideline-enable t)
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-peek-enable t)
  (setq lsp-ui-imenu-enable t)
  (setq lsp-ui-flycheck-enable t))

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))

;; Debug
(use-package
  dap-mode
  :ensure t
  :config (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (tooltip-mode 1)
  (dap-ui-controls-mode 1))

(add-to-list 'load-path "~/.emacs.d/custom-libs/go")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Syntax Check ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package
  flycheck
  :ensure t
  :init (global-flycheck-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Company Mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package
  company
  :ensure t
  :config (setq company-tooltip-limit 20)
  (setq company-idle-delay .3)
  (setq company-echo-delay 0)
  (setq company-begin-commands '(self-insert-command)))

;; Enable in all buffers
(add-hook 'after-init-hook 'global-company-mode)

;; Enable quickhelp buffer
(use-package
  company-quickhelp
  :ensure t)

(use-package
  company-quickhelp-terminal
  :ensure t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; GO ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Install mode
(use-package
  go-mode
  :ensure t)

;; Company Backend
(use-package
  company-go
  :ensure t)

(add-hook 'go-mode-hook (lambda ()
			  (set (make-local-variable 'company-backends)
			       '(company-go))
			  (company-mode)))
;; Save hooks
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; Load LSP
(add-hook 'go-mode-hook #'lsp-deferred)
(lsp-register-custom-settings '(("gopls.completeUnimported" t t)
				("gopls.usePlaceholders" t t)
				("gopls.staticcheck" t t)))

;; Projectile settings
(use-package
  go-projectile
  :ensure t)
(go-projectile-tools-add-path)
(setq go-projectile-tools
  '((gocode    . "github.com/mdempsky/gocode")
    (golint    . "golang.org/x/lint/golint")
    (godef     . "github.com/rogpeppe/godef")
    (errcheck  . "github.com/kisielk/errcheck")
    (godoc     . "golang.org/x/tools/cmd/godoc")
    (gogetdoc  . "github.com/zmb3/gogetdoc")
    (goimports . "golang.org/x/tools/cmd/goimports")
    (gorename  . "golang.org/x/tools/cmd/gorename")
    (gomvpkg   . "golang.org/x/tools/cmd/gomvpkg")
    (guru      . "golang.org/x/tools/cmd/guru")))

;; Yasnippets
;; (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets/yasnippet-go")
(add-hook 'go-mode-hook #'yas-minor-mode)

;; Setup CTAGS
;; To initialize a project run gotags -R=true * > GOTAGS
;; Then run M-x customize-group RET me.alpheus/gotags and setup me.alpheus/gotags-tags-file
;; to the generated GOTAGS
(add-to-list 'load-path "~/.emacs.d/custom-libs/go")
(require 'me-alpheus-gotags)
(require 'dap-dlv-go)
(evil-define-key 'normal go-mode-map (kbd "gh") 'me.alpheus/gotags/tag-search)

;; Projectile config
(projectile-register-project-type 'go '("go.mod")
				  :project-file "go.mod"
				  :compile "go build"
				  :test "go test ./..."
				  :run "go run main.go"
				  :test-suffix "_test")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Rust ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package
  rustic
  :ensure t
  :bind (:map rustic-mode-map
	      ("M-j" . lsp-ui-imenu)
	      ("C-c C-c f" . lsp-find-references)
	      ("C-c C-c l" . flycheck-list-errors)
	      ("C-c C-c a" . lsp-execute-code-action)
	      ("C-c C-c r" . lsp-rename)
	      ("C-c C-c q" . lsp-workspace-restart)
	      ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  ;; uncomment for less flashiness
  ;; (setq lsp-eldoc-hook nil)
  ;; (setq lsp-enable-symbol-highlighting nil)
  ;; (setq lsp-signature-auto-activate nil)

  ;; comment to disable fustfmt on save
  (setq rustic-format-on-sabe t)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

(add-hook 'rustic-mode-hook #'yas-minor-mode)

(defun rk/rustic-mode-hook ()
  ;; so that run C-c C-c C-r works without having to confirm, but don't try to
  ;; save rust buffers that are not file visiting. Once
  ;; https://github.com/brotzeit/rustic/issues/253 has been resolved this should
  ;; no longer be necessary.
  (when buffer-file-name
    (setq-local buffer-save-without-query t))
  (add-hook 'before-save-hook 'lsp-format-buffer nil t))

;; Load LSP
(add-hook 'rustic-mode-hook #'lsp-deferred)
(lsp-register-custom-settings '((lsp-rust-analyzer-cargo-watch-command "clippy")
				(lsp-eldoc-render-all t)
				(lsp-idle-delay 0.6)
				;; enable / disable the hints as you prefer:
				(lsp-inlay-hint-enable t)
				;; These are optional configurations. See https://emacs-lsp.github.io/lsp-mode/page/lsp-rust-analyzer/#lsp-rust-analyzer-display-chaining-hints for a full list
				(lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
				(lsp-rust-analyzer-display-chaining-hints t)
				(lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
				(lsp-rust-analyzer-display-closure-return-type-hints t)
				(lsp-rust-analyzer-display-parameter-hints nil)
				(lsp-rust-analyzer-display-reborrow-hints nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Terraform ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Install mode
(use-package
  terraform-mode
  :ensure t)

;; Company Backend
(use-package
  company-terraform
  :ensure t)

(add-hook 'terraform-mode-hook (lambda ()
				 (set (make-local-variable 'company-backends)
				      '(company-terraform))
				 (company-mode)))
(add-hook 'terraform-mode-hook (lambda ()
				 (company-terraform-init)))

;; Documentation access
(use-package
  terraform-doc
  :ensure t)

;; Load LSP
(lsp-register-client
  (make-lsp-client :new-connection (lsp-stdio-connection '("/usr/bin/terraform-ls" "serve"))
		   :major-modes '(terraform-mode)
		   :server-id 'terraform-ls))
(add-hook 'terraform-mode-hook #'lsp-deferred)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; C/C++ ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LSP Server
;; (use-package
;;   eglot
;;   :ensure t)
;; (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
;; (add-hook 'c-mode-hook 'eglot-ensure)
;; (add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)


;; Yasnippets
(add-hook 'c-mode-hook #'yas-minor-mode)
(add-hook 'c++-mode-hook #'yas-minor-mode)

;; DAP
(add-to-list 'load-path "~/.emacs.d/custom-libs/cpp")
(require 'dap-cpptools)

;; Tramp
(lsp-register-client
 (make-lsp-client :new-connection (lsp-tramp-connection "clangd")
		  :major-modes '(c-mode)
		  :remote? t
		  :server-id 'clangd-remote))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Python ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LSP Server
;; Requires `pip install -U jedi-language-server`
(use-package
  lsp-jedi
  :ensure t)
(add-hook 'python-mode-hook #'lsp-deferred)

;; Jupyter
(use-package
  jupyter
  :ensure t)
(use-package
  ein
  :ensure t)

(add-hook 'python-mode-hook #'yas-minor-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Arduino ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package
  arduino-mode
  :ensure t)

(use-package
  arduino-cli-mode
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; GraphQL ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Install Mode
(use-package
  graphql-mode
  :ensure t)

;; Enable Mode at .graphqls
(add-to-list 'auto-mode-alist '("\\.graphqls$" . graphql-mode))

;; Register LSP
(add-to-list 'lsp-language-id-configuration '(graphql-mode . "graphql"))

(lsp-register-client (make-lsp-client :new-connection (lsp-stdio-connection '("graphql-lsp" "server"
									      "--method=stream"))
				      :activation-fn (lsp-activate-on "graphql")
				      :server-id 'graphql))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Common Lisp ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Adjust parentheses
(use-package
  adjust-parens
  :ensure t)
(add-hook 'lisp-mode-hook #'adjust-parens-mode)

;; Snippets
(use-package
  common-lisp-snippets
  :ensure t)
(add-hook 'lisp-mode-hook #'yas-minor-mode)

;; Compiler
(use-package
  slime
  :ensure t)

(use-package
  slime-company
  :ensure t)

;; Setup Lisp Interpreter
(setq inferior-lisp-program "sbcl")
(add-hook 'lisp-mode-hook #'evil-local-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Docker ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Docker
(use-package
  docker
  :ensure t)

;; Enable mode
(use-package
  dockerfile-mode
  :ensure t)

;; TODO: tramp integration

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; YAML ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; YAML
(use-package
  yaml-mode
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Ansible ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ansible
(use-package
  company-ansible
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Lua ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mode
(use-package
  lua-mode
  :ensure t)

;; Setup lsp variables
(setq lsp-clients-lua-language-server-bin "/usr/bin/lua-language-server")
(setq lsp-clients-lua-language-server-install-dir "/usr/lib/lua-language-server/")

;; Start lsp
(add-hook 'lua-mode-hook #'lsp-deferred)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Nginx ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Enable mode
(use-package
  nginx-mode
  :ensure t)

;; Load LSP
(lsp-register-client
  (make-lsp-client :new-connection (lsp-stdio-connection '("nginx-language-server"))
		   :major-modes '(nginx-mode)
		   :server-id 'nginx-language-server))
(add-hook 'nginx-mode-hook #'lsp-deferred)
