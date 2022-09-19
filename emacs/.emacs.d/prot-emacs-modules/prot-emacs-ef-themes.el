;;; The Ef (εὖ) themes

;; (prot-emacs-elpa-package 'ef-themes
;;
;;   (setq ef-themes-variable-pitch-ui t
;;         ef-themes-mixed-fonts t
;;         ef-themes-headings ; read the manual's entry of the doc string
;;         '((0 . (variable-pitch light 1.9))
;;           (1 . (variable-pitch light 1.8))
;;           (2 . (variable-pitch regular 1.7))
;;           (3 . (variable-pitch regular 1.6))
;;           (4 . (variable-pitch regular 1.5))
;;           (5 . (variable-pitch 1.4)) ; absence of weight means `bold'
;;           (6 . (variable-pitch 1.3))
;;           (7 . (variable-pitch 1.2))
;;           (t . (variable-pitch 1.1))))
;;
;;   ;; The `ef-themes' provide lots of themes.  I want to pick one at
;;   ;; random when I start Emacs: the `ef-themes-load-random' does just
;;   ;; that (it can be called interactively as well).  I just check with
;;   ;; GNOME to determine if the choice should be about a light or a dark
;;   ;; theme.
;;   (if (string-match-p
;;        "dark"
;;        (shell-command-to-string "gsettings get org.gnome.desktop.interface color-scheme"))
;;       (ef-themes-load-random 'dark)
;;     (ef-themes-load-random 'light))
;;
;;   (define-key global-map (kbd "<f5>") #'ef-themes-select))



;; NOTE: For testing pursposes
(progn
  (mapc #'disable-theme custom-enabled-themes)

  (add-to-list 'load-path "/home/prot/Git/Projects/ef-themes/")

  (require 'ef-themes)
  (load-theme 'ef-autumn t t)
  (load-theme 'ef-dark t t)
  (load-theme 'ef-day t t)
  (load-theme 'ef-light t t)
  (load-theme 'ef-night t t)
  (load-theme 'ef-spring t t)
  (load-theme 'ef-summer t t)
  (load-theme 'ef-winter t t)
  (load-theme 'ef-deuteranopia-dark t t)
  (load-theme 'ef-deuteranopia-light t t)
  (load-theme 'ef-duo-dark t t)
  (load-theme 'ef-duo-light t t)

  (setq ef-themes-headings ; read the manual's entry or the doc string
        '((0 . (variable-pitch light 1.9))
          (1 . (variable-pitch light 1.8))
          (2 . (variable-pitch light 1.7))
          (3 . (variable-pitch semilight 1.6))
          (4 . (variable-pitch semilight 1.5))
          (5 . (variable-pitch regular 1.4))
          (6 . (variable-pitch regular 1.3))
          (7 . (variable-pitch 1.2))    ; absence of weight means `bold'
          (t . (variable-pitch 1.1))))

  ;; They are nil by default...
  (setq ef-themes-mixed-fonts t
        ef-themes-variable-pitch-ui t)

  (mapcar (lambda (theme)
            (add-to-list
             'custom-theme-load-path
             (concat "/home/prot/Git/Projects/ef-themes/" (symbol-name theme) "-theme.el")))
          (ef-themes--list-enabled-themes))

  ;; The `ef-themes' provide lots of themes.  I want to pick one at
  ;; random when I start Emacs: the `ef-themes-load-random' does just
  ;; that (it can be called interactively as well).  I just check with
  ;; GNOME to determine if the choice should be about a light or a dark
  ;; theme.
  (if (string-match-p
       "dark"
       (shell-command-to-string "gsettings get org.gnome.desktop.interface color-scheme"))
      (ef-themes-load-random 'dark)
    (ef-themes-load-random 'light))

  (define-key global-map (kbd "<f5>") #'ef-themes-select))

(provide 'prot-emacs-ef-themes)