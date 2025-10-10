;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Keep line breaks when exporting songs so it doesn't auto-paragraph
(setq org-export-preserve-breaks t
      org-export-with-fixed-width t)

;; LaTeX defaults to pdfLaTeX which doesn't support modern system fonts
(setq org-latex-compiler "xelatex")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq doom-theme 'doom-dracula) ;; or 'doom-one, 'doom-dracula, etc.

;; Org Directory
(setq org-directory "~/org/")

;; Org-roam Setup
(after! org-roam
  (setq org-roam-directory (file-truename "~/org/roam")
        org-roam-dailies-directory "daily/"
        org-roam-completion-everywhere t)

  (org-roam-db-autosync-mode))

;; Keybindings for ease
(map! :leader
      :desc "Find node"       "n r f" #'org-roam-node-find
      :desc "Insert node"     "n r i" #'org-roam-node-insert
      :desc "Capture to node" "n r c" #'org-roam-capture
      :desc "Dailies"         "n r d" #'org-roam-dailies-goto-today)

(map! :leader
      (:prefix ("n" . "notes/roam")
       :desc "New song" "s" (lambda () (interactive) (org-roam-capture :keys "s"))
       :desc "New snippet" "l" (lambda () (interactive) (org-roam-capture :keys "l"))
       :desc "New snippet" "n" (lambda () (interactive) (org-roam-capture :keys "n"))))

(after! org-roam
  (setq org-roam-capture-templates
        '(("d" "default" plain
           "%?"
           :target (file+head "${slug}.org"
                              "#+title: ${title}\n#+date: %U\n\n")
           :unnarrowed t)

          ;; --- SONG TEMPLATE ---
          ("s" "Song" plain
           (file "~/.doom.d/templates/song-template.org")
           :target (file+head "songs/${slug}.org"
                              "#+title: ${title}\n#+filetags: :song:in-progress:\n#+date: %U\n#+OPTIONS: toc:nil num:nil title:t date:nil\n")
           :unnarrowed t)

          ;; --- SNIPPET / IDEA TEMPLATE ---
          ("n" "Snippet / Idea" plain
           (file "~/.doom.d/templates/snippet-template.org")
           :target (file+head "songs/${slug}.org"
                              "#+title: ${title}\n#+filetags: :song:snippet:\n#+date: %U\n")
           :unnarrowed t)

          ;; --- LYRIC SECTION ---
          ("l" "Lyric section" plain
              "* %^{Section|Verse|Chorus} %^N\n#+BEGIN_VERSE\n%?\n#+END_VERSE"
              :target (file+head "songs/${slug}.org"
                                "#+title: ${title}\n#+LATEX_CLASS: songbook\n#+OPTIONS: toc:nil num:nil\n")
              :unnarrowed t)

          ("a" "Album" plain
           "* Album Info\n:PROPERTIES:\n:NAME: \n:BAND: \n:RELEASED: \n:END:\n\n** About\n\n%?\n\n** Track Listing\n\n"
           :target (file+head "albums/${slug}.org"
                              "#+title: ${title}\n#+filetags: :album:\n#+date: %U\n")
           :unnarrowed t)

          ("j" "Application" plain
           "* Job Application\n:PROPERTIES:\n:COMPANY: %?\n:JOB TITLE: \n:SALARY: \n:LOCATION: \n:APPLICATION DATE: \n:END:\n\n** About\n\n"
           :target (file+head "jobs/${slug}.org"
                              "#+title: ${title}\n#+filetags: :job:\n#+date: %U\n")
           :unnarrowed t)

          ("p" "Project" plain
           "* Project\n:PROPERTIES:\n:COMPANY: %?\n:TITLE: \n:END:\n\n** 100 Word Overview\n\n** My Role\n\n** Technical Solution\n\n** Technical Challenges/Tradeoffs\n\n** Quantifiable Outcomes\n\n** Lessons Learned\n\n"
           :target (file+head "projects/${slug}.org"
                              "#+title: ${title}\n#+filetags: :project:\n#+date: %U\n")
           :unnarrowed t)

          ("w" "Writing" plain
           "* %?\n:PROPERTIES:\n:TYPE: \n:END:\n\n** Summary\n\n\n\n** Body\n\n"
           :target (file+head "writing/${slug}.org"
                              "#+title: ${title}\n#+filetags: :writing:\n#+date: %U\n")
           :unnarrowed t)

          ("r" "Review" plain
           "* Summary\n\n%?\n\n* Notes\n\n"
           :target (file+head "reviews/${slug}.org"
                              "#+title: ${title}\n#+filetags: :review:\n#+date: %U\n\n")
           :unnarrowed t))))


(add-hook 'org-mode-hook #'olivetti-mode)
(setq olivetti-body-width 80)

(use-package! org-superstar
  :hook (org-mode . org-superstar-mode))

(use-package! org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t))

(use-package! org-sql
  :after org
  :config
  (setq org-sql-connection-alist
        '((main :dbtype "sqlite3" :dbfile "~/org/roam/org-sql.db"))))


(use-package! consult-org-roam
  :after org-roam
  :hook (org-roam-mode . consult-org-roam-mode)
  :config
  (setq consult-org-roam-grep-func #'consult-ripgrep)
  (consult-org-roam-mode 1))


(setq org-todo-keywords
      '((sequence "TODO(t)" "In Progress(i)" "Needs Lyrics(l)" "Needs Chords(c)"
                  "|" "DONE(d)" "RECORDED(r)" "PUBLISHED(p)")))

(setq org-todo-keyword-faces
      '(("In Progress" . "yellow")
        ("Needs Lyrics" . "orange")
        ("Needs Chords" . "orange")
        ("RECORDED" . "light green")
        ("PUBLISHED" . "light blue")))

(setq org-agenda-files '("~/org/roam/songs"))

; (after! ox-latex
;   (add-to-list 'org-latex-classes
;                '("moderncv"
;                  "\\documentclass[11pt,a4paper,sans]{moderncv}
; \\moderncvstyle{classic}
; \\moderncvcolor{blue}"
;                  ("\\section{%s}" . "\\section*{%s}")
;                  ("\\subsection{%s}" . "\\subsection*{%s}")
;                  ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))

(after! ox-latex
  (add-to-list 'org-latex-classes
               '("songbook"
                 "\\documentclass[12pt]{article}
\\usepackage[a4paper,margin=1in,top=0.6in]{geometry}
\\usepackage{fontspec}
\\setmainfont{DejaVu Sans Mono}
\\renewcommand{\\familydefault}{\\ttdefault}
\\setcounter{secnumdepth}{0}
\\usepackage{fancyvrb}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}"))))

; (defun my/org-song-visuals ()
;   "Visual tweaks for song files."
;   (when (and buffer-file-name
;              (string-match-p "/org/roam/songs/" buffer-file-name))
;     (setq-local buffer-face-mode-face '(:family "Iosevka Term" :height 140))
;     (buffer-face-mode 1)
;     (setq-local line-spacing 0.25)
;     (hl-line-mode -1)
;     (variable-pitch-mode -1)
;     (display-line-numbers-mode -1)))

; (add-hook 'org-mode-hook #'my/org-song-visuals)

(defun my/org-song-buffer-style ()
  "Set monospace lyric font as the baseline for song buffers."
  (when (and buffer-file-name
             (string-match-p "/org/roam/songs/" buffer-file-name))
    ;; Force monospaced font
    (variable-pitch-mode -1)
    ;; Make the lyric font the baseline
    (setq-local buffer-face-mode-face
                '(:family "Iosevka Term" :height 140 :foreground "#CCCCCC"))
    (buffer-face-mode 1)
    ;; Slightly loosen spacing for readability
    (setq-local line-spacing 0.25)
    ;; Clean up distractions
    (display-line-numbers-mode -1)
    (hl-line-mode -1)))

(add-hook 'org-mode-hook #'my/org-song-buffer-style)

(defface song-lyric-face
  '((t (:foreground "#CCCCCC" :height 1.1)))
  "Face for lyric lines.")

(defface song-chord-face
  '((t (:foreground "#FFD700" :weight bold)))
  "Face for chords in song lyrics.")

(defun my/song-chord-highlighting ()
  "Highlight all chords in Org song files."
  (when (and buffer-file-name
             (string-match-p "/org/roam/songs/" buffer-file-name))
    (font-lock-add-keywords
     nil
     '(("\\b\\([A-G][#b]?\\(?:m\\|min\\|maj\\|dim\\|aug\\|sus\\|add\\|m7\\|7\\|9\\|11\\|13\\|\\+\\|-\\)?[0-9]*\\(?:/[A-G][#b]?\\)?\\)\\b"
        . 'song-chord-face)))))

(add-hook 'org-mode-hook #'my/song-chord-highlighting)

(setq doom-modeline-enable-word-count t)

;;; Custom function to insert a verse block
(defun my/insert-verse-block ()
  "Insert an org-mode #+BEGIN_VERSE ... #+END_VERSE block at point."
  (interactive)
  (insert "#+BEGIN_VERSE\n\n#+END_VERSE")
  (forward-line -1)
  (end-of-line))

(after! ox-latex
  ;; Preserve whitespace when Org exports verse blocks
  (defun my/org-latex-verse-block (verse-block contents info)
    "Export verse blocks as verbatim to preserve spacing."
    (format "\\begin{Verbatim}[fontsize=\\small,formatcom=\\ttfamily]\n%s\\end{Verbatim}" contents))
  (advice-add 'org-latex-verse-block :override #'my/org-latex-verse-block))

(map! :after org :map org-mode-map :localleader "v" #'my/insert-verse-block)

(defun my/song-tab-detect-and-toggle-overwrite ()
  "Enable overwrite mode when inside a guitar tablature block."
  (when (and (derived-mode-p 'org-mode)
             (save-excursion
               (beginning-of-line)
               (or (looking-at "^[EADGBe]|")
                   (org-between-regexps-p "^[[:space:]]*#\\+BEGIN_\\(EXAMPLE\\|TAB\\)"
                                           "^[[:space:]]*#\\+END_\\(EXAMPLE\\|TAB\\)"))))
    (unless overwrite-mode (overwrite-mode 1)))
  (when (and overwrite-mode
             (not (save-excursion
                    (beginning-of-line)
                    (or (looking-at "^[EADGBe]|")
                        (org-between-regexps-p "^[[:space:]]*#\\+BEGIN_\\(EXAMPLE\\|TAB\\)"
                                               "^[[:space:]]*#\\+END_\\(EXAMPLE\\|TAB\\)")))))
    (overwrite-mode -1)))

(add-hook 'post-command-hook #'my/song-tab-detect-and-toggle-overwrite)

;;; enable overwrite mode in guitar tab snippet
(setq yas-triggers-in-field t)
(setq yas-wrap-around-region t)

;; Per-directory settings for songs are now handled in
;; ~/org/roam/songs/.dir-locals.el
