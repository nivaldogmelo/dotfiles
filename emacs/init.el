;;; init.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs Configuration
;;
;;; Code:

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
(update-load-path (expand-file-name "custom-libs" user-emacs-directory))

(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'no-message)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Core ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'init-package)

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

(require 'lsp)

(require 'hints)

(require 'langs)

(require 'ai)


(provide 'init)
;;; init.el ends here
