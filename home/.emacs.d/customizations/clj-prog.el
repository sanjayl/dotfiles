;; Quick and dirty repl
;; maybe move this to inf-clojure?
;; http://batsov.com/articles/2014/12/04/introducing-inf-clojure-a-better-basic-clojure-repl-for-emacs/
(defun clj-repl () (interactive)
       (pop-to-buffer (make-comint "clj-repl" "java" nil "-jar" "/home/sanjay/.m2/repository/org/clojure/clojure/1.8.0/clojure-1.8.0.jar")))


;;;;
;; Cider
;;;;

;; provides minibuffer documentation for the code you're typing into the repl
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

;; go right to the REPL buffer when it's finished connecting
(setq cider-repl-pop-to-buffer-on-connect t)

;; When there's a cider error, show its buffer and switch to it
(setq cider-show-error-buffer t)
(setq cider-auto-select-error-buffer t)

;; Where to store the cider history.
(setq cider-repl-history-file "~/.emacs.d/cider-history")

;; Wrap when navigating history.
(setq cider-repl-wrap-history t)

;; enable paredit in your clj and REPL
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)

(defun toggle-paredit-mode ()
  (interactive)
  (paredit-mode 'toggle))

(defun cider-start-http-server ()
  (interactive)
  (cider-load-current-buffer)
  (let ((ns (cider-current-ns)))
    (cider-repl-set-ns ns)
    (cider-interactive-eval (format "(println '(def server (%s/start))) (println 'server)" ns))
    (cider-interactive-eval (format "(def server (%s/start)) (println server)" ns))))


(defun cider-refresh ()
  (interactive)
  (cider-interactive-eval (format "(user/reset)")))

(defun cider-user-ns ()
  (interactive)
  (cider-repl-set-ns "user"))

(eval-after-load 'cider
  '(progn
     (define-key clojure-mode-map (kbd "C-c C-v") 'cider-start-http-server)
     (define-key clojure-mode-map (kbd "M-r") 'cider-refresh)
     (define-key clojure-mode-map (kbd "C-c u") 'cider-user-ns)
     (define-key cider-mode-map (kbd "C-c u") 'cider-user-ns)
     (define-key cider-mode-map (kbd "C-c s") 'cider-scratch)))

;;(eval-after-load 'paredit
;;  '(define-key clojure-mode-map (kbd "C-c p") 'toggle-paredit-mode))

(require 'clj-refactor)

(defun my-clojure-mode-hook ()
     (clj-refactor-mode 1)
     ;(yas-minor-mode 1) ; for adding require/use/import
     (cljr-add-keybindings-with-prefix "C-c r"))

(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)

(add-hook 'clojure-mode-hook #'aggressive-indent-mode)
