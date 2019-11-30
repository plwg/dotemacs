;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-enabled-themes (quote (dracula)))
 '(custom-safe-themes
   (quote
    ("b46ee2c193e350d07529fcd50948ca54ad3b38446dcbd9b28d0378792db5c088" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(desktop-save-mode t)
 '(display-time-mode t)
 '(doc-view-resolution 200)
 '(fringe-mode 0 nil (fringe))
 '(global-display-line-numbers-mode nil)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (dracula-theme dr-racket-like-unicode org-noter pdf-tools auto-complete evil smart-mode-line magit)))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(find-file "~/Dropbox/org/*.org" t)
(find-file "~/.emacs.d/init.el")

;; IDO Mode

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; package

(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
;; magit

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch)

;;smart mode line
(setq sml/no-confirm-load-theme t)
(sml/setup)
(setq sml/theme 'respectful)

;; auto complete

(ac-config-default)

;; org Mode

(setq org-src-fontify-natively t)
(require 'org-tempo)
(setq org-directory "~/Dropbox/org")

;; evil

(require 'evil)
(evil-mode 1)
(eval-after-load 'evil-core
  '(evil-set-initial-state 'magit-popup-mode 'emacs))

;; pdf-tools

(pdf-tools-install)

;; truncate line
(set-default 'truncate-lines t)

;; org noter

(setq org-noter-always-create-frame nil)
(setq org-noter-default-notes-file-names '("marginalia.org")
      org-noter-notes-search-path '("~/Dropbox/org"))
