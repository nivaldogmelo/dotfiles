;;; init-tramp.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs tramp configuration
;;
;;; Code:


;; TrampEmacs
(use-package tramp
  :ensure nil
  :defer 1
  :config
  ;; Config to GCLOUD
  (add-to-list 'tramp-methods
	       '("gssh"
		 (tramp-login-program        "gcloud compute ssh")
		 (tramp-login-args           (("%h")))
		 (tramp-async-args           (("-q")))
		 (tramp-remote-shell         "/bin/bash")
		 (tramp-remote-shell-args    ("-c"))
		 (tramp-gw-args              (("-o" "GlobalKnownHostsFile=/dev/null")
					     ("-o" "UserKnownHostsFile=/dev/null")
					     ("-o" "StrictHostKeyChecking=no")))
		 (tramp-default-port         22)))
  (put 'temporary-file-directory 'standard-value '("/tmp")))

;; Speed Up
(setq remote-file-name-inhibit-cache nil)
(setq vc-ignore-dir-regexp (format "%s\\|%s" vc-ignore-dir-regexp tramp-file-name-regexp))
(setq tramp-verbose 1)

;; -TrampEmacs


(provide 'init-tramp)
;;; init-tramp.el ends here
