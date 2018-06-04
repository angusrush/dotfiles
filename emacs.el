;; My peersonal lisp directory
(add-to-list 'load-path "~/.emacs.d/lisp/")

;;(load "evil-latex-textobjects")
;;(add-hook 'LaTeX-mode-hook 'turn-on-evil-latex-textobjects-mode)

;; add package archives
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (evil-easymotion evil-collection powerline-evil helm yasnippet adaptive-wrap linum-relative evil-exchange nord-theme evil-surround evil auctex ##))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Evil mode!
(setq evil-want-integration nil)
(require 'evil)
(evil-mode 1)
(setq evil-normal-state-modes (append evil-motion-state-modes evil-normal-state-modes))
(setq evil-motion-state-modes nil)

;; Escape should abort commands
(defun minibuffer-keyboard-quit ()
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)

;; Evil keybindings for most modes
(evil-collection-init)

;; vim-exchange for emacs
(require 'evil-exchange)

;; Spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; Evil surround
(global-evil-surround-mode 1)

;; Evil exchange
(require 'evil-exchange)
(evil-exchange-install)

;; Nice color scheme
(require 'nord-theme)

;; Show matching parens
(show-paren-mode t)

;; Relative Line numbers
(linum-relative-global-mode)

;; Smooth scrolling
(setq scroll-margin 5
      scroll-conservatively 9999
      scroll-step 1)

;; Indent wrapped lines correctly
(require 'adaptive-wrap)
(adaptive-wrap-prefix-mode)

;; Disable gui
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)

;; A nice font
(set-default-font "Source Code Pro for Powerline 9")

;; vim: filetype=lisp
