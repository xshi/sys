;;-----------------------------------------------------------
;; Put below in .gnus /or .emacs 
;;-----------------------------------------------------------
;; (add-to-list 'load-path "~/.emacs.d/std")
;; (load "sx-gnus")

(require 'gnus-demon)
(setq gnus-use-demon t)
(gnus-demon-add-handler 'gnus-group-get-new-news 10 15)
(gnus-demon-init)

