;;-----------------------------------------------------------
; Gloable Key Bindings
;;-----------------------------------------------------------
(global-set-key "\M- "   'hippie-expand)
(global-set-key (kbd "C-x C-b") 'buffer-menu)

(global-set-key (quote [67108907]) (quote redo))

(global-set-key "\C-ccr"  'comment-region)

(global-set-key "\C-ce"   'sx-edit)
(global-set-key "\C-cd"   'sx-delete)

(global-set-key "\C-ci"   'sx-insert)

(global-set-key "\C-cq"   'quick-calc)
(global-set-key "\C-crb"  'sx-revert-buffer)

(global-set-key "\C-ct"   'sx-multi-term)
(global-set-key "\C-cuc"  'uncomment-region)
(global-set-key "\C-cx"   'sx-execute)

(global-set-key (kbd "<C-tab>")   'switch-to-prev-buffer)
(global-set-key (kbd "<C-S-tab>") 'switch-to-next-buffer)

(global-set-key (kbd "C-c 1")  (lambda () (interactive) (point-to-register ?1))) 
(global-set-key (kbd "C-1")  (lambda () (interactive) (jump-to-register ?1))) 

(global-set-key (kbd "C-c 2")  (lambda () (interactive) (point-to-register ?2))) 
(global-set-key (kbd "C-2")  (lambda () (interactive) (jump-to-register ?2))) 

(global-set-key (kbd "C-c 3")  (lambda () (interactive) (point-to-register ?3))) 
(global-set-key (kbd "C-3")  (lambda () (interactive) (jump-to-register ?3))) 

(global-set-key (kbd "C-c 4")  (lambda () (interactive) (point-to-register ?4))) 
(global-set-key (kbd "C-4")  (lambda () (interactive) (jump-to-register ?4))) 

(global-set-key (kbd "C-c 5")  (lambda () (interactive) (point-to-register ?5))) 
(global-set-key (kbd "C-5")  (lambda () (interactive) (jump-to-register ?5))) 

(global-set-key (kbd "C-c 6")  (lambda () (interactive) (point-to-register ?6))) 
(global-set-key (kbd "C-6")  (lambda () (interactive) (jump-to-register ?6))) 

(global-set-key (kbd "C-c 7")  (lambda () (interactive) (point-to-register ?7))) 
(global-set-key (kbd "C-7")  (lambda () (interactive) (jump-to-register ?7))) 

(global-set-key (kbd "C-c 8")  (lambda () (interactive) (point-to-register ?8))) 
(global-set-key (kbd "C-8")  (lambda () (interactive) (jump-to-register ?8))) 

(global-set-key (kbd "C-c 9")  (lambda () (interactive) (point-to-register ?9))) 
(global-set-key (kbd "C-9")  (lambda () (interactive) (jump-to-register ?9))) 

(global-set-key (kbd "C-c 0")  (lambda () (interactive) (point-to-register ?0))) 
(global-set-key (kbd "C-0")  (lambda () (interactive) (jump-to-register ?0))) 

(global-unset-key  (kbd "C-z") )


;-----------------------------------------------------------
;; Semantic-mode
;-----------------------------------------------------------
(add-hook 'semantic-mode-hook '(lambda ()
				 (global-semantic-mru-bookmark-mode t) 
				 (global-set-key "\C-cj"   'semantic-ia-fast-jump)
				 (global-set-key "\C-c-"   'senator-fold-tag)
				 (global-set-key "\C-c+"   'senator-unfold-tag)
				 ))
