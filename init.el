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
 '(global-display-line-numbers-mode t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(package-selected-packages (quote (auto-complete evil smart-mode-line magit)))
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

;; MELPA

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

;; magit

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch)

;;smart mode line
(setq sml/no-confirm-load-theme t)
(sml/setup)
(setq sml/theme 'respectful)

;; auto complete

(ac-config-default)

;; doc-view

(with-eval-after-load "doc-view"
  (easy-menu-define my-doc-view-menu doc-view-mode-map "Menu for Doc-View Mode."
    '("DocView"
      ["Switch to a different mode" doc-view-toggle-display :help "Switch to a different mode"]
      ["Open Text" doc-view-open-text :help "Display the current doc's contents as text"]
      "--"
      ("Navigate Doc"
       ["Goto Page ..." doc-view-goto-page :help "View the page given by PAGE"]
       "--"
       ["Scroll Down" doc-view-scroll-down-or-previous-page :help "Scroll page down ARG lines if possible, else goto previous page"]
       ["Scroll Up" doc-view-scroll-up-or-next-page :help "Scroll page up ARG lines if possible, else goto next page"]
       "--"
       ["Next Line" doc-view-next-line-or-next-page :help "Scroll upward by ARG lines if possible, else goto next page"]
       ["Previous Line" doc-view-previous-line-or-previous-page :help "Scroll downward by ARG lines if possible, else goto previous page"]
       ("Customize"
        ["Continuous Off"
         (setq doc-view-continuous nil)
         :help "Stay put in the current page, when moving past first/last line" :style radio :selected
         (eq doc-view-continuous nil)]
        ["Continuous On"
         (setq doc-view-continuous t)
         :help "Goto to the previous/next page, when moving past first/last line" :style radio :selected
         (eq doc-view-continuous t)]
        "---"
        ["Save as Default"
         (customize-save-variable 'doc-view-continuous doc-view-continuous)
         t])
       "--"
       ["Next Page" doc-view-next-page :help "Browse ARG pages forward"]
       ["Previous Page" doc-view-previous-page :help "Browse ARG pages backward"]
       "--"
       ["First Page" doc-view-first-page :help "View the first page"]
       ["Last Page" doc-view-last-page :help "View the last page"])
      "--"
      ("Adjust Display"
       ["Enlarge" doc-view-enlarge :help "Enlarge the document by FACTOR"]
       ["Shrink" doc-view-shrink :help "Shrink the document"]
       "--"
       ["Fit Width To Window" doc-view-fit-width-to-window :help "Fit the image width to the window width"]
       ["Fit Height To Window" doc-view-fit-height-to-window :help "Fit the image height to the window height"]
       "--"
       ["Fit Page To Window" doc-view-fit-page-to-window :help "Fit the image to the window"]
       "--"
       ["Set Slice From Bounding Box" doc-view-set-slice-from-bounding-box :help "Set the slice from the document's BoundingBox information"]
       ["Set Slice Using Mouse" doc-view-set-slice-using-mouse :help "Set the slice of the images that should be displayed"]
       ["Set Slice" doc-view-set-slice :help "Set the slice of the images that should be displayed"]
       ["Reset Slice" doc-view-reset-slice :help "Reset the current slice"])
      ("Search"
       ["New Search ..."
        (doc-view-search t)
        :help "Jump to the next match or initiate a new search if NEW-QUERY is given"]
       "--"
       ["Search" doc-view-search :help "Jump to the next match or initiate a new search if NEW-QUERY is given"]
       ["Backward" doc-view-search-backward :help "Call `doc-view-search' for backward search"]
       "--"
       ["Show Tooltip" doc-view-show-tooltip :help nil])
      ("Maintain"
       ["Reconvert Doc" doc-view-reconvert-doc :help "Reconvert the current document"]
       "--"
       ["Clear Cache" doc-view-clear-cache :help "Delete the whole cache (`doc-view-cache-directory')"]
       ["Dired Cache" doc-view-dired-cache :help "Open `dired' in `doc-view-cache-directory'"]
       "--"
       ["Revert Buffer" doc-view-revert-buffer :help "Like `revert-buffer', but preserves the buffer's current modes"]
       "--"
       ["Kill Proc" doc-view-kill-proc :help "Kill the current converter process(es)"]
       ["Kill Proc And Buffer" doc-view-kill-proc-and-buffer :help "Kill the current buffer"])
      "--"
      ["Customize"
       (customize-group 'doc-view)]))
  (easy-menu-define my-doc-view-minor-mode-menu doc-view-minor-mode-map "Menu for Doc-View Minor Mode."
    '("DocView*"
      ["Display in DocView Mode" doc-view-toggle-display :help "View"]
      ["Exit DocView Mode" doc-view-minor-mode])))

;; org Mode

(setq org-src-fontify-natively t)

;; evil

(require 'evil)
(evil-mode 1)
(eval-after-load 'evil-core
  '(evil-set-initial-state 'magit-popup-mode 'emacs))
