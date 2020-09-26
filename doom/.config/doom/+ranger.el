;;; ~/.doom.d/+ranger.el -*- lexical-binding: t; -*-

(def-package! ranger
  :commands (ranger deer ranger-override-dired-fn)
  :config
  (set-popup-rule! "^\\*ranger" :ignore t))
 ;; before (map! :desc "label" :prefix "a" ...) ;; now (map! :prefix ("a" . "label") ...)
(map!
 (:leader
   (:prefix ("a" . "applications")
    :desc "Ranger" "r" #'ranger
    :desc "Deer" "d" #'deer)))

(add-hook! dired-mode #'ranger-override-dired-fn) ;; Override dired-mode so it uses deer
