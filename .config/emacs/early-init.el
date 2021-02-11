;;; early-init.el --- early configurations

;; gccemacs enable native compilation
(defvar comp-deferred-compilation)
(setq comp-deferred-compilation t)
(setq warning-minimum-level :emergency)

;; reduce the frequency of garbage collection
;; GC each 64MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 64000000)

;; how many bytes can be read from a sub-process in one read operation.
;; emacs default 4k is too low for language servers
(setq read-process-output-max (* 1024 1024 4)) ;; 4mb

;; Avoid blank white screen.
(when (display-graphic-p)
  (set-face-background 'default "#000000" nil)
  (set-face-foreground 'default "#FFFFFF" nil))

(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Startup directly into a scratch buffer
(setq inhibit-startup-message t
     inhibit-startup-echo-area-message t)

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
(provide 'early-init)
