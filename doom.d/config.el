;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "YuviPanda"
      user-mail-address "yuvipanda@gmail.com")

(setq doom-font (font-spec :family "JetBrains Mono" :size 14)
      doom-big-font (font-spec :family "JetBrains Mono" :size 20))

(require 'lsp-python-ms)
(setq lsp-python-ms-auto-install-server t)

;; Something slightly more bright than the default
;; (setq doom-theme "doom-one")
;;
;; Relative line numbering is far more useful than absolute
(setq doom-line-numbers-style 'relative)
;; Auto-save
(setq auto-save-default t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

; Auto-save *everything* whenever we lose focus
(add-hook 'focus-out-hook (lambda () (save-some-buffers t)))

;; Given that I use only one workspace, switching between buffers is
;; way more common than switching between files in a project. So
;; let's bind them appropriately
(map! :leader :desc "Switch Buffers" "SPC" #'switch-to-buffer)
(map! :leader :desc "Find file in project" "," #'projectile-find-file)
;; M-x is also gonna be used far more than eval buffer
(map! :leader :desc "M-x" ";" #'execute-extended-command)
(map! :leader :desc "Eval expression" ":" #'pp-eval-expression)
;;
;; This is where all my 'projects' are.
;; I can switch between them easily without having to manually open them
(setq projectile-project-search-path '("~/code/"))

;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
