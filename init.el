(setq gc-cons-threshold 100000000)
(setq use-package-compute-statistics t)
(package-initialize)
(setq package-enable-at-startup nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (org-drill all-the-icons kaolin-themes org-noter pdf-tools org-roam ledger-mode magit autothemer ghub ess org-bullets fcitx emojify feebleline use-package deft company ivy dr-racket-like-unicode evil))))

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-startup-message t         
      inhibit-startup-screen t          
      cursor-in-non-selected-windows t  
      echo-keystrokes 0.1              
      initial-scratch-message nil     
      sentence-end-double-space nil)
(fset 'display-startup-echo-area-message 'ignore)
(fset 'yes-or-no-p 'y-or-n-p) 
(blink-cursor-mode -1)
(setq scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)
(setq mouse-wheel-follow-mouse 't)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))     

;; theme

(set-face-attribute 'default nil :family "Iosevka")
(set-default 'truncate-lines t)

;; package
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
;(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

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

(global-set-key (kbd "C-;") #'other-window)
(global-set-key (kbd "M-c") (lambda()(interactive)(find-file "~/.emacs.d/init.el")))
(global-set-key (kbd "M-i") (lambda()(interactive)(find-file "~/Dropbox/org/inbox.org")))
(global-set-key (kbd "M-l") (lambda()(interactive)(find-file "~/Dropbox/ledger/my.ledger")))

(use-package org-roam
  :commands (org-roam org-roam-find-file org-roam-insert org-roam-graph-show)
  :bind ((("C-c n l" . org-roam)
	  ("C-c n f" . org-roam-find-file)
	  ("C-c n b" . org-roam-switch-to-buffer)
	  ("C-c n g" . org-roam-graph-show))
	 :map org-mode-map
	 (("C-c n i" . org-roam-insert)))
  :config
  (org-roam-mode)
  (setq org-roam-directory "/home/paul/Dropbox/org")
  (setq org-roam-graph-exclude-matcher '("inbox.org" "SLIPBOX.org" "Marginalia.org" "link.org" "Journal.org" "Buy.org" "Pinboard.org"))
  (setq org-roam-link-title-format "R:%s")
  (setq org-roam-graph-executable "/usr/bin/dot")
  (setq org-roam-graph-extra-config '(("overlap" . "false")))) 

(use-package ivy
  :hook
  (after-init . ivy-mode)
  :config
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-use-selectable-prompt t))

(use-package deft
  :commands (deft)
  :bind
  ("M-d" . deft)
  ("C-c n d" . deft)
  :config
  (setq deft-auto-save-interval 0.0)
  (setq deft-file-limit 30)
  (setq deft-recursive t)
  (setq deft-use-filter-string-for-filename t)
  (setq deft-default-extension "org")
  (setq deft-time-format " %Y-%m-%d    ")
  (setq deft-directory "/home/paul/Dropbox/org/"))

(use-package ledger-mode
  :defer t
  :config
  (setq ledger-report-auto-refresh nil)
  (setq ledger-schedule-file "~/Dropbox/ledger/recurring.ledger")
  (setq ledger-schedule-look-forward 30))

(use-package pdf-tools
  :defer t
  :config
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
  :config       (setq feebleline-msg-functions
		      '((feebleline-line-number         :post "" :fmt "")
			(feebleline-column-number       :pre "" :fmt "")
			(feebleline-file-directory      :face feebleline-dir-face :post "")
			(feebleline-file-or-buffer-name :face font-lock-keyword-face :post "")
			(feebleline-file-modified-star  :face font-lock-warning-face :post "")
			(feebleline-git-branch          :align right :face font-lock-warning-face :pre "" :post "")
			(feebleline-project-name        :align right :fmt "")))
  (feebleline-mode 1))

(use-package company
  :defer 5
  :config
  (global-company-mode 1))

(use-package markdown-mode
  :defer t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc"))

(use-package fcitx
  :defer 2
  :config
  (fcitx-prefix-keys-turn-on)
  (fcitx-prefix-keys-add "C-x" "C-c" "C-h" "M-s" "M-o")
  (fcitx-aggressive-setup))

(use-package display-line-numbers-mode
  :hook prog-mode)

(use-package ess :defer t)

(use-package org-drill
  :commands (org-drill)
  :config
  (setq org-drill-hide-item-headings-p t)
  (setq org-drill-add-random-noise-to-intervals-p t)
  )

(use-package org
  :defer t
  :bind (("C-c l" . org-store-link)
	 ("C-c a" . org-agenda)
	 ("C-c c" . org-capture))
  :config
  (define-key org-mode-map (kbd "C-SPC") (lambda () (interactive) (org-tree-to-indirect-buffer) (other-window 1) (delete-other-windows)))
					;(require 'org-bullets)
  (add-hook 'org-mode-hook 'turn-on-auto-fill)
  (setq org-capture-templates '(("p" "pa code" entry
				 (file "~/Dropbox/org/pa-note.org")
				 "* Code Snippet :drill:\n%^{Question}\n** Code\n#+BEGIN_SRC\n\n#+END_SRC")
				("c" "pa concept" entry
				 (file "~/Dropbox/org/pa-note.org")
				 "* Concept :drill:\n%^{Concept}\n** Definition\n%^{Definition}")))
  (setq org-refile-targets '((nil :maxlevel . 9) (org-agenda-files :maxlevel . 9)))
  (setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
  (setq org-refile-use-outline-path t)                  ; Show full paths for refiling
  (setq org-export-backends (quote (ascii html latex md)))
  (require 'org-id)
  (setq org-id-link-to-org-use-id t)
  (setq org-src-fontify-natively t)
  (setq org-directory "~/Dropbox/org")
  (require 'org-bullets)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package org-noter
  :after pdf-tools
  :commands (org-noter)
  :config
  (setq org-noter-always-create-frame nil)
  (setq org-noter-default-notes-file-names '("marginalia.org")
	org-noter-notes-search-path '("~/Dropbox/org")))

(use-package magit
  :commands (magit-status magit-dispatch)
  :bind
  ("C-x g" . magit-status)
  ("C-x M-g" . magit-dispatch))

(use-package show-paren-mode
  :defer 2
  :config
  (setq show-paren-delay 0))

(use-package kaolin-themes
  :config
  (load-theme 'kaolin-dark t)
  (kaolin-treemacs-theme))

(defun my-load-user-init-file-after-save ()
  (when (string= (file-truename user-init-file) (file-truename (buffer-file-name)))
    (let ((debug-on-error t)) (load (buffer-file-name)))))
(add-hook 'after-save-hook #'my-load-user-init-file-after-save)

(setq gc-cons-threshold  800000)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
