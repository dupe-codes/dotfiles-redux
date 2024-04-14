;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; ================
;; General settings
;; ================

(setq doom-theme 'doom-tokyo-night)
(setq display-line-numbers-type 'relative)
(setq scroll-margin 8)
(setq org-directory "~/org/")
(global-visual-line-mode t)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys

;; ==============
;; package setups
;; ==============

(global-wakatime-mode)

;; hydra ui controls

(defhydra doom-window-resize-hydra (:hint nil)
  "
             _k_ increase height
_h_ decrease width    _l_ increase width
             _j_ decrease height
"
  ("h" evil-window-decrease-width)
  ("j" evil-window-increase-height)
  ("k" evil-window-decrease-height)
  ("l" evil-window-increase-width)
  ("q" nil))
(map! :leader
      :desc "Hydra resize" "w SPC" #'doom-window-resize-hydra/body)

;; Agda configs

; Configure agda mode on relevant files
(setq auto-mode-alist
   (append
     '(("\\.agda\\'" . agda2-mode)
       ("\\.lagda.md\\'" . agda2-mode))
     auto-mode-alist))

; C-l isn't working in kitty for *gestures broadly* reasons
; so we'll use C-c C-g for agda2-load instead
; Set up keybind to switch from horizontal to vertial agda information
; view
(defun agda-vertical-view ()
  "Set up Agda mode in a split window configuration."
  (interactive)
  (agda2-load)
  (delete-other-windows)
  (split-window-right)
  (other-window 1)
  (switch-to-buffer "*Agda information*")
  (other-window 1))
(add-hook 'agda2-mode-hook
          (lambda ()
            (define-key agda2-mode-map (kbd "C-c C-l") nil)
            (define-key agda2-mode-map (kbd "C-c C-g") 'agda2-load)
            (define-key agda2-mode-map (kbd "C-c C-,") nil)
            (define-key agda2-mode-map (kbd "C-c ,") 'agda2-goal-and-context)
            (define-key agda2-mode-map (kbd "C-c C-v") 'agda-vertical-view)))

;; Copilot configs

;; accept completion from copilot and fallback to company
;; TODO: Change generated completions from ghosted text to
;;       selectable option in completions menu
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

;; TODO: configure flyerror checker to show in side gutter

;; ================
;; General Keybinds
;; ================

;; TODO: this isn't working? what key to use on gigabox...?
(setq x-super-keysym 'meta) ; map super to meta key

