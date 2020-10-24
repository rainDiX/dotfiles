;; enable nativecomp
(setq comp-deferred-compilation t)

;; Disable some interface elements
(tool-bar-mode -1)
(toggle-scroll-bar -1)

;; Enable line number on prog mode
(add-hook 'prog-mode-hook 'display-line-numbers-mode)


;(setq display-line-numbers-type 'relative)

;; Set default font
(set-face-attribute 'default nil
                    :family "Fantasque Sans Mono"
                    :height 130
                    :weight 'normal
                    :width 'normal)

;; General settings
(setq inhibit-startup-message t
inhibit-startup-echo-area-message t)
(setq-default cursor-type 'bar)
(show-paren-mode)
(define-key global-map (kbd "RET") 'newline-and-indent)

;; make the delete key behave like a a forward looking version of backspace
(global-set-key [delete] 'delete-char)
(global-set-key [M-delete] 'kill-word)

;; enable package management
(require 'package)

;; bootstrap the quelpa package manager
(unless (package-installed-p 'quelpa)
    (with-temp-buffer
        (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
        (eval-buffer)
        (quelpa-self-upgrade)))


;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
        (package-refresh-contents)
        (quelpa 'use-package))

;; Packages

(unless (package-installed-p 'minimap)
        (quelpa '(minimap :repo "dengste/minimap" :fetcher github )))

(unless (package-installed-p 'all-the-icons)
        (quelpa 'all-the-icons))

(unless (package-installed-p 'rainbow-mode)
        (quelpa '(rainbow-mode :fetcher url
                               :url "http://git.savannah.gnu.org/cgit/emacs/elpa.git/plain/packages/rainbow-mode/rainbow-mode.el")))

(unless (package-installed-p 'base16-theme)
  (quelpa 'base16-theme))


(unless (package-installed-p 'markdown-mode)
  (quelpa 'markdown-mode))

(unless (package-installed-p 'highlight-indent-guides)
  (quelpa 'highlight-indent-guides))

(unless (package-installed-p 'magit)
  (quelpa 'magit))

(unless (package-installed-p 'projectile)
  (quelpa 'projectile))

(unless (package-installed-p 'treemacs)
  (quelpa 'treemacs)
  (quelpa 'treemacs-projectile)
  (quelpa 'treemacs-icons-dired)
  (quelpa 'treemacs-magit))

(unless (package-installed-p 'lsp-mode)
  (quelpa 'lsp-mode))

;; Packages config
(minimap-mode 1)

(use-package rainbow-mode)

(use-package minimap
  :defer t
  :config
  (setq minimap-window-location 'right
        minimap-update-delay 0
        minimap-width-fraction 0.09
        minimap-minimum-width 15
	minimap-highlight-line nil)
  (custom-set-faces
   '(minimap-active-region-background ((t (:extend t :background "#44475A"))))))

(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package highlight-indent-guides-mode
  :hook prog-mode
  :init
  (setq highlight-indent-guides-method 'character))


(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
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
          treemacs-width                         35
          treemacs-workspace-switch-cleanup      nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

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

;;(use-package treemacs-projectile
;;  :after treemacs projectile
;;  :ensure t)

;;(use-package treemacs-icons-dired
;;  :after treemacs dired
;;  :ensure t
;;  :config (treemacs-icons-dired-mode))

;;(use-package treemacs-magit
;;  :after treemacs magit
;;  :ensure t)

;;(use-package treemacs-persp ;;treemacs-persective if you use perspective.el vs. persp-mode
;;  :after treemacs persp-mode ;;or perspective vs. persp-mode
;;  :ensure t
;;  :config (treemacs-set-scope-type 'Perspectives))

;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
(setq lsp-keymap-prefix "s-l")

(use-package lsp-mode
    :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
           (c-mode . lsp)
	   (c++-mode . lsp)
            ;; if you want which-key integration
            (lsp-mode . lsp-enable-which-key-integration))
    :commands lsp)

;; config set by GUI
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(base16-material-darker))
 '(custom-safe-themes
   '("196df8815910c1a3422b5f7c1f45a72edfa851f6a1d672b7b727d9551bb7c7ba" "24714e2cb4a9d6ec1335de295966906474fdb668429549416ed8636196cb1441" default))
 '(package-selected-packages
   '(magit use-package treemacs-projectile treemacs-magit treemacs-icons-dired rainbow-mode quelpa minimap lsp-mode highlight-indent-guides dracula-theme all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(minimap-active-region-background ((t (:extend t :background "#44475A")))))
