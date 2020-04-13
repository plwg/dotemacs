(setq gc-cons-threshold 100000000)
(package-initialize)
(setq package-enable-at-startup nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(blink-cursor-mode nil)
 '(custom-safe-themes
   (quote
    ("c19e5291471680e72d8bd98f8d6e84f781754a9e8fc089536cda3f0b7c3550e3" "6973f93f55e4a6ef99aa34e10cd476bc59e2f0c192b46ec00032fe5771afd9ad" default)))
 '(deft-default-extension "org" t)
 '(deft-directory "/home/paul/Dropbox/org/")
 '(deft-file-limit 30)
 '(deft-recursive t)
 '(deft-time-format " %Y-%m-%d    ")
 '(deft-use-filter-string-for-filename t)
 '(fci-rule-color "#dedede")
 '(fcitx-aggressive-setup nil t)
 '(fcitx-prefix-keys-add "C-x" t)
 '(fcitx-prefix-keys-turn-on nil t)
 '(ivy-use-selectable-prompt t)
 '(ledger-report-auto-refresh nil)
 '(ledger-schedule-file "~/Dropbox/ledger/recurring.ledger")
 '(ledger-schedule-look-forward 30)
 '(line-spacing 0.2)
 '(org-export-backends (quote (ascii html latex md)))
 '(org-roam-directory "/home/paul/Dropbox/org")
 '(org-roam-graph-exclude-matcher
   (quote
    ("inbox.org" "Note.org" "SLIPBOX.org" "Marginalia.org" "link.org" "Journal.org" "Buy.org" "Pinboard.org")))
 '(org-roam-graph-executable "/usr/bin/dot")
 '(org-roam-graph-extra-config (quote (("overlap" . "false"))))
 '(org-roam-link-title-format "R:%s")
 '(package-selected-packages
   (quote
    (org-bullets poet-theme fcitx emojify markdown-mode feebleline use-package deft company ivy org-roam ledger-mode kaolin-themes visual-fill-column dr-racket-like-unicode org-noter pdf-tools evil magit)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :foundry "DAMA" :slant normal :weight normal :height 130 :width normal)))))
;(find-file "~/Dropbox/ledger/my.ledger")
;(find-file "~/.emacs.d/init.el")
(deft)
;; misc

(setq
 inhibit-startup-message t         
 inhibit-startup-screen t          
 cursor-in-non-selected-windows t  
 echo-keystrokes 0.1              
 initial-scratch-message nil     
 sentence-end-double-space nil  
 )

(fset 'yes-or-no-p 'y-or-n-p) 
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(setq scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)
(setq mouse-wheel-follow-mouse 't)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))     

(setq show-paren-delay 0)
(show-paren-mode 1)


;; theme

(load-theme 'poet-dark t)

;; package

(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

;; magit

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch)

;; org Mode

(setq org-src-fontify-natively t)
(require 'org-tempo)
(setq org-directory "~/Dropbox/org")
(add-hook 'org-mode-hook 'turn-on-auto-fill)

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

;; truncate line

(set-default 'truncate-lines t)

;; org noter

(setq org-noter-always-create-frame nil)
(setq org-noter-default-notes-file-names '("marginalia.org")
      org-noter-notes-search-path '("~/Dropbox/org"))

;; back up file setting 

(defvar --backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p --backup-directory))
    (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      delete-old-versions t             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 20              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 200            ; number of keystrokes between auto-saves (default: 300)
      )

;; blogging

;(setq org-publish-project-alist
      ;'(
	;("org-publish-post"
	 ;:base-directory "~/Dropbox/org/blog/_posts/"
	 ;:base-extension "org"
	 ;:publishing-directory "~/blog/plwg.github.io/_posts/"
	 ;:recursive t
	 ;:publishing-function org-md-publish-to-md
	 ;:headline-levels 4
	 ;:body-only t 
	 ;)

	;("org-publish-attachment"
	 ;:base-directory "~/Dropbox/org/blog/assets"
	 ;:base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php\\|jpeg"
	 ;:publishing-directory "~/blog/plwg.github.io/assets/"
	 ;:recursive t
	 ;:publishing-function org-publish-attachment)

	;("blog" :components ("org-publish-post" "org-publish-attachment"))
	;))

;(tempo-define-template "highlight"
		       ;'("#+begin_export html" n 
			 ;"``` " p n
			 ;"```" n
			 ;"#+end_export")
		       ;"<hl"
		       ;'org-tempo-tags)

;(defun org-jekyll-post-link-follow (path)
  ;(org-open-file-with-emacs path))

;(defun org-jekyll-post-link-export (path desc format)
  ;(cond
   ;((eq format 'html)
    ;(format "<a href=\"{%% post_url %s %%}\">%s</a>" path desc))))

;(org-add-link-type "jekyll-post" 'org-jekyll-post-link-follow 'org-jekyll-post-link-export)

;(setq jekyll-directory "/home/paul/Dropbox/org/blog/")
;(setq jekyll-drafts-dir "_drafts/")
;(setq jekyll-posts-dir "_posts/")
;(setq jekyll-post-ext ".org")
;(setq jekyll-post-template "#+OPTIONS: toc:nil num:nil\nBEGIN_EXPORT html\n---\nlayout: post\ntitle: %s\nexcerpt: \ncategories:\n  -  \ntags:\n  -  \n---\n#+END_EXPORT\n\n* ")

;(defun jekyll-make-slug (s)
  ;(replace-regexp-in-string
   ;" " "-" (downcase
	    ;(replace-regexp-in-string
	     ;"[^A-Za-z0-9 ]" "" s))))

;(defun jekyll-yaml-escape (s)
  ;(if (or (string-match ":" s)
	  ;(string-match "\"" s))
      ;(concat "\"" (replace-regexp-in-string "\"" "\\\\\"" s) "\"")
    ;s))

;(defun jekyll-draft-post (title)
  ;(interactive "sPost Title: ")
  ;(let ((draft-file (concat jekyll-directory jekyll-drafts-dir
			    ;(jekyll-make-slug title)
			    ;jekyll-post-ext)))
    ;(if (file-exists-p draft-file)
	;(find-file draft-file)
      ;(find-file draft-file)
      ;(auto-fill-mode 1)
      ;(insert (format jekyll-post-template (jekyll-yaml-escape title))))))

;(defun jekyll-publish-post ()
  ;(interactive)
  ;(cond
   ;((not (equal
	  ;(file-name-directory (buffer-file-name (current-buffer)))
	  ;(concat jekyll-directory jekyll-drafts-dir)))
    ;(message "This is not a draft post."))
   ;((buffer-modified-p)
    ;(message "Can't publish post; buffer has modifications."))
   ;(t
    ;(let ((filename
	   ;(concat jekyll-directory jekyll-posts-dir
		   ;(format-time-string "%Y-%m-%d-")
		   ;(file-name-nondirectory
		    ;(buffer-file-name (current-buffer)))))
	  ;(old-point (point)))
      ;(rename-file (buffer-file-name (current-buffer))
		   ;filename)
      ;(kill-buffer nil)
      ;(find-file filename)
      ;(set-window-point (selected-window) old-point)))))

;; auto load setting

(defun my-load-user-init-file-after-save ()
  (when (string= (file-truename user-init-file) (file-truename (buffer-file-name)))
    (let ((debug-on-error t)) (load (buffer-file-name)))))

(add-hook 'after-save-hook #'my-load-user-init-file-after-save)

;; org mode;; Use global IDs

(require 'org-id)
(setq org-id-link-to-org-use-id t)

;; bind key to open indrect buffer

(define-key org-mode-map (kbd "C-SPC") (lambda () (interactive) (org-tree-to-indirect-buffer) (other-window 1) (delete-other-windows)))

;; bind key switch betweek window

(global-set-key (kbd "C-'") #'other-window)

;; org-roam

(use-package org-roam
      :hook 
      (after-init . org-roam-mode)
      :custom
      (org-roam-directory "/home/paul/Dropbox/org")
      (org-roam-graph-exclude-matcher '("inbox.org" "SLIPBOX.org" "Marginalia.org" "link.org" "Journal.org" "Buy.org" "Pinboard.org"))
      (org-roam-link-title-format "R:%s")
      (org-roam-graph-executable "/usr/bin/dot")
      (org-roam-graph-extra-config '(("overlap" . "false")))
      :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n b" . org-roam-switch-to-buffer)
               ("C-c n g" . org-roam-graph-show))
              :map org-mode-map
              (("C-c n i" . org-roam-insert)))) 
;; ivy

(use-package ivy
  :hook
  (after-init . ivy-mode)
  :custom
  (ivy-use-selectable-prompt t))

(use-package deft
  :after org
  :bind
  ("C-c n d" . deft)
  :custom
  (deft-auto-save-interval 0.0)
  (deft-file-limit 30)
  (deft-recursive t)
  (deft-use-filter-string-for-filename t)
  (deft-default-extension "org")
  (deft-time-format " %Y-%m-%d    ")
  (deft-directory "/home/paul/Dropbox/org/"))

(use-package ledger-mode
  :bind
  :custom
  (ledger-report-auto-refresh nil)
  (ledger-schedule-file "~/Dropbox/ledger/recurring.ledger")
  (ledger-schedule-look-forward 30))

(use-package pdf-tools
  :init
  (pdf-tools-install)
  (add-hook 'pdf-view-mode-hook (lambda (&optional dummy) (display-line-numbers-mode -1))))

(use-package evil
  :hook 
  (after-init . evil-mode)
  :config
  (evil-set-initial-state 'magit-popup-mode 'emacs)
  (evil-set-initial-state 'calculator-mode 'emacs)
  (evil-set-initial-state 'eshell-mode 'emacs)
  (evil-set-initial-state 'org-agenda-mode 'emacs)
  (evil-set-initial-state 'calendar-mode 'emacs)
  (evil-set-initial-state 'deft-mode 'emacs))

(use-package    feebleline
  :ensure       t
  :config       (setq feebleline-msg-functions
		      '((feebleline-line-number         :post "" :fmt "")
			(feebleline-column-number       :pre "" :fmt "")
			(feebleline-file-directory      :face feebleline-dir-face :post "")
			(feebleline-file-or-buffer-name :face font-lock-keyword-face :post "")
			(feebleline-file-modified-star  :face font-lock-warning-face :post "")
			(feebleline-git-branch          :align right :face evil-ex-lazy-highlight :pre "" :post "")
			(feebleline-project-name        :align right :fmt "")))
  (feebleline-mode 1))

(use-package company
  :ensure t
  :config
  (global-company-mode 1))

(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc"))

(add-hook 'org-mode-hook
	  (lambda ()
	    (variable-pitch-mode 1)))

(set-face-attribute 'default nil :family "Iosevka")
(set-face-attribute 'fixed-pitch nil :family "Iosevka")
(set-face-attribute 'variable-pitch nil :family "Libre Baskerville" :height 130)

(fcitx-prefix-keys-turn-on)
(fcitx-prefix-keys-add "C-x" "C-c" "C-h" "M-s" "M-o")
(fcitx-aggressive-setup)

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(add-hook 'prog-mode-hook #'display-line-numbers-mode)
