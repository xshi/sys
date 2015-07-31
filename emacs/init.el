;;-----------------------------------------------------------
;; Initial Settings
;;-----------------------------------------------------------
(add-to-list 'load-path "~/.sys/emacs") 


;;-----------------------------------------------------------
;; Load Packages
;;-----------------------------------------------------------
(load "sx-set")
(load "sx-fun")
(load "sx-key")

(add-hook 
 'after-init-hook 
 (lambda () 
   (cond 
    ((string-match "lns.cornell.edu" system-name) (load "sx-lepp"))
    ((string-match "WHOLPHIN" system-name) (load "sx-wholphin"))
    ((string-match "orca" system-name) (load "sx-orca")))))

