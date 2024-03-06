;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Jordan Moore"
      user-mail-address "lockbox@struct.foo")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
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

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/d/notes/")


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

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
(setq doom-theme 'doom-Iosvkem)

;; don't display line numbers
(setq display-line-numbers-type nil)

;; don't confirm exit
(setq confirm-kill-emacs nil)

;; keep backups etc.
(setq auto-save-default t)

;; CTRL+K removes entire line when at the beginning
(setq kill-whole-line t)

;; Move between windows plz
(windmove-default-keybindings)

;; Prevents some cases of Emacs flickering.
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

;; Allow mixed fonts in a buffer. This is particularly useful for Org mode,
;; so you can mix source and prose blocks in the same document. Also manually
;; enable solaire-mode in Org mode as a workaround for font scaling not working properly.
                                        ;(add-hook! 'org-mode-hook #'mixed-pitch-mode)
                                        ;(add-hook! 'org-mode-hook #'solaire-mode)
                                        ;(setq mixed-pitch-variable-pitch-cursor nil)

;; wordcount in markdown, gfm and org mode
(setq doom-modeline-enable-word-count t)

;; emacs redo
(after! undo-fu
  (map! :map undo-fu-mode-map "C-?" #'undo-fu-only-redo))

;; options for numpydoc
(after! numpydoc
  (map! "C-c C-n" #'numpydoc-generate))
(setq numpydoc-insert-examples-block nil)

;; jump to matching paren / bracket
;; copied from https://zzamboni.org/post/my-doom-emacs-configuration-with-commentary/
(after! smartparens
  (defun zz/goto-match-paren (arg)
    "Go to the matching paren/bracket, otherwise (or if ARG is not
    nil) insert %.  vi style of % jumping to matching brace."
    (interactive "p")
    (if (not (memq last-command '(set-mark
                                  cua-set-mark
                                  zz/goto-match-paren
                                  down-list
                                  up-list
                                  end-of-defun
                                  beginning-of-defun
                                  backward-sexp
                                  forward-sexp
                                  backward-up-list
                                  forward-paragraph
                                  backward-paragraph
                                  end-of-buffer
                                  beginning-of-buffer
                                  backward-word
                                  forward-word
                                  mwheel-scroll
                                  backward-word
                                  forward-word
                                  mouse-start-secondary
                                  mouse-yank-secondary
                                  mouse-secondary-save-then-kill
                                  move-end-of-line
                                  move-beginning-of-line
                                  backward-char
                                  forward-char
                                  scroll-up
                                  scroll-down
                                  scroll-left
                                  scroll-right
                                  mouse-set-point
                                  next-buffer
                                  previous-buffer
                                  previous-line
                                  next-line
                                  back-to-indentation
                                  doom/backward-to-bol-or-indent
                                  doom/forward-to-last-non-comment-or-eol
                                  )))
        (self-insert-command (or arg 1))
      (cond ((looking-at "\\s\(") (sp-forward-sexp) (backward-char 1))
            ((looking-at "\\s\)") (forward-char 1) (sp-backward-sexp))
            (t (self-insert-command (or arg 1))))))
  (map! "%" 'zz/goto-match-paren))
;;
;; org config, largely copied from <https://github.com/james-stoup/emacs-org-mode-tutorial>
;;
(after! org
  ;; Must do this so the agenda knows where to look for my files
  (setq org-agenda-files '("~/d/notes"))

  ;; When a TODO is set to a done state, record a timestamp
  (setq org-log-done 'time)

  ;; TODO states
  (setq org-todo-keywords
        '((sequence "TODO(t)" "PLANNING(p)" "IN-PROGRESS(i@/!)" "VERIFYING(v!)" "BLOCKED(b@)"  "|" "DONE(d!)" "OBE(o@!)" "WONT-DO(w@/!)" )
          ))

  ;; TODO colors
  (setq org-todo-keyword-faces
        '(
          ("TODO" . (:foreground "GoldenRod" :weight bold))
          ("PLANNING" . (:foreground "DeepPink" :weight bold))
          ("IN-PROGRESS" . (:foreground "Cyan" :weight bold))
          ("VERIFYING" . (:foreground "DarkOrange" :weight bold))
          ("BLOCKED" . (:foreground "Red" :weight bold))
          ("DONE" . (:foreground "LimeGreen" :weight bold))
          ("OBE" . (:foreground "LimeGreen" :weight bold))
          ("WONT-DO" . (:foreground "LimeGreen" :weight bold))
          ))

  ;; custom org-capture templates
  (setq org-capture-templates
        '(
          ("j" "Work Log Entry"
           entry (file+datetree "~/d/notes/work-log.org")
           "* %?"
           :empty-lines 0)
          ("n" "Note"
           entry (file+headline "~/d/notes/notes.org" "Notes")
           "** %?"
           :empty-lines 0)
          ("g" "General To-Do"
           entry (file+headline "~/d/notes/todo.org" "Tasks")
           "* TODO [#B] %?\n:Created: %T\n "
           :empty-lines 0)
          ("c" "Code To-Do"
           entry (file+headline "~/d/notes/todo.org" "Code Related Tasks")
           "* TODO [#B] %?\n:Created: %T\n%i\n%a\nProposed Solution: "
           :empty-lines 0)
          ("m" "Meeting"
           entry (file+datetree "~/d/notes/meetings.org")
           "* %? :meeting:%^g \n:Created: %T\n** Attendees\n*** \n** Notes\n** Action Items\n*** TODO [#A] "
           :tree-type week
           :clock-in t
           :clock-resume t
           :empty-lines 0)
          ))
  )
