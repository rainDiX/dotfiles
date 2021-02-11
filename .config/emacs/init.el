;; This config file is made with emacs >=27 and gccemacs in mind
;; I do not plan to support older versions

;; Default font
(set-face-attribute 'default nil :font "Iosevka 11")
;; And Emojis 🤟 nico nico nii !!!
(set-fontset-font "fontset-default" 'unicode "Noto Color Emoji")

;; Enable line number on prog mode
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(setq display-line-numbers-grow-only t)
(setq display-line-numbers-width-start t)

(setq visible-bell t)
(global-hl-line-mode 1)
(setq column-number-mode t)

(setq-default cursor-type 'bar)
(show-paren-mode)
(define-key global-map (kbd "RET") 'newline-and-indent)
;; Prefer UTF8
(prefer-coding-system 'utf-8)
(when (display-graphic-p)
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))

;; make the delete key behave like a forward looking version of backspace
(global-set-key [delete] 'delete-char)
(global-set-key [M-delete] 'kill-word)

;; use use-package to install, load & configure packages
(require 'use-package)

;; Built-in packages

;; Put backup files in .cache directory
(use-package files
  :straight nil
  :custom
  (backup-by-copying t)
  (create-lockfiles nil)
  (backup-directory-alist
   `(("." . ,(expand-file-name ".cache/backups" user-emacs-directory))))
  (auto-save-file-name-transforms
   `((".*" ,(expand-file-name ".cache/auto-save/" user-emacs-directory) t)))
  :config
  (let ((auto-save-dir (expand-file-name ".cache/auto-save/" user-emacs-directory)))
    (unless (file-exists-p auto-save-dir)
      (make-directory auto-save-dir))))

;; accept with y or n instead of full yes or no
(use-package subr
  :no-require t
  :straight nil
  :init
  (fset 'yes-or-no-p 'y-or-n-p))

;; history between sessions
(use-package savehist
  :straight nil
  :config (savehist-mode 1))

;; disable lisp interaction buffer & remove the message
(use-package startup
  :no-require t
  :straight nil
  :custom
  (initial-major-mode 'fundamental-mode)
  (initial-scratch-message ""))

;; Delete selection by typing
(use-package delsel
  :straight nil
  :init
  (delete-selection-mode t))

;; Packages
(use-package all-the-icons)

(use-package kaolin-themes
  :custom
  (kaolin-themes-bold t)
  (kaolin-themes-italic t)
  (kaolin-themes-underline t)
  (kaolin-themes-italic-comments t)
  (kaolin-themes-hl-line-colored t)
  :config
  (load-theme 'kaolin-aurora t)
  (kaolin-treemacs-theme))

;; Better Tabs
(use-package centaur-tabs
  :demand
  :custom
  (centaur-tabs-style "bar")
  (centaur-tabs-set-bar 'left)
  (centaur-tabs-set-modified-marker t)
  (centaur-tabs-modified-marker "●")
  :config
  (centaur-tabs-mode t)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward))

(use-package doom-modeline
  :ensure t
  :custom
  (doom-modeline-minor-modes t)
  :init (doom-modeline-mode 1))

(use-package minions
  :config (minions-mode 1))

(use-package ligature
  :straight (:host github
             :repo "mickeynp/ligature.el")
  :config
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Iosevka ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("-<<" "-<" "-<-" "<--" "<---" "<<-" "<-" "->" "->>" "-->" "--->" "->-" ">-" ">>-"
				       "=<<" "=<" "=<=" "<==" "<===" "<<=" "<=" "=>" "=>>" "==>" "===>" "=>=" ">=" ">>="
				       "<->" "<-->" "<--->" "<---->" "<=>" "<==>" "<===>" "<====>" "-------->"
				       "<~~" "<~" "~>" "~~>" "::" ":::" "==" "!=" "/=" "~=" "<>" "===" "!==" "=/=" "=!="
				       ":=" ":-" ":+" "<*" "<*>" "*>" "<|" "<|>" "|>" "<." "<.>" ".>" "+:" "-:" "=:" ":>"
				       "(*" "*)" "[|" "|]" "{|" "|}" "++" "+++" "\\/" "/\\" "|-" "-|" "<!--" "<!---" "<***>"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

;; Ivy completion framework

(use-package ivy
  :commands ivy-mode
  :bind (("C-x b" . ivy-switch-buffer)
         ("C-x C-b" . ivy-switch-buffer))
  :custom-face
  (ivy-org ((t (:inherit default))))
  :config
  (ivy-mode 1))

(use-package counsel
  :commands (counsel-M-x
             counsel-find-file
             counsel-file-jump
             counsel-recentf
             counsel-rg
             counsel-describe-function
             counsel-describe-variable
             counsel-find-library)
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-x f" . counsel-file-jump)
         ("C-x C-r" . counsel-recentf)
         ("C-x d" . counsel-dired)
         ("C-h f" . counsel-describe-function)
         ("C-h C-f" . counsel-describe-face)
         ("C-h v" . counsel-describe-variable)
         ("C-h l" . counsel-find-library))
  :config
  (when (executable-find "fd")
    (define-advice counsel-file-jump (:around (foo &optional initial-input initial-directory) aorst:counsel-fd)
      (let ((find-program "fd")
            (counsel-file-jump-args (split-string "-L --type f --hidden")))
        (funcall foo initial-input initial-directory))))
  (when (executable-find "rg")
    (setq counsel-rg-base-command
          "rg -S --no-heading --hidden --line-number --color never %s .")))

;; Completion
(use-package company
  :bind (:map company-active-map
         ("TAB" . company-complete-common-or-cycle)
         ("<tab>" . company-complete-common-or-cycle)
         ("<S-Tab>" . company-select-previous)
         ("<backtab>" . company-select-previous)
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous))
  :hook (after-init . global-company-mode)
  :custom
  (company-require-match 'never)
  (company-minimum-prefix-length 2)
  (company-tooltip-align-annotations t)
  (company-frontends '(company-pseudo-tooltip-unless-just-one-frontend
                       company-preview-frontend
                       company-echo-metadata-frontend))
  (company-backends '(company-capf company-files))
  (company-tooltip-minimum-width 30)
  (company-tooltip-maximum-width 60))

(use-package lsp-mode
    :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
            ((rust-mode c-mode c++-mode) . lsp))
            ;; if you want which-key integration
            ;;(lsp-mode . lsp-enable-which-key-integration))
    :custom
    (lsp-keymap-prefix "C-c l")
    (lsp-rust-server 'rust-analyzer)
    :commands lsp)
(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :config
  (lsp-ui-mode))
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)

(use-package dap-mode)

;;For prefix commands like C-c p or C-c h we want Emacs to visually guide you through the available options.
(use-package which-key
:ensure t
:init
(which-key-mode)
)

;; We can use quickrun package to execute code (if it has main)
(use-package quickrun
:ensure t
:bind ("C-c r" . quickrun))

;; Template system for Emacs. It allows you to type abbreviation and complete the associated text.
(use-package yasnippet :config (yas-global-mode))
(use-package yasnippet-snippets :ensure t)


(use-package highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-method 'character)
  (highlight-indent-guides-character ?│)
  (highlight-indent-guides-responsive 'top)
  (highlight-indent-guides-delay 0))

(use-package treemacs
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  (add-hook 'treemacs-mode-hook (lambda () (text-scale-decrease 1)))
  :config
  (progn
    (setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay      0.5
          treemacs-directory-name-transformer    #'identity
          treemacs-display-in-side-window        t
          treemacs-eldoc-display                 t
          treemacs-file-event-delay              5000
          treemacs-file-extension-regex          treemacs-last-period-regex-value
          treemacs-file-follow-delay             0.2
          treemacs-file-name-transformer         #'identity
          treemacs-follow-after-init             t
          treemacs-git-command-pipe              ""
          treemacs-goto-tag-strategy             'refetch-index
          treemacs-indentation                   2
          treemacs-indentation-string            " "
          treemacs-is-never-other-window         nil
          treemacs-max-git-entries               5000
          treemacs-missing-project-action        'ask
          treemacs-move-forward-on-expand        nil
          treemacs-no-png-images                 nil
          treemacs-no-delete-other-windows       t
          treemacs-project-follow-cleanup        nil
          treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                      'left
          treemacs-recenter-distance             0.1
          treemacs-recenter-after-file-follow    nil
          treemacs-recenter-after-tag-follow     nil
          treemacs-recenter-after-project-jump   'always
          treemacs-recenter-after-project-expand 'on-distance
          treemacs-show-cursor                   nil
          treemacs-show-hidden-files             t
          treemacs-silent-filewatch              nil
          treemacs-silent-refresh                nil
          treemacs-sorting                       'alphabetic-asc
          treemacs-space-between-root-nodes      t
          treemacs-tag-follow-cleanup            t
          treemacs-tag-follow-delay              1.5
          treemacs-user-mode-line-format         nil
          treemacs-user-header-line-format       nil
          treemacs-width                         25
          treemacs-workspace-switch-cleanup      nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    (treemacs-resize-icons 18)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))


(use-package rainbow-mode)

(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package lsp-java
  :ensure t
  :config (add-hook 'java-mode-hook 'lsp))

;; Just4Fun
(use-package 2048-game)
