(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(vc-follow-symlinks t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
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

(put 'narrow-to-region 'disabled nil)
