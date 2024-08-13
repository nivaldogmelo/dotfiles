;;; init-yasnippet.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs yasnippet configuration
;;
;;; Code:


;; Yasnippets
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
  (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
  (defun smarter-yas-expand-next-field ()
    "Try to `yas-expand' and `yas-next-field' at current cursor position."
    (interactive)
    (let ((old-point (point))
	  (old-tick (buffer-modified-tick)))
      (yas-expand)
      (when (and (eq old-point (point))
		 (eq old-tick (buffer-modified-tick)))
	(ignore-errors (yas-next-field))))))

;; -Yasnippets


(provide 'init-yasnippet)
;;; init-yasnippet.el ends here
