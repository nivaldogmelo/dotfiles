;;; lsp.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs LSP configuration
;;
;;; Code:

;; Company
(use-package company
  :ensure t
  :diminish
  :hook ((prog-mode) . company-mode)
  :custom
  (company-minimum-prefix-length 2)
  (company-tooltip-align-annotations t)
  (company-global-modes '(not shell-mode vterm-mode))
  (company-idle-delay 0.3)
  (company-show-numbers t)
  (company-tooltip-limit 20)
  :config
  (setq company-begin-commands '(self-insert-command)))

;;; Theme config
(use-package company-box
  :diminish
  :if (display-graphic-p)
  :defines company-box-icons-all-the-icons
  :hook (company-mode . company-box-mode)
  :custom
  (company-box-backends-colors nil)
  (company-box-doc-delay 0.1)
  (company-box-doc-frame-parameters '((internal-border-width . 1)
				      (left-fringe . 3)
				      (right-fringe . 3)))
  :config
  (with-no-warnings
    ;; Prettify icons
    (defun my-company-box-icons--elisp (candidate)
      (when (or (derived-mode-p 'emacs-lisp-mode) (derived-mode-p 'lisp-mode))
	(let ((sym (intern candidate)))
	  (cond ((fboundp sym) 'Function)
		((featurep sym) 'Module)
		((facep sym) 'Color)
		((boundp sym) 'Variable)
		((symbolp sym) 'Text)
		(t . nil)))))
    (advice-add #'company-box-icons--elisp :override #'my-company-box-icons--elisp)

    ;; Credits to Centaur for these configurations
    ;; Display borders and optimize performance
    (defun my-company-box--display (string on-update)
      "Display the completions."
      (company-box--render-buffer string on-update)

      (let ((frame (company-box--get-frame))
	    (border-color (face-foreground 'font-lock-comment-face nil t)))
	(unless frame
	  (setq frame (company-box--make-frame))
	  (company-box--set-frame frame))
	(company-box--compute-frame-position frame)
	(company-box--move-selection t)
	(company-box--update-frame-position frame)
	(unless (frame-visible-p frame)
	  (make-frame-visible frame))
	(company-box--update-scrollbar frame t)
	(set-face-background 'internal-border border-color frame)
	(when (facep 'child-frame-border)
	  (set-face-background 'child-frame-border border-color frame)))
      (with-current-buffer (company-box--get-buffer)
	(company-box--maybe-move-number (or company-box--last-start 1))))
    (advice-add #'company-box--display :override #'my-company-box--display)

    (defun my-company-box-doc--make-buffer (object)
      (let* ((buffer-list-update-hook nil)
	     (inhibit-modification-hooks t)
	     (string (cond ((stringp object) object)
			   ((bufferp object) (with-current-buffer object (buffer-string))))))
	(when (and string (> (length (string-trim string)) 0))
	  (with-current-buffer (company-box--get-buffer "doc")
	    (erase-buffer)
	    (insert (propertize "\n" 'face '(:height 0.5)))
	    (insert string)
	    (insert (propertize "\n\n" 'face '(:height 0.5)))

	    ;; Handle hr lines of markdown
	    ;; @see `lsp-ui-doc--handle-hr-lines'
	    (with-current-buffer (company-box--get-buffer "doc")
	      (let (bolp next before after)
		(goto-char 1)
		(while (setq next (next-single-property-change (or next 1) 'markdown-hr))
		  (when (get-text-property next 'markdown-hr)
		    (goto-char next)
		    (setq bolp (bolp)
			  before (char-before))
		    (delete-region (point) (save-excursion (forward-visible-line 1) (point)))
		    (setq after (char-after (1+ (point))))
		    (insert
		     (concat
		      (and bolp (not (equal before ?\n)) (propertize "\n" 'face '(:height 0.5)))
		      (propertize "\n" 'face '(:height 0.5))
		      (propertize " "
				  'display '(space :height (1))
				  'company-box-doc--replace-hr t
				  'face `(:background ,(face-foreground 'font-lock-comment-face)))
		      (propertize " " 'display '(space :height (1)))
		      (and (not (equal after ?\n)) (propertize " \n" 'face '(:height 0.5)))))))))

	    (setq mode-line-format nil
		  display-line-numbers nil
		  header-line-format nil
		  show-trailing-whitespace nil
		  cursor-in-non-selected-windows nil)
	    (current-buffer)))))
    (advice-add #'company-box-doc--make-buffer :override #'my-company-box-doc--make-buffer)

    ;; Display the border and fix the markdown header properties
    (defun my-company-box-doc--show (selection frame)
      (cl-letf (((symbol-function 'completing-read) #'company-box-completing-read)
		(window-configuration-change-hook nil)
		(inhibit-redisplay t)
		(display-buffer-alist nil)
		(buffer-list-update-hook nil))
	(-when-let* ((valid-state (and (eq (selected-frame) frame)
				       company-box--bottom
				       company-selection
				       (company-box--get-frame)
				       (frame-visible-p (company-box--get-frame))))
		     (candidate (nth selection company-candidates))
		     (doc (or (company-call-backend 'quickhelp-string candidate)
			      (company-box-doc--fetch-doc-buffer candidate)))
		     (doc (company-box-doc--make-buffer doc)))
	  (let ((frame (frame-local-getq company-box-doc-frame))
		(border-color (face-foreground 'font-lock-comment-face nil t)))
	    (unless (frame-live-p frame)
	      (setq frame (company-box-doc--make-frame doc))
	      (frame-local-setq company-box-doc-frame frame))
	    (set-face-background 'internal-border border-color frame)
	    (when (facep 'child-frame-border)
	      (set-face-background 'child-frame-border border-color frame))
	    (company-box-doc--set-frame-position frame)

	    ;; Fix hr props. @see `lsp-ui-doc--fix-hr-props'
	    (with-current-buffer (company-box--get-buffer "doc")
	      (let (next)
		(while (setq next (next-single-property-change (or next 1) 'company-box-doc--replace-hr))
		  (when (get-text-property next 'company-box-doc--replace-hr)
		    (put-text-property next (1+ next) 'display
				       '(space :align-to (- right-fringe 1) :height (1)))
		    (put-text-property (1+ next) (+ next 2) 'display
				       '(space :align-to right-fringe :height (1)))))))

	    (unless (frame-visible-p frame)
	      (make-frame-visible frame))))))
    (advice-add #'company-box-doc--show :override #'my-company-box-doc--show)

    (defun my-company-box-doc--set-frame-position (frame)
      (-let* ((frame-resize-pixelwise t)

	      (box-frame (company-box--get-frame))
	      (box-position (frame-position box-frame))
	      (box-width (frame-pixel-width box-frame))
	      (box-height (frame-pixel-height box-frame))
	      (box-border-width (frame-border-width box-frame))

	      (window (frame-root-window frame))
	      ((text-width . text-height) (window-text-pixel-size window nil nil
								  (/ (frame-pixel-width) 2)
								  (/ (frame-pixel-height) 2)))
	      (border-width (or (alist-get 'internal-border-width company-box-doc-frame-parameters) 0))

	      (x (- (+ (car box-position) box-width) border-width))
	      (space-right (- (frame-pixel-width) x))
	      (space-left (car box-position))
	      (fringe-left (or (alist-get 'left-fringe company-box-doc-frame-parameters) 0))
	      (fringe-right (or (alist-get 'right-fringe company-box-doc-frame-parameters) 0))
	      (width (+ text-width border-width fringe-left fringe-right))
	      (x (if (> width space-right)
		     (if (> space-left width)
			 (- space-left width)
		       space-left)
		   x))
	      (y (cdr box-position))
	      (bottom (+ company-box--bottom (frame-border-width)))
	      (height (+ text-height (* 2 border-width)))
	      (y (cond ((= x space-left)
			(if (> (+ y box-height height) bottom)
			    (+ (- y height) border-width)
			  (- (+ y box-height) border-width)))
		       ((> (+ y height) bottom)
			(- (+ y box-height) height))
		       (t y))))
	(set-frame-position frame (max x 0) (max y 0))
	(set-frame-size frame text-width text-height t)))
    (advice-add #'company-box-doc--set-frame-position :override #'my-company-box-doc--set-frame-position))

  (when (require 'all-the-icons nil t)
    (declare-function all-the-icons-faicon 'all-the-icons)
    (declare-function all-the-icons-material 'all-the-icons)
    (declare-function all-the-icons-octicon 'all-the-icons)
    (setq company-box-icons-all-the-icons
	  `((Unknown . ,(all-the-icons-material "find_in_page" :height 1.0 :v-adjust -0.2))
			(Text . ,(all-the-icons-faicon "text-width" :height 1.0 :v-adjust -0.02))
			(Method . ,(all-the-icons-faicon "cube" :height 1.0 :v-adjust -0.02 :face 'all-the-icons-purple))
			(Function . ,(all-the-icons-faicon "cube" :height 1.0 :v-adjust -0.02 :face 'all-the-icons-purple))
			(Constructor . ,(all-the-icons-faicon "cube" :height 1.0 :v-adjust -0.02 :face 'all-the-icons-purple))
			(Field . ,(all-the-icons-octicon "tag" :height 1.1 :v-adjust 0 :face 'all-the-icons-lblue))
			(Variable . ,(all-the-icons-octicon "tag" :height 1.1 :v-adjust 0 :face 'all-the-icons-lblue))
			(Class . ,(all-the-icons-material "settings_input_component" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-orange))
			(Interface . ,(all-the-icons-material "share" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-lblue))
			(Module . ,(all-the-icons-material "view_module" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-lblue))
			(Property . ,(all-the-icons-faicon "wrench" :height 1.0 :v-adjust -0.02))
			(Unit . ,(all-the-icons-material "settings_system_daydream" :height 1.0 :v-adjust -0.2))
			(Value . ,(all-the-icons-material "format_align_right" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-lblue))
			(Enum . ,(all-the-icons-material "storage" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-orange))
			(Keyword . ,(all-the-icons-material "filter_center_focus" :height 1.0 :v-adjust -0.2))
			(Snippet . ,(all-the-icons-material "format_align_center" :height 1.0 :v-adjust -0.2))
			(Color . ,(all-the-icons-material "palette" :height 1.0 :v-adjust -0.2))
			(File . ,(all-the-icons-faicon "file-o" :height 1.0 :v-adjust -0.02))
			(Reference . ,(all-the-icons-material "collections_bookmark" :height 1.0 :v-adjust -0.2))
			(Folder . ,(all-the-icons-faicon "folder-open" :height 1.0 :v-adjust -0.02))
			(EnumMember . ,(all-the-icons-material "format_align_right" :height 1.0 :v-adjust -0.2))
			(Constant . ,(all-the-icons-faicon "square-o" :height 1.0 :v-adjust -0.1))
			(Struct . ,(all-the-icons-material "settings_input_component" :height 1.0 :v-adjust -0.2 :face 'all-the-icons-orange))
			(Event . ,(all-the-icons-octicon "zap" :height 1.0 :v-adjust 0 :face 'all-the-icons-orange))
			(Operator . ,(all-the-icons-material "control_point" :height 1.0 :v-adjust -0.2))
			(TypeParameter . ,(all-the-icons-faicon "arrows" :height 1.0 :v-adjust -0.02))
			(Template . ,(all-the-icons-material "format_align_left" :height 1.0 :v-adjust -0.2)))
	  company-box-icons-alist 'company-box-icons-all-the-icons)))
;; -Company

;; Lsp
(use-package
  lsp-mode
  :ensure t
  :defer t
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (dolist (dir '("[/\\\\]\\target\\'")) ;; Rust
    (push dir lsp-file-watch-ignored-directories))
  :commands (lsp lsp-deferred)
  :hook
  (before-save-hook . lsp-format-buffer)
  (before-save-hook . lsp-organize-imports)
  :config
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  :custom
  (lsp-keymap-prefix "C-c l")
  (lsp-modeline-code-actions-segments '(count icon name))
  (lsp-headerline-breadcrumb-segments '(project file symbols))
  (lsp-prefer-flymake nil)
  (read-process-output-max (* 1 1024 1024))
  (lsp-keep-workspace-alive nil)
  ;; (lsp-log-io t)
  (lsp-inlay-hint-enable t)
  (lsp-eldoc-render-all t))

(with-eval-after-load 'lsp-mode
  ;; :global/:workspace/:file
  (setq lsp-modeline-diagnostics-scope :workspace))

;;; UI
(use-package
  lsp-ui
  :ensure t
  :after lsp-mode
  :diminish
  :custom-face
  (lsp-ui-doc-background ((t (:background nil))))
  (lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic)))))
  :bind
  (:map lsp-ui-mode-map
	([remap lsp-find-definitions] . #'lsp-ui-peek-find-definitions)
	([remap xref-find-definitions] . #'lsp-ui-peek-find-definitions)
	([remap lsp-find-references] . #'lsp-ui-peek-find-references)
	([remap xref-find-references] . #'lsp-ui-peek-find-references)
	("C-c l u" . lsp-ui-imenu))
  :config
  (with-eval-after-load 'evil
    (define-key evil-normal-state-map (kbd "gd") #'lsp-ui-peek-find-definitions)
    (define-key evil-normal-state-map (kbd "gr") #'lsp-ui-peek-find-references))
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-header t)
  (lsp-ui-doc-border (face-foreground 'default))
  (lsp-ui-doc-show-with-cursor t)
  (lsp-ui-doc-show-with-mouse nil)
  (lsp-ui-doc-position 'top)
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-show-code-actions t)
  (lsp-ui-sideline-update-mode 'line)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-peek-enable t)
  (lsp-ui-peek-show-directory t)
  (lsp-ui-peek-always-show t)
  (lsp-ui-peek-peek-height 50)
  (lsp-ui-peek-list-width 30)
  (lsp-ui-imenu-enable t))

;;; Treemacs Integration
(use-package lsp-treemacs
  :ensure t
  :after lsp-mode
  :bind
  :config
  ;; (lsp-treemacs-sync-mode 1)
  :bind
  ("C-c l e" . lsp-treemacs-errors-list))

;;; Helm Integration
(use-package helm-lsp
  :ensure t)

;;; LspBooster
;; First install with `cargo install emacs-lsp-booster`
(defun lsp-booster--advice-json-parse (old-fn &rest args)
  "Try to parse bytecode instead of json."
  (or
   (when (equal (following-char) ?#)
     (let ((bytecode (read (current-buffer))))
       (when (byte-code-function-p bytecode)
         (funcall bytecode))))
   (apply old-fn args)))
(advice-add (if (progn (require 'json)
                       (fboundp 'json-parse-buffer))
                'json-parse-buffer
              'json-read)
            :around
            #'lsp-booster--advice-json-parse)

(defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
  "Prepend emacs-lsp-booster command to lsp CMD."
  (let ((orig-result (funcall old-fn cmd test?)))
    (if (and (not test?)                             ;; for check lsp-server-present?
             (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
             lsp-use-plists
             (not (functionp 'json-rpc-connection))  ;; native json-rpc
             (executable-find "emacs-lsp-booster"))
        (progn
          (when-let ((command-from-exec-path (executable-find (car orig-result))))  ;; resolve command from exec-path (in case not found in $PATH)
            (setcar orig-result command-from-exec-path))
          (message "Using emacs-lsp-booster for %s!" orig-result)
          (cons "emacs-lsp-booster" orig-result))
	  ;; (append '("emacs-lsp-booster" "--disable-bytecode" "--") orig-result))
	  ;; (append '("emacs-lsp-booster-debug" "--verbose" "--") orig-result))
      orig-result)))
(advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command)

;;; Debugger Configuration



(use-package
  dap-mode
  :diminish
  :ensure t
  :bind
  (:map dap-mode-map
	("<f12>" . dap-debug)
	("C-<f12>" . dap-disconnect)
	("<f7>" . dap-continue)
	("<f6>" . dap-next)
	("C-<f6>" . dap-delete-all-sessions)
	("C-<f5>" . dap-breakpoint-delete-all)
	("<f5>" . dap-breakpoint-toggle))
  :config
  (setq dap-auto-configure-features '(sessions locals breakpoints expressions repl controls tooltip))
  (dap-auto-configure-mode)
  (with-eval-after-load 'dap-ui
    (setf (alist-get dap-ui--repl-buffer dap-ui-buffer-configurations)
	  '((side . bottom) (slot . 2) (window-height . 0.45)))))
  ;; (dap-ui-mode 1)
  ;; (dap-tooltip-mode 1)
  ;; (tooltip-mode 1)
  ;; (dap-ui-controls-mode 1))

(require 'dap-gdb)


 
(provide 'lsp)
;;; lsp.el ends here
