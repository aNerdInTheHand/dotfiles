(setq ns-right-option-modifier 'none)
(setq ns-option-modifier 'meta)
(load-theme 'wheatgrass t)
(if (window-system)
  (set-frame-size (selected-frame) 124 60))
(setq org-capture-templates
      '(
        ("s" "Song"
         entry (file+headline "~/org/songs.org" "Songs")
         "* WRITING %?\nCreated at: %T\n:PROPERTIES:\n:CATEGORY: SONG\n:END:\n\n** Lyrics & Chords\n\nVerse 1\n\n** Studio Notes\n\n*** Song Structure\n| Part | Bars |\n| Intro | 4 |\n*** Instruments\n| Part | Instrument (pup) | Amp (Tonex Preset) | FX (Helix Preset) |\n| Rhythm | LP (brd) | Fen Twin (Tx:22) | Cln Strat |\n")
        ("lt" "Task" entry
         (file+headline "~/org/tasks.org" "Life Tasks")
         "* TODO %?\n:PROPERTIES:\n:CATEGORY: TASK\n:END:\n")
	("h" "Haiku" entry
         (file+headline "~/org/haikus.org" "Haikus")
         "* WRITING %? %^g \n:PROPERTIES:\n:Category: REPLACE\n:Written at: %T\n:END:\n")
	("td" "TDD" entry
	 (file+headline "~/org/work.org" "Tickets")
	 "* NOT-STARTED %?\n:PROPERTIES:\nCATEGORY: TDD-TICKET\n:END:\n")
	("t" "To-Do To-Day"
	 entry (file+datetree "~/worg/daily_tasks.org")
	 "* TODO %?\n:task:%^g \n:Created: %T\n\n** Notes "
	 :tree-type week)
	("m" "Meeting"
         entry (file+datetree "~/worg/meetings.org")
         "* %? :meeting:%^g \n:Created: %T\n** Attendees\n*** \n** Notes\n** Action Items\n*** TODO [#A] "
         :tree-type week
         :clock-in t
         :clock-resume t
         :empty-lines 1)
	("o" "One-to-one"
         entry (file+datetree "~/worg/personal_development.org")
         "* %? :one-to-one:%^g \n:Created: %T\n** Notes\n** Action Items\n*** TODO [#A] "
         :tree-type month
         :clock-in t
         :clock-resume t
         :empty-lines 1)
       ("p" "Pairing"
        entry (file+datetree "~/worg/pairing.org")
        "* %? :pairing:%^g \n:Created: %T\n** Attendees\n*** \n** Notes\n** Action Items\n "
	:tree-type week
	:clock-in t
	:clock-resume t
	:empty-lines 1)
       ("r" "Support"
        entry (file+datetree "~/worg/support.org")
        "* TODO %? :support:%^g \n:Started: %T\n:Ticket: \n** Notes\n *Helpful SQL\n *Solution\n "
	:tree-type week
	:clock-in t
	:clock-resume t
	:empty-lines 1)
       ))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files '("~/worg")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

;; Make the indentation look nicer
(add-hook 'org-mode-hook 'org-indent-mode)

;; Wrap the lines in org mode so that things are easier to read
(add-hook 'org-mode-hook 'visual-line-mode)
