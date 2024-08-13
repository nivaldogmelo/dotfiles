;;; init-packages.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs Melpa and use package configuration
;;
;;; Code:

;; Set up package.el to work with MELPA

;; MelpaPackages
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory)
      package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")
			 ))
;; -MelpaPackages

;; QuelpaPackages
(unless (package-installed-p 'quelpa)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
    (eval-buffer)
    (quelpa-self-upgrade)))
(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))
;; -QuelpaPackages

;; SetupUsePackage
(unless (bound-and-true-p package--initialized)
  (setq package-enable-at-startup nil)
  (package-initialize))

(eval-and-compile
  (setq use-package-verbose (not (bound-and-true-p byte-compile-current-file))))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-and-compile
  (setq use-package-always-ensure t)
  (setq use-package-expand-minimally t)
  (setq use-package-compute-statistics t)
  (setq use-package-enable-imenu-support t))


(eval-when-compile
  (require 'use-package)
  (require 'quelpa-use-package)
  (require 'bind-key))
;; -SetupUsePackage

;; AutoUpdatePackages
;; For Melpa
(use-package auto-package-update
  :if (not (daemonp))
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-delete-old-versions t)
  (auto-package-update-hide-resultst)
  :config
  (auto-package-update-maybe))

;; For Quelpa
(setq quelpa-upgrade-interval 7)
(add-hook #'after-init-hook #'quelpa-upgrade-all-maybe)
;; -AutoUpdatePackages

(provide 'init-packages)
;;; init-packages.el ends here
