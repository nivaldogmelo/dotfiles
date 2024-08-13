;;; init-rss.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs RSS configuration
;;
;;; Code:


;; Elfeed
(use-package
  elfeed
  :ensure t
  :config
  (setq elfeed-feeds
	'(("https://www.phoronix.com/rss.php" news linux)
	  ("https://igor.mp/blog/atom" blog)
	  ("https://nivaldogmelo.github.io/posts/index.xml" blog)
	  ("http://nedroid.com/feed/" webcomic))))

(use-package
  elfeed-goodies
  :ensure t)

(use-package
  elfeed-summary
  :ensure t)

(use-package
  elfeed-webkit
  :ensure t)
;; -Elfeed


;; RSSDashboard
(use-package elfeed-dashboard
  :ensure t
  :bind ("C-c e" . elfeed-dashboard)
  :config
  (setq elfeed-dashboard-file "~/.emacs.d/elfeed-dashboard.org")
  ;; update feed counts on elfeed-quit
  (advice-add 'elfeed-search-quit-window :after #'elfeed-dashboard-update-links))
;; -RSSDashboard


(provide 'init-rss)
;;; init-rss.el ends here
