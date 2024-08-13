;;; init-arduino.el ---  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; Emacs arduino configuration
;;
;;; Code:


;; ArduinoMode
(use-package
  arduino-mode
  :ensure t)

(use-package
  arduino-cli-mode
  :ensure t)
;; -ArduinoMode


(provide 'init-arduino)
;;; init-arduino.el ends here
