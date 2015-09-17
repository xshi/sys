;-----------------------------------------------------------
;  User Info
;-----------------------------------------------------------
(setq user-full-name "Xin Shi")
(setq user-mail-address "Xin.Shi@outlook.com")


;-----------------------------------------------------------
; AUCTeX 
;-----------------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.tex$" . LaTeX-mode))

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

;-----------------------------------------------------------
; Auto-Complete
;-----------------------------------------------------------
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

;-----------------------------------------------------------
; CMake 
;-----------------------------------------------------------
(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
		("\\.cmake\\'" . cmake-mode))
	      auto-mode-alist))

;-----------------------------------------------------------
; Markdown
;-----------------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

;-----------------------------------------------------------
; Aspell 
;-----------------------------------------------------------
(setq ispell-program-name "aspell")

;-----------------------------------------------------------
; Chinese font 
;-----------------------------------------------------------

(when (display-graphic-p) 
  (setq fonts 
        (cond ((eq system-type 'darwin)     '("Monaco"     "STHeiti")) 
              ((eq system-type 'gnu/linux)  '("Menlo"     "WenQuanYi Zen Hei")) 
              ((eq system-type 'windows-nt) '("Consolas"  "Microsoft Yahei")))) 
  
  (setq face-font-rescale-alist '(("STHeiti" . 1.2)
				  ("Microsoft Yahei" . 1.2) 
				  ("WenQuanYi Zen Hei" . 1.2))) 
  (set-face-attribute 'default nil :font 
                      (format "%s:pixelsize=%d" (car fonts) 14)) 
  (dolist (charset '(kana han symbol cjk-misc bopomofo)) 
    (set-fontset-font (frame-parameter nil 'font) charset 
                      (font-spec :family (car (cdr fonts)))))) 


;-----------------------------------------------------------
; JSON with python mode 
;-----------------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.json$" . python-mode))

