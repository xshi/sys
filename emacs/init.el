;;-----------------------------------------------------------
;; Initial Settings
;;-----------------------------------------------------------

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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

