(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  '(ansi-color-faces-vector
     [default default default italic underline success warning error])
  '(custom-enabled-themes (quote (misterioso)))
  '(custom-safe-themes
     (quote
       ("2540689fd0bc5d74c4682764ff6c94057ba8061a98be5dd21116bf7bf301acfb" default)))
  '(fci-rule-color "#14151E")
  '(package-selected-packages
     (quote
       (go-complete flymake-go flycheck-gometalinter go-autocomplete go-mode wakatime-mode afternoon-theme aggressive-indent bash-completion powerline)))
  '(vc-annotate-background nil)
  '(vc-annotate-color-map
     (quote
       ((20 . "#d54e53")
        (40 . "goldenrod")
        (60 . "#e7c547")
        (80 . "DarkOliveGreen3")
        (100 . "#70c0b1")
        (120 . "DeepSkyBlue1")
        (140 . "#c397d8")
        (160 . "#d54e53")
        (180 . "goldenrod")
        (200 . "#e7c547")
        (220 . "DarkOliveGreen3")
        (240 . "#70c0b1")
        (260 . "DeepSkyBlue1")
        (280 . "#c397d8")
        (300 . "#d54e53")
        (320 . "goldenrod")
        (340 . "#e7c547")
        (360 . "DarkOliveGreen3"))))
  '(vc-annotate-very-old-color nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  )

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
          Your version of Emacs does not support SSL connections,
          which is unsafe because it allows man-in-the-middle attacks.
          There are two things you can do about this warning:
          1. Install an Emacs version that does support SSL and be safe.
          2. Remove this warning from your init file so you won't see it again."))
          ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
          (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
          ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
          (when (< emacs-major-version 24)
            ;; For important compatibility libraries like cl-lib
            (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(load (expand-file-name "~/.quicklisp/slime-helper.el"))
(setq inferior-lisp-program "sbcl")
(setq global-linum-mode t)
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)

(global-wakatime-mode)

;(autoload 'enable-paredit-mode "paredit"
;  "Turn on pseudo-structural editing of Lisp code."
;  t)
;(add-hook 'emacs-lisp-mode-hook       'enable-paredit-mode)
;(add-hook 'lisp-mode-hook             'enable-paredit-mode)
;(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
;(add-hook 'scheme-mode-hook           'enable-paredit-mode)

;; Write backupds to ~/.emacs.d/backup/
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying      t  ; Don't de-link hard links
      version-control        t  ; Use version numbers on backups
      delete-old-versions    t  ; Automatically delete excess backups
      kept-new-versions      20 ; How many of the newest versions to keep
      kept-old-version       5) ; How many of the old versions to keep


(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
    (let* ((this-win-buffer (window-buffer))
           (next-win-buffer (window-buffer (next-window)))
           (this-win-edges (window-edges (selected-window)))
           (next-win-edges (window-edges (next-window)))
           (this-win-2nd (not (and (<= (car this-win-edges)
                                       (car next-win-edges))
                                   (<= (cadr this-win-edges)
                                       (cadr next-win-edges)))))
           (splitter
             (if (= (car this-win-edges)
                    (car (window-edges (next-window))))
               'split-window-horizontally
               'split-window-vertically)))
      (delete-other-windows)
      (let ((first-win (selected-window)))
        (funcall splitter)
        (if this-win-2nd (other-window 1))
        (set-window-buffer (selected-window) this-win-buffer)
        (set-window-buffer (next-window) next-win-buffer)
        (select-window first-win)
        (if this-win-2nd (other-window 1))))))

(global-set-key (kbd "C-x |") 'toggle-window-split)
