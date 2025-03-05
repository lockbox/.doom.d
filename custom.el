(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(epg-gpg-program "gpg")
 '(package-selected-packages '(debbugs))
 '(safe-local-variable-values
   '((eval with-eval-after-load 'tempel
      (if
          (stringp tempel-path)
          (setq tempel-path
                (list tempel-path)))
      (let
          ((guix-tempel-snippets
            (concat
             (expand-file-name "etc/snippets/tempel"
                               (locate-dominating-file default-directory ".dir-locals.el"))
             "/*.eld")))
        (unless
            (member guix-tempel-snippets tempel-path)
          (add-to-list 'tempel-path guix-tempel-snippets))))
     (eval progn
      (require 'lisp-mode)
      (defun emacs27-lisp-fill-paragraph
          (&optional justify)
        (interactive "P")
        (or
         (fill-comment-paragraph justify)
         (let
             ((paragraph-start
               (concat paragraph-start "\\|\\s-*\\([(;\"]\\|\\s-:\\|`(\\|#'(\\)"))
              (paragraph-separate
               (concat paragraph-separate "\\|\\s-*\".*[,\\.]$"))
              (fill-column
               (if
                   (and
                    (integerp emacs-lisp-docstring-fill-column)
                    (derived-mode-p 'emacs-lisp-mode))
                   emacs-lisp-docstring-fill-column fill-column)))
           (fill-paragraph justify))
         t))
      (setq-local fill-paragraph-function #'emacs27-lisp-fill-paragraph))
     (eval modify-syntax-entry 43 "'")
     (eval modify-syntax-entry 36 "'")
     (eval modify-syntax-entry 126 "'")
     (geiser-repl-per-project-p . t)
     (eval with-eval-after-load 'yasnippet
      (let
          ((guix-yasnippets
            (expand-file-name "etc/snippets/yas"
                              (locate-dominating-file default-directory ".dir-locals.el"))))
        (unless
            (member guix-yasnippets yas-snippet-dirs)
          (add-to-list 'yas-snippet-dirs guix-yasnippets)
          (yas-reload-all))))
     (eval setq-local guix-directory
      (locate-dominating-file default-directory ".dir-locals.el"))
     (eval add-to-list 'completion-ignored-extensions ".go")
     (eval with-eval-after-load 'tempel
      (unless
          (listp 'tempel-path)
        (setq tempel-path
              (list tempel-path)))
      (add-to-list 'tempel-path "./guix/etc/snippets/tempel/*"))
     (eval with-eval-after-load 'yasnippet
      (add-to-list 'yas-snippet-dirs "./guix/etc/snippets/yas"))
     (eval with-eval-after-load 'geiser-guile
      (add-to-list 'geiser-guile-load-path "./guix")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
