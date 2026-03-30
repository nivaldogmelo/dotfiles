;;; init-server.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs Server Configuration
;;
;;; Code:

;; start server if not already running
(require 'server)
(unless (server-running-p)
  (server-start))

(provide 'init-server)
;;; init-server.el ends here
