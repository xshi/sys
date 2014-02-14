;-----------------------------------------------------------
;  User Info
;-----------------------------------------------------------
(setq user-full-name "Xin Shi")
(setq user-mail-address "xshi@xshi.org")

;-----------------------------------------------------------
;  Frequently used Mode after the pack-list load 
;-----------------------------------------------------------
(helm-mode 1)

;-----------------------------------------------------------
; Auto-Complete
;-----------------------------------------------------------
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-helm)

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
