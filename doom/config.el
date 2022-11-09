;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "YuviPanda"
      user-mail-address "yuvipanda@gmail.com")

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
(setq doom-font (font-spec :family "JetBrains Mono" :size 14)
      doom-big-font (font-spec :family "JetBrains Mono" :size 20))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
;;
;; Relative line numbering is far more useful than absolute
(setq doom-line-numbers-style 'relative)
;; Auto-save
(setq auto-save-default t)
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
;; Each project should almost always have its own terminal
;; I wanna be able to switch to this terminal very quickly
(map! :leader :desc "Open Terminal for Project" "t t" #'projectile-run-vterm)

(evil-set-initial-state 'vterm-mode 'emacs);

;; This is where all my 'projects' are.
;; I can switch between them easily without having to manually open them
(setq projectile-project-search-path '("~/code/"))
;;
;; CSS indents to 2, since that's what tserver does by default
(setq css-indent-offset 2)
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


;; Python configuration
;;
;; Automatic environment activation
;;
;; Our venvs are stored under ~/.virtualenvs, with the name of the project used for
;; the name of the venv. We figure out the correct one and activate it each time we
;; switch into a python mode
;; Stolen from https://ddavis.io/posts/emacs-python-lsp/
(defun py-workon-project-venv ()
  "Call pyenv-workon with the current projectile project name.
This will return the full path of the associated virtual
environment found in $WORKON_HOME, or nil if the environment does
not exist."
  (let ((pname (projectile-project-name)))
    (pyvenv-workon pname)
    (if (file-directory-p pyvenv-virtual-env)
        pyvenv-virtual-env
      (pyvenv-deactivate))))

(add-hook 'window-configuration-change-hook 'py-workon-project-venv)
