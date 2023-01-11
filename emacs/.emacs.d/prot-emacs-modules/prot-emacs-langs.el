
;;; Plain text (text-mode)
(prot-emacs-builtin-package 'text-mode
  (add-to-list 'auto-mode-alist '("\\(README\\|CHANGELOG\\|COPYING\\|LICENSE\\)\\'" . text-mode)))

;;; Markdown (markdown-mode)
(prot-emacs-elpa-package 'markdown-mode
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
  (setq markdown-fontify-code-blocks-natively t))

;;; YAML (yaml-mode)
(prot-emacs-elpa-package 'yaml-mode
  (add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-mode)))

;;; JavaScript and extras
;; I build Emacs from source with support for tree-sitter.  Since I
;; use Arch Linux, I also install the `aur/tree-sitter-javascript-git'
;; package.
(prot-emacs-builtin-package 'js)

(prot-emacs-elpa-package 'js-comint)

;;; CSS (css-mode)
(prot-emacs-builtin-package 'css-mode
  (add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))
  (add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
  (setq css-fontify-colors nil))

;;; Shell scripts (sh-mode)
(prot-emacs-builtin-package 'sh-script
  (add-to-list 'auto-mode-alist '("PKGBUILD" . sh-mode)))

;;; SXHKDRC mode (one of my many packages)
(prot-emacs-elpa-package 'sxhkdrc-mode
  ;; By default, it only applies to the sxhkdrc file, but I have other
  ;; relevant entries as well.  I separate my keys into different
  ;; modules and load only what I need.
  (add-to-list 'auto-mode-alist '("sxhkdrc_.*" . sxhkdrc-mode)))

;;; Paragraphs and fill-mode
(setq sentence-end-double-space t)
(setq sentence-end-without-period nil)
(setq colon-double-space nil)
(setq use-hard-newlines nil)
(setq adaptive-fill-mode t)
(add-hook 'text-mode-hook #'turn-on-auto-fill)

;;; Comments (newcomment.el and prot-comment.el)
(prot-emacs-builtin-package 'newcomment
  (setq comment-empty-lines t)
  (setq comment-fill-column nil)
  (setq comment-multi-line t)
  (setq comment-style 'multi-line)
  (let ((map global-map))
    (define-key map (kbd "C-:") #'comment-kill)         ; C-S-;
    (define-key map (kbd "M-;") #'comment-indent)))

(prot-emacs-builtin-package 'prot-comment
  (setq prot-comment-comment-keywords
        '("TODO" "NOTE" "XXX" "REVIEW" "FIXME"))
  (setq prot-comment-timestamp-format-concise "%F")
  (setq prot-comment-timestamp-format-verbose "%F %T %z")
  (let ((map global-map))
    (define-key map (kbd "C-;") #'prot-comment-comment-dwim)
    (define-key map (kbd "C-x C-;") #'prot-comment-timestamp-keyword)))

;;; Configure 'electric' behaviour
(prot-emacs-builtin-package 'electric
  (setq electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)
  (setq electric-pair-preserve-balance t)
  (setq electric-pair-pairs
        '((8216 . 8217)
          (8220 . 8221)
          (171 . 187)))
  (setq electric-pair-skip-self 'electric-pair-default-skip-self)
  (setq electric-pair-skip-whitespace nil)
  (setq electric-pair-skip-whitespace-chars '(9 10 32))
  (setq electric-quote-context-sensitive t)
  (setq electric-quote-paragraph t)
  (setq electric-quote-string nil)
  (setq electric-quote-replace-double t)
  (electric-pair-mode -1)
  (electric-quote-mode -1)
  ;; I don't like auto indents in Org and related.  They are okay for
  ;; programming.
  (electric-indent-mode -1)
  (add-hook 'prog-mode-hook #'electric-indent-local-mode))

;;; Parentheses (show-paren-mode)
(prot-emacs-builtin-package 'paren
  (setq show-paren-style 'parenthesis)
  (setq show-paren-when-point-in-periphery nil)
  (setq show-paren-when-point-inside-paren nil)
  (setq show-paren-context-when-offscreen 'child-frame) ; Emacs 29
  (add-hook 'after-init-hook #'show-paren-mode))

;;; Tabs, indentation, and the TAB key
(setq-default tab-always-indent 'complete)
(setq-default tab-first-completion 'word-or-paren-or-punct) ; Emacs 27
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;;; Flyspell and prot-spell.el (spell check)
(prot-emacs-builtin-package 'flyspell
  (setq flyspell-issue-message-flag nil)
  (setq flyspell-issue-welcome-flag nil)
  (setq ispell-program-name "aspell")
  (setq ispell-dictionary "en_GB")
  (define-key flyspell-mode-map (kbd "C-;") nil)
  (define-key ctl-x-x-map "s" #'flyspell-mode)) ; C-x x s

(prot-emacs-builtin-package 'prot-spell
  (setq prot-spell-dictionaries
        '(("EN English" . "en")
          ("EL Ελληνικά" . "el")
          ("FR Français" . "fr")
          ("ES Espanõl" . "es")))

  ;; Also check prot-spell.el for what I am doing with
  ;; `prot-spell-ispell-display-buffer'.  Then refer to the
  ;; `display-buffer-alist' for the relevant entry.

  (let ((map global-map))
    (define-key map (kbd "M-$") #'prot-spell-spell-dwim)
    (define-key map (kbd "C-M-$") #'prot-spell-change-dictionary)))

;;; Dictionary
(prot-emacs-builtin-package 'dictionary
  (setq dictionary-server "dict.org"
          dictionary-default-popup-strategy "lev" ; read doc string
          dictionary-create-buttons nil
          dictionary-use-single-buffer t)
  (define-key global-map (kbd "C-c d") #'dictionary-search))

;;; Flymake
(prot-emacs-builtin-package 'flymake
  (setq flymake-fringe-indicator-position 'left-fringe)
  (setq flymake-suppress-zero-counters t)
  (setq flymake-start-on-flymake-mode t)
  (setq flymake-no-changes-timeout nil)
  (setq flymake-start-on-save-buffer t)
  (setq flymake-proc-compilation-prevents-syntax-check t)
  (setq flymake-wrap-around nil)
  (setq flymake-mode-line-format
        '("" flymake-mode-line-exception flymake-mode-line-counters))
  (setq flymake-mode-line-counter-format
        '(" " flymake-mode-line-error-counter
          flymake-mode-line-warning-counter
          flymake-mode-line-note-counter ""))

  (defvar prot/flymake-mode-projects-path
    (file-name-as-directory (expand-file-name "Projects" "~/Git/"))
    "Path to my Git projects.")

  (defun prot/flymake-mode-lexical-binding ()
    (when lexical-binding
      (flymake-mode 1)))

  (defun prot/flymake-mode-in-my-projects ()
    (when-let* ((file (buffer-file-name))
                ((string-prefix-p prot/flymake-mode-projects-path
                                  (expand-file-name file)))
                ((not (file-directory-p file)))
                ((file-regular-p file)))
      (add-hook 'find-file-hook #'prot/flymake-mode-lexical-binding nil t)))

  (add-hook 'emacs-lisp-mode-hook #'prot/flymake-mode-in-my-projects)

  (define-key ctl-x-x-map "m" #'flymake-mode) ; C-x x m
  (let ((map flymake-mode-map))
    (define-key map (kbd "C-c ! s") #'flymake-start)
    (define-key map (kbd "C-c ! d") #'flymake-show-buffer-diagnostics) ; Emacs28
    (define-key map (kbd "C-c ! D") #'flymake-show-project-diagnostics) ; Emacs28
    (define-key map (kbd "C-c ! n") #'flymake-goto-next-error)
    (define-key map (kbd "C-c ! p") #'flymake-goto-prev-error)))

;;; Flymake + Shellcheck
(prot-emacs-elpa-package 'flymake-shellcheck
  (add-hook 'sh-mode-hook 'flymake-shellcheck-load))

;;; Flymake + Proselint
(prot-emacs-elpa-package 'flymake-proselint
  (add-hook 'text-mode-hook #'flymake-proselint-setup))

;;; Elisp packaging requirements
(prot-emacs-elpa-package 'package-lint-flymake
  (add-hook 'flymake-diagnostic-functions #'package-lint-flymake))

;;; Eldoc (elisp live documentation feedback)
(prot-emacs-builtin-package 'eldoc
  (global-eldoc-mode 1))

;;; Handle performance for very long lines (so-long.el)
(prot-emacs-builtin-package 'so-long
  (global-so-long-mode 1))

(provide 'prot-emacs-langs)
