;; the package dependencies


(require 'package)

(dolist (p '(("marmalade" . "http://marmalade-repo.org/packages/")
	     ("tromey" . "http://tromey.com/elpa/")
	     ("melpa" . "http://melpa.milkbox.net/packages/")))
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
                      load-theme-buffer-local))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)
    (message p)))
