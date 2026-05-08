;;; assistant.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs setup for copilot
;;
;;; Code:

;; PackageSettings
(use-package copilot
  :quelpa (copilot :fetcher github
		   :repo "copilot-emacs/copilot.el"
		   :branch "main"
		   :files ("*.el"))
  :diminish
  :config
  (setq copilot-max-char -1))

(add-hook 'prog-mode-hook 'copilot-mode)
;; -PackageSettings

;; CustomFunctions

;;; Disable copilot in some modes
(defun custom/no-copilot-mode ()
  "Helper for `custom/no-copilot-modes`."
  (copilot-mode -1))

(defvar custom/no-copilot-modes '(shell-mode
				  inferior-python-mode
				  eshell-mode
				  term-mode
				  vterm-mode
				  compilation-mode
				  debugger-mode
				  minibuffer-mode-hook)
  "Modes in which copilot is incovenient.")

;;; Disable copilot completions in some modes
(defun custom/copilot-disable-predicate ()
  "When copilot should not automatically show completions."
  ;; (or custom/copilot-manual-mode
  (or (member major-mode custom/no-copilot-modes)
      (company--active-p)))

(add-to-list 'copilot-disable-predicates #'custom/copilot-disable-predicate)


(defun custom/copilot-complete-or-accept ()
  "Command that either triggers a completion or accepts one if one
is available. Useful if you tend to hammer your keys like I do."
  (interactive)
  (if (copilot--overlay-visible)
      (progn
	(copilot-accept-completion)
	(open-line 1)
	(next-line))
    (copilot-complete)))

(define-key copilot-mode-map (kbd "C-M-j") #'copilot-next-completion)
(define-key copilot-mode-map (kbd "C-M-k") #'copilot-previous-completion)
(define-key copilot-mode-map (kbd "C-M-SPC") #'copilot-accept-completion-by-word)
(define-key copilot-mode-map (kbd "C-M-h") #'copilot-accept-completion-by-line)
(define-key global-map (kbd "C-M-<return>") #'custom/copilot-complete-or-accept)

(defun check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
	(backward-char 1)
	(if (looking-at "::") t nil)))))

(defun do-yas-expand ()
  (let ((yas/fallback-behavior 'return-nil))
    (yas/expand)))

(defun company-yasnippet-or-completion ()
  (interactive)
  (or (do-yas-expand)
      (company-complete-common)))

(defun tab-indent-or-complete ()
  (interactive)
  (if (minibufferp)
      (minibuffer-complete)
    (if (or (not yas/minor-mode)
	    (null (do-yas-expand)))
	(if (check-expansion)
	    (company-complete-common)
	  (indent-for-tab-command)))))

(defun custom/copilot-tab ()
  "Tab command that will complete with copilot if a completion is
available. Otherwise will try company, yasnippet or normal
tab-indent."
  (interactive)
  (if (minibufferp)
      (minibuffer-complete))
  (or (copilot-accept-completion)
      (tab-indent-or-complete)))

(define-key copilot-mode-map (kbd "<tab>") 'custom/copilot-tab)

;; Enable copilot mode globally or in specific modes
(add-hook 'prog-mode-hook 'copilot-mode)

(defun custom/copilot-quit ()
  "Run `copilot-clear-overlay` or `keyboiard-quit`. If copilot is
cleared, make sure the overlay doesn't come back too soon."
  (interactive)
  (condition-case err
      (when copilot--overlay
	(lexical-let ((pre-copilot-disable-predicates copilot-disable-predicates))
	  (setq copilot-disable-predicates (list (lambda () t)))
	  (copilot-clear-overlay)
	  (run-with-idle-timer
	   1.0
	   nil
	   (lambda ()
	     (setq copilot-disable-predicates pre-copilot-disable-predicates)))))
    (error handler)))

(advice-add 'keyboard-quit :before #'custom/copilot-quit)
;; -CustomFunctions

;; Eca
(use-package eca
  :vc (:url "https://github.com/editor-code-assistant/eca-emacs" :rev :newest)
  :bind (:map global-map
	      ("C-c c"     . custom/eca-toggle-or-start)))

(defun custom/eca-toggle-or-start ()
  "Toggle ECA chat window if a session exists, otherwise start ECA.

If ECA is not running this will call `eca' to initialize it." 
  (interactive)
  (if (ignore-errors (eca-session))
      (eca-chat-toggle-window)
    (call-interactively #'eca)))

;; -Eca

(provide 'assistant)
;;; assistant.el ends here
