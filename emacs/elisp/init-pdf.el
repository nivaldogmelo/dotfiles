;;; init-pdf.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs PDF configuration
;;
;;; Code:


;; PDFTools
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
;; -PDFTools

;; PDFGrep
(use-package pdfgrep
  :defer t
  :ensure t
  :commands (pdfgrep)
  :config (pdfgrep-mode))
;; -PDFGrep


(provide 'init-pdf)
;;; init-pdf.el ends here
