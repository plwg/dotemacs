(package-initialize)

(custom-set-variables
 '(ansi-color-names-vector ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(desktop-save-mode t)
 '(fci-rule-color "#dedede")
 '(org-export-backends (quote (ascii html latex md)))
 '(package-selected-packages
   (quote
    (kaolin-themes visual-fill-column nov dr-racket-like-unicode org-noter pdf-tools auto-complete evil smart-mode-line magit))))
(custom-set-faces '(default ((t (:family "Ubuntu Mono" :foundry "DAMA" :slant normal :weight normal :height 120 :width normal)))))
(find-file "~/Dropbox/org/*.org" t)
(find-file "~/.emacs.d/init.el")

;; misc

(blink-cursor-mode 0)
(setq
 inhibit-startup-message t         
 inhibit-startup-screen t          
 cursor-in-non-selected-windows t  
 echo-keystrokes 0.1              
 initial-scratch-message nil     
 sentence-end-double-space nil  
 confirm-kill-emacs 'y-or-n-p  
 display-time-default-load-average nil
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

(display-time-mode 1)
(global-display-line-numbers-mode 1)

;; theme

(load-theme 'kaolin-temple t)

;; IDO Mode

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; package

(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
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
(add-hook 'org-mode-hook 'turn-on-auto-fill)

;; evil

(require 'evil)
(evil-mode 1)
(evil-set-initial-state 'magit-popup-mode 'emacs)
(evil-set-initial-state 'calculator-mode 'emacs)
(evil-set-initial-state 'eshell-mode 'emacs)
(evil-set-initial-state 'org-agenda-mode 'emacs)

;; pdf-tools

(pdf-tools-install)
(add-hook 'pdf-view-mode-hook (lambda (&optional dummy) (display-line-numbers-mode -1)))

;; truncate line

(set-default 'truncate-lines t)

;; org noter

(setq org-noter-always-create-frame nil)
(setq org-noter-default-notes-file-names '("marginalia.org")
      org-noter-notes-search-path '("~/Dropbox/org"))

;; nov.el

(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
(defun my-nov-font-setup () (face-remap-add-relative 'variable-pitch :family "Liberation Serif" :height 1.5))
(add-hook 'nov-mode-hook 'my-nov-font-setup)
(evil-set-initial-state 'nov-mode 'emacs)

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

(setq org-publish-project-alist
      '(
	("org-publish-post"
	 :base-directory "~/Dropbox/org/blog/_posts/"
	 :base-extension "org"
	 :publishing-directory "~/blog/plwg.github.io/_posts/"
	 :recursive t
	 :publishing-function org-md-publish-to-md
	 :headline-levels 4
	 :body-only t 
	 )

	("org-publish-attachment"
	 :base-directory "~/Dropbox/org/blog/assets"
	 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php\\|jpeg"
	 :publishing-directory "~/blog/plwg.github.io/assets/"
	 :recursive t
	 :publishing-function org-publish-attachment)

	("blog" :components ("org-publish-post" "org-publish-attachment"))
	))

(tempo-define-template "highlight"
           '("#+begin_export html" n 
             "``` " p n
             "```" n
             "#+end_export")
           "<hl"
           'org-tempo-tags)

(defun org-jekyll-post-link-follow (path)
  (org-open-file-with-emacs path))

(defun org-jekyll-post-link-export (path desc format)
  (cond
   ((eq format 'html)
    (format "<a href=\"{%% post_url %s %%}\">%s</a>" path desc))))

(org-add-link-type "jekyll-post" 'org-jekyll-post-link-follow 'org-jekyll-post-link-export)

(setq jekyll-directory "/home/paul/Dropbox/org/blog/")
(setq jekyll-drafts-dir "_drafts/")
(setq jekyll-posts-dir "_posts/")
(setq jekyll-post-ext ".org")
(setq jekyll-post-template "#+OPTIONS: toc:nil num:nil\nBEGIN_EXPORT html\n---\nlayout: post\ntitle: %s\nexcerpt: \ncategories:\n  -  \ntags:\n  -  \n---\n#+END_EXPORT\n\n* ")

(defun jekyll-make-slug (s)
  (replace-regexp-in-string
   " " "-" (downcase
            (replace-regexp-in-string
             "[^A-Za-z0-9 ]" "" s))))

(defun jekyll-yaml-escape (s)
  (if (or (string-match ":" s)
          (string-match "\"" s))
      (concat "\"" (replace-regexp-in-string "\"" "\\\\\"" s) "\"")
    s))

(defun jekyll-draft-post (title)
  (interactive "sPost Title: ")
  (let ((draft-file (concat jekyll-directory jekyll-drafts-dir
                            (jekyll-make-slug title)
                            jekyll-post-ext)))
    (if (file-exists-p draft-file)
        (find-file draft-file)
      (find-file draft-file)
      (auto-fill-mode 1)
      (insert (format jekyll-post-template (jekyll-yaml-escape title))))))

(defun jekyll-publish-post ()
  (interactive)
  (cond
   ((not (equal
          (file-name-directory (buffer-file-name (current-buffer)))
          (concat jekyll-directory jekyll-drafts-dir)))
    (message "This is not a draft post."))
   ((buffer-modified-p)
    (message "Can't publish post; buffer has modifications."))
   (t
    (let ((filename
           (concat jekyll-directory jekyll-posts-dir
                   (format-time-string "%Y-%m-%d-")
                   (file-name-nondirectory
                    (buffer-file-name (current-buffer)))))
          (old-point (point)))
      (rename-file (buffer-file-name (current-buffer))
                   filename)
      (kill-buffer nil)
      (find-file filename)
      (set-window-point (selected-window) old-point)))))
