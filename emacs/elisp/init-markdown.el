;;; init-markdown.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs markdown configuration
;;
;;; Code:


;; MarkdownEmacs
(use-package
  markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'"       . gfm-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :custom
  (markdown-command "pandoc -f gfm")
  (markdown-command-needs-filename t)
  (markdown-enable-math t)
  (markdown-open-command "marked")
  :custom-face
  (markdown-header-face-1 ((t (:inherit markdown-header-face :height 2.0))))
  (markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.6))))
  (markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.4))))
  (markdown-header-face-4 ((t (:inherit markdown-header-face :height 1.2))))
  :init (setq markdown-command "multimarkdown")
  :bind
  ("<backtab>" . markdown-cycle))
;; -MarkdownEmacs

;; MarkdownPreview
(use-package
  markdown-preview-mode
  :after markdown-mode
  :demand t
  :config
  (setq markdown-preview-stylesheets
	(list (concat "https://github.com/dmarcotte/github-markdown-preview/"
		      "blob/master/data/css/github.css"))))
;; -MarkdownPreview

(provide 'init-markdown)
;;; init-markdown.el ends here
