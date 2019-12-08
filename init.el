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
 '(custom-enabled-themes (quote (kaolin-temple)))
 '(custom-safe-themes
   (quote
    ("53993d7dc1db7619da530eb121aaae11c57eaf2a2d6476df4652e6f0bd1df740" "addfaf4c6f76ef957189d86b1515e9cf9fcd603ab6da795b82b79830eed0b284" "a70b47c87e9b0940f6fece46656200acbfbc55e129f03178de8f50934ac89f58" "f0a76ae259b7be77e59f98501957eb45a10af0839dd9eb29fdd5691ed74771d4" "ea44def1fa1b169161512d79a65f54385497a6a5fbc96d59c218f852ce35b2ab" "83ec4c87dac3a99036129a674ec2ef50468b3a854098e994e9b6a226ab63510b" "b46ee2c193e350d07529fcd50948ca54ad3b38446dcbd9b28d0378792db5c088" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(desktop-save-mode t)
 '(display-time-mode t)
 '(doc-view-resolution 200)
 '(fci-rule-color "#383838")
 '(font-use-system-font t)
 '(fringe-mode (quote (nil . 0)) nil (fringe))
 '(global-display-line-numbers-mode nil)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(org-export-backends (quote (ascii html latex md)))
 '(package-selected-packages
   (quote
    (cyberpunk-theme kaolin-themes visual-fill-column nov dracula-theme dr-racket-like-unicode org-noter pdf-tools auto-complete evil smart-mode-line magit)))
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

;; evil

(require 'evil)
(evil-mode 1)
(eval-after-load 'evil-core '(evil-set-initial-state 'magit-popup-mode 'emacs))
(evil-set-initial-state 'eshell-mode 'emacs)

;; pdf-tools

(pdf-tools-install)

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
