;;-----------------------------------------------------------
;; $Id$
;;-----------------------------------------------------------

;;-----------------------------------------------------------
;; Settings for whoolphin
;;-----------------------------------------------------------

(setq frame-title-format "Emacs-wholphin: %b %+%+ %f")
(setq inhibit-splash-screen t)

;;-----------------------------------------------------------
;  Frequently used Mode 
;;-----------------------------------------------------------

(require 'ido)
(ido-mode t)
(require 'redo)

(require 'tabbar)
(if window-system 
    (tabbar-mode))

;-----------------------------------------------------------
;; Org Mode
;;-----------------------------------------------------------

(org-remember-insinuate) ; After Emacs 23

(setq org-remember-templates
     `(
       ("Journal" ?j "* %t %?\n\n  %i\n" ,sx-journal-file "2009")
       ("Notes" ?n "* %^{Title}\n  %i\n  %a" ,sx-notes-file "New Notes")
      ))

;;-----------------------------------------------------------
;; X-Windows Settings
;;-----------------------------------------------------------

(if window-system
    (custom-set-faces
     '(default ((t (:stipple nil :background "royalblue" :foreground "honeydew" :family "Comic Sans MS")))) 
     '(ido-only-match ((((class color)) (:foreground "aquamarine1" :weight bold))))
     '(ido-subdir ((((class color)) (:foreground "yellow"))))
     '(menu ((t (:background "light steel blue"))))
     '(tool-bar ((t (:background "light steel blue" :foreground "#000000" :box (:line-width 1 :style released-button)))))
     )
  )



;;-----------------------------------------------------------
;; Aspell
;;-----------------------------------------------------------

(setq ispell-program-name "C:\\Program Files\\Aspell\\bin\\aspell.exe")


