;;; init-path.el ---  -*- lexical-binding: t; -*-
;;;
;;; Commentary:
;;; Emacs load path and custom variables configuration
;;;
;;; Code:

;; LoadPaths
(defun update-load-path (folder)
  "Add FOLDER to the load path."
  (add-to-list 'load-path folder)
  (dolist (f (directory-files folder))
    (let ((name (concat folder "/" f)))
      (when (and (file-directory-p name)
		 (not (string-prefix-p "." f))
		 (not (string-prefix-p ".." f)))
	(update-load-path name)))))

(update-load-path (expand-file-name "elisp" user-emacs-directory))
(update-load-path (expand-file-name "custom-libs" user-emacs-directory))
;; -LoadPaths

;; CustomSetVariables
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)
;; -CustomSetVariables

(provide 'init-path)
;;; init-path.el ends here
