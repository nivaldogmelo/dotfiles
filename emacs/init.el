;;; init.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs Configuration
;;
;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Setup ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Required to load configs
(defun update-load-path (folder)
  "Add FOLDER to the load path."
  (add-to-list 'load-path folder)
  (dolist (f (directory-files folder))
    (let ((name (concat folder "/" f)))
      (when (and (file-directory-p name)
		 (not (string-prefix-p "." f))
		 (not (string-prefix-p ".." f)))
	(update-load-path name)))))

(setq user-emacs-directory (or (getenv "XDG_CONFIG_HOME") "~/.emacs.d/"))
(update-load-path (expand-file-name "elisp" user-emacs-directory))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Core ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'init-package)

(require 'init-path)

(require 'init-server)

(require 'init-internal)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; General ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'os)

(require 'qol)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; System ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'terminal)

(require 'docker)

(require 'git)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Coding ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'ide)

(require 'hints)

(require 'lsp)

(require 'assistant)

(require 'langs)

(provide 'init)
;;; init.el ends here
