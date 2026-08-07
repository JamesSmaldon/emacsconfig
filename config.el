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

(setq doom-font (font-spec :family "DejaVuSansM Nerd Font Mono" :size 14)
      doom-symbol-font (font-spec :family "DejaVuSansM Nerd Font Mono"))

;; treemacs' bundled "Default" theme has explicit icons (keyed by exact,
;; lowercased filename) for special extensionless files like "makefile" and
;; "docker-compose.yml" that `nerd-icons-extension-icon-alist' has no entry
;; for. `treemacs-nerd-icons' only reads that alist when it builds its own
;; theme, so those names silently fall through to Default's fixed 22x22px
;; PNGs, misaligned next to every other file's scalable glyph icon.
;;
;; Patching the alist itself (rather than the already-built theme) means
;; this survives any number of theme rebuilds, e.g. the one `lsp-treemacs'
;; triggers per the HACK comment in Doom's own treemacs config: every
;; rebuild reads this alist fresh, so a one-time downstream patch would get
;; silently discarded the next time it happens, however many times that is.
;; Reloading the library below re-triggers `(provide 'treemacs-nerd-icons)',
;; which re-fires this very `after!' block (feature-load hooks fire on
;; every load of that feature, not just the first) -- an unguarded reload
;; here recurses forever. This flag makes the fix run exactly once.
(defvar +treemacs-nerd-icons-fix-applied nil)
(after! treemacs-nerd-icons
  (unless +treemacs-nerd-icons-fix-applied
    (setq +treemacs-nerd-icons-fix-applied t)
    (maphash
     (lambda (key _val)
       (when (and (stringp key)
                  (not (assoc key nerd-icons-extension-icon-alist)))
         (let* ((capitalized (concat (upcase (substring key 0 1)) (substring key 1)))
                ;; treemacs strips a leading dot when computing a dotfile's
                ;; "extension" (".envrc" -> "envrc"), but nerd-icons' own
                ;; regexp rules for such dotfiles expect the literal dot, so
                ;; try that form too -- excluding its generic "^\\." catch-all
                ;; for unrecognized dotfiles, which matches almost any key
                ;; here and would produce a wrong icon, not a missing one.
                (dotted-entry (assoc (concat "." key) nerd-icons-regexp-icon-alist
                                      #'string-match))
                (dot-match (when (and dotted-entry (not (equal (car dotted-entry) "^\\.")))
                             (cdr dotted-entry)))
                (match (or (nerd-icons-match-to-alist key nerd-icons-regexp-icon-alist)
                           (cdr (assoc key nerd-icons-extension-icon-alist))
                           (nerd-icons-match-to-alist capitalized nerd-icons-regexp-icon-alist)
                           dot-match)))
           (when match
             (push (cons key match) nerd-icons-extension-icon-alist)))))
     (treemacs-theme->gui-icons (treemacs--find-theme "Default")))
    ;; Rebuild "nerd-icons" from the now-patched alist, and force existing
    ;; treemacs buffers to redraw: icons are inserted as literal text at
    ;; render time, not looked up dynamically, so an already-open panel
    ;; won't reflect this until it's rebuilt from scratch.
    (load (locate-library "treemacs-nerd-icons"))
    (treemacs-load-theme "nerd-icons")
    (dolist (buf (buffer-list))
      (when (eq (buffer-local-value 'major-mode buf) 'treemacs-mode)
        (kill-buffer buf)))))

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
(setq org-agenda-files '("~/org/"))


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
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

;; (after! dap-mode
;;   (setq dap-python-debugger 'debugpy))

(setenv "SHOPPING_API_URL" "http://192.168.1.85:8081")
(setenv "CGO_CFLAGS" "-O2")


(defun my/open-cheatsheet ()
  "Open personal cheatsheet in a popup."
  (interactive)
  (let ((buf (find-file-noselect "~/.config/doom/cheatsheet.md")))
    (pop-to-buffer buf)))

(set-popup-rule! "\\*?cheatsheet\\*?" :side 'right :size 0.4 :select t :quit t)

(map! :leader
      :desc "Cheatsheet" "h C" #'my/open-cheatsheet)


;; Try to ensure that links are clickable in the terminal.
(add-hook 'vterm-mode-hook #'goto-address-mode)
(add-hook 'vterm-mode-hook #'compilation-shell-minor-mode)

;; When opening a buffer after a clicking a link in the terminal, it opens in "MOTION" mode
;; which means vim bindings don't work. This is confusing. This config should make it so that
;; Evil mode is always active.
;;
;; Ensure evil-mode is active in compilation-linked buffers
(add-hook 'find-file-hook #'evil-normalize-keymaps)


;; (use-package! dape
;;   :bind (("<f5>"  . dape)
;;          ("<f6>"  . dape-next)
;;          ("<f7>"  . dape-step-in)
;;          ("<f8>"  . dape-step-out)
;;          ("<f9>"  . dape-breakpoint-toggle)
;;          ("<f10>" . dape-continue))
;;   :config
;;   (add-hook 'dape-display-source-hook #'pulse-momentary-highlight-one-line)
;;   (remove-hook 'dape-start-hook 'dape-repl)

;;   (with-eval-after-load 'dape
;;     (add-to-list 'dape-configs
;;                  '(dlv-test
;;                    modes (go-mode go-ts-mode)
;;                    ensure dape-ensure-command
;;                    command "dlv"
;;                    command-args ("dap" "--listen" "127.0.0.1::autoport")
;;                    command-cwd dape-command-cwd
;;                    command-insert-stderr t
;;                    port :autoport
;;                    :request "launch"
;;                    :type "go"
;;                    :mode "test"
;;                    :cwd "."
;;                    :program "."))))

;; (defun my/dape-go-test-current ()
;;   "Debug the Go test function at point."
;;   (interactive)
;;   (let ((test-name (car (split-string (or (which-function) "") " "))))
;;     (unless test-name
;;       (user-error "No function at point"))
;;     (dape `(modes (go-mode go-ts-mode)
;;             ensure dape-ensure-command
;;             command "dlv"
;;             command-args ("dap" "--listen" "127.0.0.1::autoport")
;;             command-cwd ,default-directory
;;             command-insert-stderr t
;;             port :autoport
;;             :request "launch"
;;             :type "go"
;;             :mode "test"
;;             :cwd "."
;;             :program "."
;;             :args ["-test.v" "-test.run" ,(concat "^" test-name "$")]))))

;; (map! :leader
;;       (:prefix ("d" . "debug")
;;        :desc "Debug test at point" "t" #'my/dape-go-test-current
;;        :desc "Dape info"           "i" #'dape-info
;;        :desc "Dape quit"           "q" #'dape-quit))

;; (use-package! test-explorer
;;   :config
;;   (require 'test-explorer-python)
;;   (require 'test-explorer-elisp))

;; Register the regexp globally, before any hooks run
(after! compile
  (add-to-list 'compilation-error-regexp-alist-alist
    '(pyright "--> \\(.*\\):\\([0-9]+\\):\\([0-9]+\\)"
              1 2 (3)))
  (add-to-list 'compilation-error-regexp-alist 'pyright))

;; Then just enable the mode in the hook
(add-hook 'vterm-mode-hook #'compilation-shell-minor-mode)

(require 'dap-dlv-go)

;; (load! "~/emacs/go-test-explorer")

;; config.el
(use-package! evil-ghostel
  :after (ghostel evil)
  :hook (ghostel-mode . evil-ghostel-mode))


(use-package! inheritenv)

(use-package! ghostel)

(use-package! claude-code
  :bind-keymap
  ("C-c c" . claude-code-command-map)
  :bind
  (:repeat-map my-claude-code-map ("M" . claude-code-cycle-mode))
  :config
  (add-hook 'claude-code-process-environment-functions #'monet-start-server-function)
  (monet-mode 1)
  (claude-code-mode))

(setq claude-code-terminal-backend 'vterm)


;; Set the title of the window based on the project we're in.
(setq frame-title-format
      '((:eval
         (if (and (fboundp 'projectile-project-p) (projectile-project-p))
             (format "%s — %s" (projectile-project-name) "%b")
           "%b — Emacs"))))
