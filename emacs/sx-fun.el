;;-----------------------------------------------------------
; Agenda
;;-----------------------------------------------------------

(defun sx-agenda-day-view ()
   (interactive "*")
   (org-agenda-list 1)
   )

;;-----------------------------------------------------------
; Comment Region
;;-----------------------------------------------------------

(defun sx-comment-region-with-colon (begin end)
   (interactive "r")
   (let (cs)
    (setq cs comment-start)
    (setq comment-start ": ")
    (comment-region begin end)
    (setq comment-start cs)
   ))


;;-----------------------------------------------------------
; Insert Snippet
;;-----------------------------------------------------------

(defun sx-insert ()
  (interactive)
  (message "Insert: [c]pp [l]ink [o]rg [p]ython [t]ime " )
  (let (r1)
    (setq r1 (read-char-exclusive))
    (cond 
     ((eq r1 ?c)  (call-interactively 'sx-insert-cpp))
     ((eq r1 ?l)  (call-interactively 'sx-insert-link))
     ((eq r1 ?o)  (call-interactively 'sx-insert-org))
     ((eq r1 ?p)  (call-interactively 'sx-insert-python))
     ((eq r1 ?t)  (call-interactively 'sx-insert-time))
     )))

;;-----------------------------------------------------------
; Insert C++ 
;;-----------------------------------------------------------

(defun sx-insert-cpp ()
  (interactive)
  (message "Insert cpp: [p]rint" )
  (let (r1)
    (setq r1 (read-char-exclusive))
    (cond 
     ((eq r1 ?p)  (call-interactively 'sx-insert-cpp-print)))))

(defun sx-insert-cpp-print ()
   (interactive "*")
   (insert "std::cout <<  << std::endl;")
   (backward-char 14)
   )


;;-----------------------------------------------------------
; Insert Python 
;;-----------------------------------------------------------

(defun sx-insert-python ()
  (interactive)
  (message "Insert python: [d]ebug [e]xit [i]nfo [f]lush [p]rint" )
  (let (r1)
    (setq r1 (read-char-exclusive))
    (cond 
     ((eq r1 ?d)  (call-interactively 'sx-insert-python-debug))
     ((eq r1 ?e)  (call-interactively 'sx-insert-python-exit))
     ((eq r1 ?f)  (call-interactively 'sx-insert-python-flush))
     ((eq r1 ?p)  (call-interactively 'sx-insert-python-print))
     ((eq r1 ?i)  (call-interactively 'sx-insert-python-info)))))


(defun sx-insert-python-debug ()
   (interactive "*")
   (insert "logging.debug('')")
   (backward-char 2)
   )


(defun sx-insert-python-exit ()
   (interactive "*")
   (insert "sys.exit()")
   (save-buffer)
   )

(defun sx-insert-python-flush ()
   (interactive "*")
   (insert "sys.stdout.flush()")
   )

(defun sx-insert-python-print ()
   (interactive "*")
   (insert "sys.stdout.write('\\n')")
   (backward-char 4)
   )

(defun sx-insert-python-info ()
   (interactive "*")
   (insert "logging.info('')")
   (backward-char 2)
   )


;;-----------------------------------------------------------
; Insert Lin in Wiki style 
;;-----------------------------------------------------------

(defun sx-insert-link ()
  (interactive)
  (message "Insert link: [f]ig  [l]og  [p]df-png" )
  (let (r1)
    (setq r1 (read-char-exclusive))
    (cond 
     ((eq r1 ?f)  (call-interactively 'sx-insert-link-fig))
     ((eq r1 ?l)  (call-interactively 'sx-insert-link-log))
     ((eq r1 ?p)  (call-interactively 'sx-insert-link-pdf-png)))))


(defun sx-insert-link-fig (fig)
  (interactive "sLink fig:")
  (insert (format-time-string "[[./log/%Y/%m%d/") fig "]]")
  )

(defun sx-insert-link-log (text)
  (interactive "sLink text:")
  (insert (format-time-string "[[./log/%Y/%m%d/") text "][" text"]]")
  )

(defun sx-insert-link-pdf-png (fig)
  (interactive "sLink fig(.pdf or .png):")
  (insert (format-time-string "[[./log/%Y/%m%d/") fig ".pdf]"  (format-time-string "[./log/%Y/%m%d/") fig ".png]]")
  )


(defun sx-insert-link-src-mht (text)
  (interactive "sLink text:")
  (insert "[[../../src/8.12/producer/mht/" text "][" text"]]")
  )

;;-----------------------------------------------------------
; Insert Org content
;;-----------------------------------------------------------

(defun sx-insert-org ()
  (interactive)
  (message "Insert Org: [c] check" )
  (let (r1)
    (setq r1 (read-char-exclusive))
    (cond 
     ((eq r1 ?c)  (call-interactively 'sx-insert-org-check)))))


(defun sx-insert-org-check ()
  (interactive "*")
  (insert (format-time-string "Check <%Y-%m-%d %a %H:%M>: "))
  )


(defun sx-insert-org-latex ()
   (interactive "*")
   (insert "#+BEGIN_LaTeX:\n\n\t#+END_LaTeX:\n")
   (previous-line 2)
   (insert "\t")
   )

;;-----------------------------------------------------------
; Insert Time String 
;;-----------------------------------------------------------


(defun sx-insert-time ()
  (interactive "*")
  (insert (format-time-string "[%Y-%m-%d %a %H:%M] "))
  )


;;-----------------------------------------------------------
; Mult-Term 
;;-----------------------------------------------------------

(defun sx-set-frame-name ()
   (interactive "*")
   (let (r1 frame-name)
    (message "Frame : [b]uild [o]rca [r]un")
    (setq r1 (read-char-exclusive))
    (cond 
     ((eq r1 ?b)   (setq frame-name "build"))
     ((eq r1 ?o)   (setq frame-name "orca"))
     ((eq r1 ?r)   (setq frame-name "run"))
     (setq frame-name "run"))
    ))


(defun sx-get-frame-name ()
   (interactive "*")
   (let (frame-name)
     (setq frame-name (sx-set-frame-name))
     (setq frame-name (concat "*" frame-name "<1>*"))
     ))


;; (defun sx-multi-term ()
;;   (interactive)
;;    (let (multi-term-buffer-name)
;;      (setq multi-term-buffer-name (sx-set-frame-name))
;;      (multi-term))) 
;;  remove the let for Emacs 24 

(defun sx-multi-term ()
  (interactive)
  (setq multi-term-buffer-name (sx-set-frame-name))
  (multi-term))



;;-----------------------------------------------------------
;  Exeute Command
;;-----------------------------------------------------------

(defun sx-execute ()
  (interactive)
  (message "Execute:  [x]last [c]md [r]egion")
  (let (r1)
    (setq r1 (read-char-exclusive))
    (cond 
     ((eq r1 ?x) (call-interactively 'sx-execute-last-command-in-frame))
     ((eq r1 ?c) (call-interactively 'sx-execute-cmdline-in-frame))
     ((eq r1 ?r) (call-interactively 'sx-execute-region-as-command-in-frame)))
    ))


(defun  sx-execute-cmdline-in-frame ()
  (interactive "*")
  (save-excursion
    (move-beginning-of-line 1)
    (forward-word)
    (backward-word)
    (let ((beg (point)))
    (move-end-of-line 1)
    (sx-execute-region-as-command-in-frame beg (point)))
    ))


(defun sx-execute-last-command-in-frame ()
   (interactive "*")
   (let (frame-name)
     (setq frame-name (sx-get-frame-name))
     (if (buffer-modified-p)
    	(save-buffer))
     (setq coding-buffer-name (buffer-name))
     (switch-to-buffer-other-frame frame-name)
     (term-send-up)
     (term-send-raw-string "\n")
     (switch-to-buffer-other-frame coding-buffer-name)
     ))


(defun sx-execute-region-as-command-in-frame (begin end)
   (interactive "r")
   (let (frame-name region-content)
     (setq frame-name (sx-get-frame-name))
     (setq region-content (buffer-substring begin end))
     (message region-content)
     (setq logging-buffer-name (buffer-name))
     (switch-to-buffer-other-frame frame-name)
     (term-send-raw-string region-content)
     (term-send-raw-string "\n")
     (switch-to-buffer-other-frame logging-buffer-name)
     ))



;;-----------------------------------------------------------
; Misc 
;;-----------------------------------------------------------

(defun sx-make-directory-log ()
  (interactive "*")
  (make-directory (format-time-string "./log/%Y/%m%d/") t)
  (message (format-time-string "Made directory ./log/%Y/%m%d/"))
  )


(defun sx-hide-frames()
   (interactive)
   (tabbar-mode)
   (menu-bar-mode)
   (tool-bar-mode)
   (scroll-bar-mode)
   )

(defun sx-krb-fnal ()
  (interactive "*")
  (setenv "KRB5CCNAME" "~/bak/.krb5_fnal")
  )

(defun sx-ispell-buffer ()
  "expand all collapsed org-mode nodes before doing the spell"
  (interactive)
  (show-all)
  (call-interactively 'ispell-buffer)
  )

(defun sx-revert-buffer ()
  "revert buffer without query"
  (interactive)
  (revert-buffer nil t)
  )


(defun sx-switch-buffer-coding ()
   (interactive "*")
   (switch-to-buffer coding-buffer-name)
   )

(defun sx-switch-buffer-logging ()
   (interactive "*")
   (switch-to-buffer logging-buffer-name)
   )


(defun sx-delete ()
  (interactive)
  (message "Delete: [t] TeX " )
  (let (r1)
    (setq r1 (read-char-exclusive))
    (cond 
     ((eq r1 ?t)  (call-interactively 'sx-delete-tex-files)))))


(defun sx-delete-tex-files ()
  (interactive "*")
  (cond 
   ((file-exists-p "~/work/pro/thesis/xshi-thesis.bbl") 
    (delete-file   "~/work/pro/thesis/xshi-thesis.bbl")))
  (cond 
   ((file-exists-p "~/work/pro/thesis/xshi-thesis.blg") 
    (delete-file   "~/work/pro/thesis/xshi-thesis.blg")))
  (cond 
   ((file-exists-p "~/work/pro/thesis/xshi-thesis.lof") 
    (delete-file   "~/work/pro/thesis/xshi-thesis.lof")))
  (cond 
   ((file-exists-p "~/work/pro/thesis/xshi-thesis.lot") 
    (delete-file   "~/work/pro/thesis/xshi-thesis.lot")))
  (cond 
   ((file-exists-p "~/work/pro/thesis/xshi-thesis.pdf") 
    (delete-file   "~/work/pro/thesis/xshi-thesis.pdf"))))

(defun sx-org-export-as-pdf ()
  (interactive "*")
  (org-export-as-pdf)
  (shell-command (format "osascript ~/bak/sh/refresh.scpt"))
  )
  

(defun sx-export-region-as-html (begin end) 
  (interactive "r")
   (setq this-buffer-name (buffer-name))
   (save-restriction
    (org-export-region-as-html begin end t "test.html")
    (switch-to-buffer "test.html")
    (write-file "/tmp/test.html")
    (kill-buffer "test.html")
    (switch-to-buffer this-buffer-name)
    (message "Output html done.")))


(defun sx-blogger-post (begin end) 
  (interactive "r")
  (save-restriction
    (sx-export-region-as-html begin end) 
    (shell-command "~/local/bin/bloggerpost.py")
    (message "Posted to xshi.org")))


(defun sx-org-revert-agenda-buffers ()
  (interactive)
  (mapcar
   (lambda (file)
     (let ((revert-without-query '(".*\.org$")))
       (find-file file)
       (revert-buffer)))
   (org-agenda-files t))
  (org-agenda-list 1))


(defun sx-edit ()
  (interactive)
  (message "Edit: [c]rab [d]uplicate [j]obs" )
  (let (r1)
    (setq r1 (read-char-exclusive))
    (cond 
     ((eq r1 ?c)  (call-interactively 'sx-edit-crab-create-submit))
     ((eq r1 ?d)  (call-interactively 'sx-edit-dup-line-down))
     ((eq r1 ?j)  (call-interactively 'sx-edit-crab-submit-jobs))
     )))


(defun ue-select-line-down ()
  "like Shift+down in UltraEdit."
  (interactive)
  (let ((s (point)))
  (setq next-line-add-newlines t)
  (next-line 1)
  (setq next-line-add-newlines nil)
  (kill-new (buffer-substring s (point)))))


(defun sx-edit-dup-line-down ()   
  "duplicate this line at next line"
  (interactive)
  (let ((c (current-column)))
    ;; (beginning-of-line)
    ;; (ue-select-line-down)
    ;; (beginning-of-line)
    (kill-whole-line)
    (yank)
    (yank)
    (previous-line 1)
    (move-to-column c)))


(defun sx-edit-crab-create-submit ()   
  "Edit crab command create to submit"
  (interactive)
  (sx-edit-dup-line-down)
  (move-beginning-of-line 1)
  (forward-word 2)
  (delete-backward-char 2)
  (move-end-of-line 1)
  (backward-kill-word 2)
  (delete-backward-char 1)
  (insert " -submit 1-500"))


(defun sx-edit-crab-submit-jobs ()   
  "Edit crab command to submit jobs"
  (interactive)
  (sx-edit-dup-line-down)
  (move-end-of-line 1)
  (backward-word 2)
  (insert (number-to-string (+ 500 (string-to-number (thing-at-point 'word)))))
  (kill-word 1)
  (forward-char 1)
  (insert (number-to-string (+ 500 (string-to-number (thing-at-point 'word)))))
  (kill-word 1) )



(defun unfill-region (start end)
  (interactive "r")
  (let ((fill-column (point-max)))
    (fill-region start end nil)))


(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))


