;;-----------------------------------------------------------
;; Initial Settings
;;-----------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d")



;;-----------------------------------------------------------
;; Load Packages
;;-----------------------------------------------------------
(load "sx-set")
(load "sx-fun")
(load "sx-key")

;; Load after the elpa 
; (add-hook 'after-init-hook (lambda () (load "sx-orca")))

(add-hook 
 'after-init-hook 
 (lambda () 
   (cond 
    ((string-match "lns.cornell.edu" system-name) (load "sx-lepp"))
    ((string-match "WHOLPHIN" system-name) (load "sx-wholphin"))
    ((string-match "lxplus" system-name) (load "sx-cern"))
    ((string-match "ntucms" system-name) (load "sx-cern"))
    ((string-match "orca" system-name) (load "sx-orca")))))

