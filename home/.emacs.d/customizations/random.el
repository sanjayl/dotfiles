(scroll-bar-mode -1)
(tool-bar-mode -1)
(show-paren-mode 1)
(blink-cursor-mode 0)
(setq-default indent-tabs-mode nil)
(ido-mode t)
(setq ido-enable-flex-matching t)
(ido-ubiquitous-mode 1)
(ido-vertical-mode)

(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

(load-theme 'tango-dark)

(require 'uniquify)

(setq uniquify-buffer-name-style 'forward
      backup-directory-alist `(("." . "~/.emacs.d/backups"))
      save-interprogram-paste-before-kill t
      apropos-do-all t)

(global-set-key (kbd "M-/") 'hippie-expand)

;; full path in title bar
(setq-default frame-title-format "%b (%f)")


(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

(global-set-key [C-return] 'delete-other-windows)
(global-set-key [C-tab] 'next-multiframe-window)
(global-set-key [C-S-iso-lefttab] 'previous-multiframe-window)

;; shift-arrowkey to move between windows
;(Terminal (define-key input-decode-map "\e[1;2A" [S-up]))
(windmove-default-keybindings)


(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %"
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

;(global-set-key "%" 'match-paren)  ;messes up with clj anon fns
(global-set-key "\C-\M-j" 'switch-to-buffer)
(global-set-key (kbd "C-.") 'hippie-expand)
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)
;; Shows a list of buffers
(global-set-key (kbd "C-x C-b") 'ibuffer)

(require 'recentf)
(setq recentf-max-saved-items 200
      recentf-max-menu-items 15)
(recentf-mode +1)


(defun recentf-ido-find-file ()
  "Find a recent file using ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))

(global-set-key (kbd "C-c f") 'recentf-ido-find-file)

(defun sudo-edit (&optional arg)
  "Edit currently visited file as root.

With a prefix ARG prompt for a file to visit.
Will also prompt for a file to visit if current
buffer is not visiting a file."
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))


;clj

(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

(require 'clojure-mode-extra-font-locking)
;; syntax hilighting for midje
(add-hook 'clojure-mode-hook
          (lambda ()
            (setq inferior-lisp-program "lein repl")
            (font-lock-add-keywords
             nil
             '(("(\\(facts?\\)"
                (1 font-lock-keyword-face))
               ("(\\(background?\\)"
                (1 font-lock-keyword-face))))
            (define-clojure-indent (fact 1))
            (define-clojure-indent (facts 1))))



(defun my-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen 'fullboth)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (menu-bar-mode -1))

(defun my-non-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'width 82)
  (set-frame-parameter nil 'fullscreen 'fullheight)
  (menu-bar-mode t))

(defun toggle-fullscreen ()
  (interactive)
  (if (eq (frame-parameter nil 'fullscreen) 'fullboth)  ;if in fullscreen mode
      (my-non-fullscreen)
    (my-fullscreen)))

(global-set-key (kbd "<f11>") 'toggle-fullscreen)

(global-set-key (kbd "C-|") 'align-cljlet)