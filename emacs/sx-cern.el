;;-----------------------------------------------------------
;  Frequently used Mode 
;;-----------------------------------------------------------

(require 'ido)
(ido-mode t)
(require 'redo)

;;-----------------------------------------------------------
;; Settings for CERN
;;-----------------------------------------------------------

;;(if (not window-system) ;; Only use in tty-sessions.
;;    (progn
;;      (defvar arrow-keys-map (make-sparse-keymap) "Keymap for arrow keys")
;;      (define-key esc-map "[" arrow-keys-map)
;;      (define-key arrow-keys-map "A" 'previous-line)
;;      (define-key arrow-keys-map "B" 'next-line)
;;      (define-key arrow-keys-map "C" 'forward-char)
;;      (define-key arrow-keys-map "D" 'backward-char)))

(if (not window-system)
    (normal-erase-is-backspace-mode 0))

(setq bookmark-default-file "~/bak/emacs/sx-orca.bmk")

(setq inhibit-startup-screen t)

(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))

;;-----------------------------------------------------------
;; Terminal
;;-----------------------------------------------------------

;; (require 'multi-term)
(autoload 'multi-term "multi-term" "" t)

;; Python 
;(setq interpreter-mode-alist (cons '("python" . python-mode)
;				   interpreter-mode-alist))
;(autoload 'python-mode "python-mode" "Python editing mode." t)

