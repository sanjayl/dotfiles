(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(safe-local-variable-values
   (quote
    ((checkdoc-package-keywords-flag)
     (bug-reference-bug-regexp . "#\\(?2:[[:digit:]]+\\)"))))
 '(vc-follow-symlinks t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-preview-common ((t (:inherit ido-subdir))))
 '(company-scrollbar-bg ((t (:background "#454e51"))))
 '(company-scrollbar-fg ((t (:background "#394143"))))
 '(company-tooltip ((t (:inherit default :background "#16191a" :foreground "salmon"))))
 '(company-tooltip-annotation ((t (:inherit company-tooltip :foreground "#515b5f"))))
 '(company-tooltip-common ((t (:inherit company-tooltip))))
 '(company-tooltip-common-selection ((t (:inherit ido-incomplete-regexp))))
 '(company-tooltip-mouse ((t (:background "salmon" :foreground "black"))))
 '(company-tooltip-selection ((t (:inherit font-lock-function-name-face :background "#222628" :bold t))))
 '(ido-subdir ((t (:foreground "salmon")))))

(add-to-list 'load-path "~/.emacs.d/customizations")
(load "deps")
(load "random")
(load "clj-prog")

(defun open-dot-emacs-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-other-window user-init-file))

(defun open-dot-emacs-customization-file ()
  (interactive)
  (find-file-other-window (concat user-emacs-directory "customizations/random.el")))

;(put 'narrow-to-region 'disabled nil)
