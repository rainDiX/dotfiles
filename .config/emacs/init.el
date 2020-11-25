;; enable nativecomp (gccemacs)
;(setq comp-deferred-compilation t)

;; Disable some interface elements
(tool-bar-mode -1)
(toggle-scroll-bar -1)

;; Enable line number on prog mode
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(setq display-line-numbers-grow-only t)
(setq display-line-numbers-width-start t)

(setq visible-bell t)

;; reduce the frequency of garbage collection
;; GC each 64MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 64000000)

;; Default font
(set-face-attribute 'default nil :font "Fantasque Sans Mono 12")
;; Startup directly into a scratch buffer
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)

(setq-default cursor-type 'bar)
(show-paren-mode)
(define-key global-map (kbd "RET") 'newline-and-indent)
;; Prefer UTF8
(prefer-coding-system 'utf-8)
(when (display-graphic-p)
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))

;; make the delete key behave like a a forward looking version of backspace
(global-set-key [delete] 'delete-char)
(global-set-key [M-delete] 'kill-word)

;; Bootstrap code for straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; install use-package with straight
(straight-use-package 'use-package)
(defvar straight-use-package-by-default)
(setq straight-use-package-by-default t)

;; disable package.el
(setq package-enable-at-startup nil)

;; use use-package to install, load & configure packages
(require 'use-package)
(setq straight-use-package-by-default t)

;; Packages
(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t)
  (load-theme 'doom-molokai t)

  (doom-themes-visual-bell-config)
  )

;; A minimap like every other modern editors
(use-package minimap
  :config
  (setq minimap-window-location 'right
        minimap-update-delay 0
        minimap-width-fraction 0.09
        minimap-minimum-width 15
	minimap-highlight-line nil)
  :hook (prog-mode . minimap-mode))

(use-package ligature
  :straight (:host github
             :repo "mickeynp/ligature.el")
  :config
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Fantasque ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("<<" ">>" "&&" "||" "//" "/*" "*/" "/**/" "|||>" "||>" "|>"
				       "==" "===" "==>" "=>" "=>>" "=<<" "=/=" "!=" "!==" ">=" ">=>"
                                       ">>=" ">>-" ">-" ">->" "->" "->>" "-->" "-<" "-<<" "<|" "<||"
                                       "<|||" "<|>" "<=" "<==" "<=>" "<=<" "<!--" "<>" "<-" "<->"
				       "<--" "<-<" "<<=" "<<-" "<~" "<~>" "<~~" "~>" "~~" "~~>"))
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

(use-package highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-method 'character)
  (highlight-indent-guides-character ?▏)
  (highlight-indent-guides-responsive 'top)
  (highlight-indent-guides-delay 0))


(use-package rainbow-mode)

(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(dooms-themes markdown-mode minimap rainbow-mode use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
