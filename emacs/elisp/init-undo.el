;;; init-undo.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs undo configuration
;;
;;; Code:


;; UndoEmacs
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
;; -UndoEmacs


(provide 'init-undo)
;;; init-undo.el ends here
