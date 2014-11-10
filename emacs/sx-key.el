;;-----------------------------------------------------------
; Gloable Key Bindings
;;-----------------------------------------------------------
(global-set-key "\M- "   'hippie-expand)
(global-set-key (kbd "C-x C-b") 'buffer-menu)

(global-set-key (quote [67108907]) (quote redo))

(global-set-key "\C-ca"   'sx-agenda-day-view)
; (global-set-key "\C-cA"   'sx-org-revert-agenda-buffers)

(global-set-key "\C-ccr"  'comment-region)

(global-set-key "\C-ce"   'sx-edit)
(global-set-key "\C-cd"   'sx-delete)

(global-set-key "\C-ci"   'sx-insert)
(global-set-key "\C-ck"   'org-capture)
(global-set-key "\C-cl"   'org-store-link)

; (global-set-key "\C-cmdl" 'sx-make-directory-log)

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


;;-----------------------------------------------------------
;; Outline-minor-mode
;;-----------------------------------------------------------

(defmacro define-context-key (keymap key dispatch)
  "Define KEY in KEYMAP to execute according to DISPATCH.

DISPATCH is a form that is evaluated and should return the
command to be executed.

If DISPATCH returns nil, then the command normally bound to KEY
will be executed.

Example:

  (define-context-key hs-minor-mode-map
     (kbd \"<C-tab>\")
     (cond
      ((not (hs-already-hidden-p))
       'hs-hide-block)
      ((hs-already-hidden-p)
       'hs-show-block)))

This will make <C-tab> show a hidden block.  If the block is
shown, then it'll be hidden."
  `(define-key ,keymap ,key
     `(menu-item "context-key" ignore
                 :filter ,(lambda (&optional ignored)
                            ,dispatch))))

(defun th-outline-context-p ()
  "Non-nil if `point' is on an outline-heading."
  (save-excursion
    (goto-char (line-beginning-position))
    (looking-at outline-regexp)))

(add-hook 'LaTeX-mode-hook
          '(lambda ()
             (outline-minor-mode 1)
             (define-context-key outline-minor-mode-map
               (kbd "TAB") (when (th-outline-context-p) 'org-cycle))))


;;-----------------------------------------------------------
;; helm-minor-mode
;;-----------------------------------------------------------
(add-hook 'helm-mode-hook
	  (lambda ()
	    (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
	    (define-key helm-map (kbd "C-z") 'helm-select-action)
	    ))

