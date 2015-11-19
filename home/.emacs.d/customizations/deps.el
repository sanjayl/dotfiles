;; the package dependencies


(require 'package)

(dolist (p '(("tromey" . "http://tromey.com/elpa/")
             ("melpa" . "http://melpa.org/packages/")))
  (add-to-list 'package-archives p t))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(browse-kill-ring
                      clojure-mode
		      clojure-mode-extra-font-locking
		      cider
                      paredit
		      ido-ubiquitous
                      ido-vertical-mode
                      smex
		      magit
                      load-theme-buffer-local
                      align-cljlet
                      multiple-cursors
                      highlight-symbol
                      undo-tree
                      guide-key
                      ace-jump-mode
                      expand-region
                      helm
                      clj-refactor))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)
    (message (prin1-to-string p))))
