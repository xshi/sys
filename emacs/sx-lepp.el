;--------------------------------------------------------------------------
;; $Id$
;--------------------------------------------------------------------------


;;-----------------------------------------------------------
;  Frequently used Mode 
;;-----------------------------------------------------------

(require 'ido)
(ido-mode t)
(require 'redo)

(require 'tabbar)
(if window-system 
    (tabbar-mode))

(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)


;;-----------------------------------------------------------
;; Settings for LEPP
;;-----------------------------------------------------------


(setq browse-url-browser-function 'browse-url-firefox)

(setq frame-title-format "Emacs-LEPP: %b %+%+ %f")
(setq printer-name "N223_BRN_5370")
(setq nxhtml-skip-welcome t)

(setq inhibit-startup-screen t)


(setenv "KRB5CCNAME_LEPP" "~/.pri/.krb5_lepp")
(setenv "KRB5CCNAME_FNAL" "~/.pri/.krb5_fnal")
(setenv "KRB5CCNAME_CERN" "~/.pri/.krb5_cern")

(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))

;;-----------------------------------------------------------
;; Auctex
;;-----------------------------------------------------------
(load "auctex.el" nil t t)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   
(add-hook 'latex-mode-hook 'turn-on-reftex)   

;;-----------------------------------------------------------
;; Dictionary
;;-----------------------------------------------------------

(autoload 'dictionary-search "dictionary"
  "Ask for a word and search it in all dictionaries" t)
(autoload 'dictionary-match-words "dictionary"
  "Ask for a word and search all matching words in the dictionaries" t)
(autoload 'dictionary-lookup-definition "dictionary"
  "Unconditionally lookup the word at point." t)
(autoload 'dictionary "dictionary"
  "Create a new dictionary buffer" t)

;;-----------------------------------------------------------
;; Org Mode
;;-----------------------------------------------------------

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.info\\'" . org-mode))

(setq org-export-with-LaTeX-fragments t)

(setq org-todo-keyword-faces
      '(
	("STARTED"  . (:foreground "orange" :weight bold))
	("WAITING"  . (:foreground "yellow" :weight bold))
	)
      )
(setq org-clock-into-drawer t)
(setq org-modules (quote (org-id org-jsinfo org-mobile)))


(setq org-ditaa-jar-path "~/local/lib/ditaa0_8.jar")

(setq org-export-table-row-tags
      (cons '(if head
		 "<tr>"
	       (if (= (mod nline 2) 1)
		   "<tr class=\"tr-odd\">"
		 "<tr class=\"tr-even\">"))
	    "</tr>"))

(setq org-mobile-directory "~/.pri/stage/")
(setq org-mobile-inbox-for-pull "~/.pri/from-mobile.org")

(setq org-export-copy-to-kill-ring nil)
(setq org-export-kill-product-buffer-when-displayed t)

;; (setq org-drawers '("PROPERTIES" "SETUP" "CLOCK" "LOGBOOK"))

;;-----------------------------------------------------------
;; Terminal
;;-----------------------------------------------------------

;; (require 'multi-term)
(autoload 'multi-term "multi-term" "" t)

;-----------------------------------------------------------
;; X-Windows Settings
;;-----------------------------------------------------------

;; (if window-system
;;   (custom-set-faces
;;    '(default ((t (:background "royalblue" :foreground "honeydew" :height 120))))
;;    '(ido-only-match ((((class color)) (:foreground "aquamarine1" :weight bold))))
;;    '(ido-subdir ((((class color)) (:foreground "yellow"))))
;;    '(menu ((t (:background "light steel blue"))))
;;    '(tool-bar ((t (:background "light steel blue" :foreground "#000000" :box (:line-width 1 :style released-button)))))
;;    )
;;   )

;;-----------------------------------------------------------
;; Email 
;;-----------------------------------------------------------

;;(load "sx-mail")  

;;-----------------------------------------------------------
;; yasnippet
;;-----------------------------------------------------------

;;(require 'yasnippet-bundle)

;;-----------------------------------------------------------
;; ECB
;;-----------------------------------------------------------

;; (add-to-list 'load-path
;; 	     "~/local/share/emacs/site-lisp/ecb-2.40")


;; Tramp

;(setq tramp-debug-buffer t)

;; Hideshow

;; (require 'hideshow)
;; (add-hook 'python-mode-hook 'hs-minor-mode)
;; (add-hook 'sh-mode-hook     'hs-minor-mode) 
;; (add-hook 'c-mode-common-hook 'hs-minor-mode)


;; Python 
(setq interpreter-mode-alist (cons '("python" . python-mode)
				   interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

;; GTAGS
;; (autoload 'gtags-mode "gtags" "" t)

;; Graphviz-dot-mode

(load "graphviz-dot-mode") 

;; (setq font-use-system-font t)

;;-----------------------------------------------------------
; Gloable Key Bindings
;;-----------------------------------------------------------
(global-set-key [(f5)] 'sx-revert-buffer)
(global-set-key [(f6)] 'ispell-region)

(global-set-key [(shift delete)]   'clipboard-kill-region)
(global-set-key [(control insert)] 'clipboard-kill-ring-save)
(global-set-key [(shift insert)]   'clipboard-yank)

(global-set-key (quote [67108907]) (quote redo))

(global-set-key (kbd "C-<prior>") 'tabbar-backward)
(global-set-key (kbd "C-<next>") 'tabbar-forward)
(global-set-key (kbd "M-<prior>") 'tabbar-backward-group)
(global-set-key (kbd "M-<next>") 'tabbar-forward-group)


(global-set-key "\C-cbc"  'sx-switch-buffer-coding)
(global-set-key "\C-cbl"  'sx-switch-buffer-logging)

(global-set-key "\C-cgtd" 'sx-gtd)
(global-set-key "\C-chf"  'sx-hide-frames)
(global-set-key "\C-ccb" 'sx-copy-other-buffer-content)

