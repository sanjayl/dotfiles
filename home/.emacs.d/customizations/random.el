(scroll-bar-mode -1)
(tool-bar-mode -1)
(show-paren-mode 1)
(blink-cursor-mode 0)
(setq-default indent-tabs-mode nil)
(ido-mode t)
(setq ido-enable-flex-matching t)
(ido-ubiquitous-mode 1)
(ido-vertical-mode)
(setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)
(global-undo-tree-mode)

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
;;(global-set-key (kbd "C-.") 'hippie-expand)
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


(require 'highlight-symbol)
(global-set-key [(control f5)] 'highlight-symbol-next)
(global-set-key [f5] 'highlight-symbol)
(global-set-key [(shift f5)] 'highlight-symbol-prev)
(global-set-key [(meta f5)] 'highlight-symbol-query-replace)

(setq magit-last-seen-setup-instructions "1.4.0")

(setq guide-key/guide-key-sequence '("C-x" "C-c"))
(setq guide-key/recursive-key-sequence-flag t)
(setq guide-key/popup-window-position 'bottom)
(guide-key-mode 1)

(global-set-key (kbd "C-,") 'ace-jump-mode)
(global-set-key (kbd "C-<") 'ace-jump-char-mode)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)


;;helm?
(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
;;      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c m") 'helm-mini)

(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)

;; turn off helm find file and go back to ido (I missed having the tab-key
;(global-set-key (kbd "C-x C-f") 'helm-find-files)

(helm-mode 1)

(setq mouse-yank-at-point t)
(setq magit-push-always-verify nil)
(global-set-key (kbd "C-c C-g") 'magit-status)


(defun ido-my-keys ()
  "changed what C-l does in the find file dialog, used to be refresh directory, now is cd .."
  (define-key ido-file-dir-completion-map "\C-l" 'ido-up-directory))

(add-hook 'ido-setup-hook 'ido-my-keys)

(setq load-prefer-newer t)


(projectile-global-mode)

;;customizations for company-mode
(global-company-mode)

(eval-after-load 'company
  '(progn
     (define-key company-active-map (kbd "C-j") 'company-select-next)
     (define-key company-active-map (kbd "J") 'company-select-next)
     (define-key company-active-map (kbd "C-n") 'company-select-next)
     (define-key company-active-map (kbd "C-k") 'company-select-previous)
     (define-key company-active-map (kbd "K") 'company-select-previous)
     (define-key company-active-map (kbd "C-p") 'company-select-previous)
     (setq company-idle-delay 0.5)
     (global-set-key (kbd "C-.") 'company-complete)))


;;fix company mode color scheme to be better with tango-dark
;; (require 'color)
  
;; (let ((bg (face-attribute 'default :background)))
;;   (custom-set-faces
;;    `(company-tooltip ((t (:inherit default :background ,(color-darken-name bg 10) :foreground "salmon"))))
;;    `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
;;    `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
;;    `(company-tooltip-selection ((t (:inherit font-lock-function-name-face :background ,(color-darken-name bg 5) :bold t))))
;;    `(company-tooltip-common ((t (:inherit company-tooltip))))
;;    `(company-tooltip-annotation ((t (:inherit company-tooltip :foreground ,(color-lighten-name bg 15)))))
;;    `(company-tooltip-common-selection ((t (:inherit ido-incomplete-regexp))))
;;    `(company-preview-common ((t (:inherit ido-subdir))))))
