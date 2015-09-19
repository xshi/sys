;;-----------------------------------------------------------
; Set Variables
;;-----------------------------------------------------------
(setq global-font-lock-mode t)
(show-paren-mode t)
(setq show-paren-style 'mixed)

(setq dired-listing-switches "-lh")

;; Typing override text selection
(delete-selection-mode 1) 

;; tramp 
(setq tramp-auto-save-directory "~/.emacs.d/tramp-autosave") 
(setq password-cache-expiry nil)

;-----------------------------------------------------------
;  Frequently used Mode 
;-----------------------------------------------------------
(require 'ido)
(ido-mode t)

;(desktop-save-mode 1)

(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

(require 'redo)


;-----------------------------------------------------------
; Bookmark File
;-----------------------------------------------------------
(setq bookmark-save-flag 1)

;-----------------------------------------------------------
; Frames 
;-----------------------------------------------------------
(tool-bar-mode -1)

(setq browse-url-browser-function 'browse-url-default-macosx-browser)

(setq frame-title-format "%f")

(setq default-frame-alist 
      '((menu-bar-lines . 1) 
	(foreground-color . "Black")
	(background-color . "White") 
	(cursor-type . box) 
	(cursor-color . "Black")
	(vertical-scroll-bars . right)
	(internal-border-width . 0)
	(left-fringe . 1)
	(right-fringe . 0)
	(fringe) (tool-bar-lines . 0)
	;(top . 1) (right . 1) (width . 88) (height . 66)
	))

;-----------------------------------------------------------
; Terminal
;-----------------------------------------------------------
(autoload 'multi-term "multi-term" "" t)
(setq multi-term-switch-after-close nil)
(setq term-bind-key-alist nil)
(setq term-unbind-key-list nil)

;-----------------------------------------------------------
; X-Windows 
;-----------------------------------------------------------
(if window-system
  (custom-set-faces
   '(default ((t (:height 130))))
   '(org-mode-default 
     ((t (:inherit outline-mode-default :height 130 :family "Monaco"))))
   '(latex-mode-default 
     ((t (:inherit outline-mode-default :height 130 :family "Monaco"))))
   '(org-mode-line-clock 
     ((t (:background "forest green" :foreground "white"))) t)))

;-----------------------------------------------------------
; Transparent Frame
;-----------------------------------------------------------
(defun transparency-set-initial-value ()
  "Set initial value of alpha parameter for the current frame"
  (interactive)
  (if (equal (frame-parameter nil 'alpha) nil)
      (set-frame-parameter nil 'alpha 100)))

(defun transparency-set-value (numb)
  "Set level of transparency for the current frame"
  (interactive "nEnter transparency level in range 0-100: ")
  (if (> numb 100)
      (message "Error! The maximum value for transparency is 100!")
    (if (< numb 0)
	(message "Error! The minimum value for transparency is 0!")
      (set-frame-parameter nil 'alpha numb))))

(defun transparency-increase ()
  "Increase level of transparency for the current frame"
  (interactive)
  (transparency-set-initial-value)
   (if (> (frame-parameter nil 'alpha) 0)
       (set-frame-parameter nil 'alpha (+ (frame-parameter nil 'alpha) -2))
     (message "This is a minimum value of transparency!")))

(defun transparency-decrease ()
  "Decrease level of transparency for the current frame"
  (interactive)
  (transparency-set-initial-value)
  (if (< (frame-parameter nil 'alpha) 100)
      (set-frame-parameter nil 'alpha (+ (frame-parameter nil 'alpha) +2))
    (message "This is a minimum value of transparency!")))


(setq transparency-level 95)
(set-frame-parameter nil 'alpha transparency-level)

(add-hook 'after-make-frame-functions 
	  (lambda
	    (selected-frame) 
	    (set-frame-parameter 
	     selected-frame
	     'alpha transparency-level)))

;;-----------------------------------------------------------
; Gloable Key Bindings
;;-----------------------------------------------------------
(global-set-key [M-S-mouse-1] (quote mouse-save-then-kill))
(global-set-key (kbd "C-?") 'transparency-set-value)
(global-set-key (kbd "C->") 'transparency-increase)
(global-set-key (kbd "C-<") 'transparency-decrease)

;;-----------------------------------------------------------
; Puer Emacs 
;;-----------------------------------------------------------
(global-set-key [s-mouse-1] (quote mouse-yank-at-click))
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed t) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
;; (global-set-key (kbd "s-w") (quote delete-window))

;(setq ring-bell-function 'echo-area-bell)
(setq ring-bell-function 'ignore)

(if (string-equal "darwin" (symbol-name system-type))
    (setenv "PATH" (concat "/usr/local/bin:/usr/texbin:" (getenv "PATH"))))

(setq exec-path (split-string (getenv "PATH") ":"))


;; Fix the problem of ls does not support --dired;
(when (eq system-type 'darwin)
  (require 'ls-lisp)
  (setq ls-lisp-use-insert-directory-program nil))


(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")
			 ))
