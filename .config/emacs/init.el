;; enable nativecomp
(setq comp-deferred-compilation t)
;; custom themes
(setq custom-theme-directory "~/.config/emacs/themes")

;; Disable some interface elements
(tool-bar-mode -1)
(toggle-scroll-bar -1)

;; Enable line number
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; Set default font
(set-face-attribute 'default nil
                    :family "Fantasque Sans Mono"
                    :height 120
                    :weight 'normal
                    :width 'normal)

;; General settings
(setq inhibit-startup-message t
inhibit-startup-echo-area-message t)
(setq-default cursor-type 'bar)
(show-paren-mode)
(define-key global-map (kbd "RET") 'newline-and-indent)

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

;; Packages config
(minimap-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(ayu-mirage))
 '(custom-safe-themes
   '("2c4761228167e036352f184660ddfbc3ecd2e84d26565839104d224bda557739" default))
 '(minimap-width-fraction 0.1)
 '(minimap-window-location 'right)
 '(package-selected-packages '(use-package quelpa)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(minimap-active-region-background ((t (:extend t :background "#2D2C61")))))
