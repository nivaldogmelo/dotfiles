;;; hints.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs setup for coding projects
;;
;;; Code:

;; Flycheck
(use-package
  flycheck
  :defer t
  :diminish
  :hook (after-init . global-flycheck-mode)
  :commands (flycheck-add-mode)
  :custom
  (flycheck-global-modes
   '(not outline-mode diff-mode shell-mode eshel-mode term-mode vterm-mode))
  (flycheck-emacs-lisp-load-path 'inherit)
  (flycheck-indication-mode (if (display-graphic-p) 'right-fringe 'right-margin))
  :bind
	(("C-c f l" . flycheck-list-errors)
	 ("C-c f j"  . flycheck-next-error)
	 ("C-c f k"  . flycheck-previous-error)
	 ("C-c f i"  . flycheck-first-error)
	 ("C-c f e"  . flycheck-explain-error-at-point))
  :init
  (if (display-graphic-p)
      (use-package flycheck-posframe
	:custom-face
	(flycheck-posframe-face ((t (:foreground ,(face-foreground 'success)))))
	(flycheck-posframe-info-face ((t (:foreground ,(face-foreground 'success)))))
	:hook (flycheck-mode . flycheck-posframe-mode)
	:custom
	(flycheck-posframe-position 'window-bottom-left-corner)
	(flycheck-posframe-border-width 3)
	(flycheck-posframe-inhibit-functions
	 '((lambda (&rest _) (bound-and-true-p company-backend)))))
    (use-package flycheck-pos-tip
      :ensure t
      :defines flycheck-pos-tip-timeout
      :hook (flycheck-mode . flycheck-pos-tip-mode)
      :custom (flycheck-pos-tip-timeout 30)))
  :config
  (use-package flycheck-popup-tip
    :hook (flycheck-mode . flycheck-popup-tip-mode))
  (when (fboundp 'define-fringe-bitmap)
    (define-fringe-bitmap 'flycheck-fringe-bitmap-double-arrow
      [16 48 112 240 112 48 16] nil nil 'center))
  (when (executable-find "vale")
    (use-package flycheck-vale
      :config
      (flycheck-vale-setup)
      (flycheck-add-mode 'vale 'latex-mode))))

(add-to-list 'display-buffer-alist
	     `(,(rx bos "*Flycheck errors*" eos)
	      (display-buffer-reuse-window
	       display-buffer-in-side-window)
	      (side            . bottom)
	      (reusable-frames . visible)
	      (window-height   . 0.20)))

(add-to-list 'display-buffer-alist
	     `(,(rx bos "*Flycheck errors*" eos)
	      (display-buffer-reuse-window
	       display-buffer-in-side-window)
	      (side            . bottom)
	      (reusable-frames . visible)
	      (window-height   . 0.20)))

;;; Projectile Integration
(use-package flycheck-projectile
  :ensure t
  :config
  (add-to-list 'popwin:special-display-config
               `(,flycheck-projectile-error-list-buffer
                 :regexp nil :dedicated t :position bottom :stick t
                 :noselect nil))
  :bind
  (("C-c f p" . flycheck-projectile-list-errors)))
;; -Flycheck

;; Snippets
(use-package
  yasnippet
  :ensure t
  :diminish yas-minor-mode
  :init
  (use-package yasnippet-snippets :after yasnippet)
  :hook ((prog-mode text-mode markdown-mode org-mode) . yas-minor-mode)
  :bind
  (:map yas-minor-mode-map
	("C-c y v" . yas-visit-snippet-file)
	("C-c y t" . yas-describe-tables))
  (:map yas-keymap
	(("TAB" . smarter-yas-expand-next-field))
	([(tab)] . smarter-yas-expand-next-field))
  :config
  (yas-reload-all)
  (setq yas-snippet-dirs '("~/.emacs.d/snippets/personal" "~/.emacs.d/snippets/yasnippet-snippets"))
  (defun smarter-yas-expand-next-field ()
    "Try to `yas-expand' and `yas-next-field' at current cursor position."
    (interactive)
    (let ((old-point (point))
	  (old-tick (buffer-modified-tick)))
      (yas-expand)
      (when (and (eq old-point (point))
		 (eq old-tick (buffer-modified-tick)))
	(ignore-errors (yas-next-field))))))
;; -Snippets

(provide 'hints)
;;; hints.el ends here
