;;; .emacs --- summary
;;; Commentary:
;;; Code:


;; impose gnutls-cli when supported -- this requires an initial
;; manual execution of gnutls-cli --strict-tofu -p <port> <host>
;; to store a host's SSL certificate before it can be accepted
(if (fboundp 'gnutls-available-p)
    (fmakunbound 'gnutls-available-p))
(setq tls-program '("gnutls-cli --strict-tofu -p %p %h")
      imap-ssl-program '("gnutls-cli --strict-tofu -p %p %s"))

(require 'cask "~/.cask/cask.el")
(cask-initialize)

;;package archive
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
			 ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

;;el-get
;;https://github.com/dimitri/el-get

;;(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
;;(unless (require 'el-get nil 'noerror)
;;  (with-current-buffer
;;      (url-retrieve-synchronously
;;       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
;;    (let (el-get-master-branch)
;;      (goto-char (point-max))
;;      (eval-print-last-sexp))))
;;(el-get 'sync)


;; Prefer backward-kill-word over Backspace
(global-set-key "\C-w"     'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
(global-set-key "\C-cg" 'magit-status)

;; Lose the UI
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;;
;; org-mode
;;
(add-to-list 'load-path "~/.emacs.d/elisp/org-mode/lisp")
(require 'org)

;; MobileOrg
(defvar org-mobile-directory "~/mobileorg")
(defvar org-mobile-inbox-for-pull "~/org/from-mobile.org")


;; This is the org-mode.el file generated from C-c C-v C-t
;; in http://doc.norang.ca/org-mode.org
(load-file "~/.emacs.d/lisp/org-mode.el")
;; anything after that takes over
(require 'ox-reveal)


;; Capture
;(setq org-default-notes-file (concat org-directory "/org/notes.org"))
;(define-key global-map "\C-cc" 'org-capture)
;; Layout: indented (setq org-startup-indented t)
;(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;; Clocking work time
;(setq org-log-done 'time) ;; not needed with org-todo-keywords sequence
;(setq org-clock-idle-time "10")  ;; http://orgmode.org/manual/Resolving-idle-time.html
;(setq org-clock-continuously t)  ;; http://orgmode.org/manual/Resolving-idle-time.html
;(setq org-clock-persist 'history)
;(org-clock-persistence-insinuate)

;(global-set-key (kbd "C-c a") 'org-agenda)
;(global-set-key (kbd "C-c v") 'org-show-todo-tree)

;; ! (for a timestamp)
;; @ (for a note with timestamp)
;(setq org-todo-keywords
;      '((sequence "TODO(t)"
;		  "DEFERRED(d!)"
;		  "DELEGATED(D@)"
;		  "STARTED(s!)"
;		  "WAITING(w@/!)"
;		  "DONE(o!)"
;		  "CANCELLED(c@)")))
;(setq org-agenda-files (quote ("~/org/actions.org")))
;(setq org-agenda-include-diary t)
;(setq org-agenda-include-all-todo t)

;(setq org-capture-templates
;      '(
;	("q" "Question" 
;	 entry (file+headline "~/org/notes.org" "Questions")
;	 "* TODO %?\n  %i\n  %a")
;	("t" "Todo" 
;	 entry (file+headline "~/org/notes.org" "Tasks")
;	 "* TODO %?\n  %i\n  %a")
;       ("j" "Journal" entry (file+datetree "~/org/journal.org")
;	 "* %?\nEntered on %U\n  %i\n  %a")
;	)
;      )

;;http://emacswiki.org/emacs/InteractivelyDoThings 
(require 'ido)
(ido-mode t)

;; http://www.emacswiki.org/emacs/AnsiColor
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(load-file "~/.emacs.d/lisp/color-theme-julie.el")
(color-theme-julie)

;; jedi-mode
(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook 'auto-complete-mode)
(setq jedi:complete-on-dot t)
(setq jedi:jedi:install-imenu t)

;; elpy setup --- using python.el for now
;;(package-initialize)
;;(elpy-enable)
;;(elpy-use-ipython)
;;(elpy-clean-modeline)
;;(setq elpy-rpc-backend "jedi")

;;enable flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;;(require 'autopair)
(autopair-global-mode) ;; to enable in all buffers

;; twittering-mode
(setq twittering-use-master-password t)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "/usr/bin/conkeror")

;; ix.io
(setq ix-user "etomer")
(setq ix-token "password")

;; multiple cursors - edit multiple lines
;; http://emacsrocks.com/e13.html
;; https://github.com/magnars/multiple-cursors.el
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


;; Use certificate pinning to know when a certificate changes
;; and avoid MitM attacks. This requires an initial manual
;; of gnutlc-cli --strict-tofu -p <port> <host> for every
;; mail server used in order to review and accept their
;; certificates.

;; SMTP
(setq starttls-use-gnutls t
      starttls-gnutls-program "gnutls-cli"
      starttls-extra-arguments '("--strict-tofu"))

;(setq starttls-gnutls-program "gnutls-cli"
;      smtpmail-debug-info t
;      smtpmail-debug-verb t
;      smtpmail-stream-type 'starttls)
;
;(setq starttls-use-gnutls t
;      starttls-gnutls-program "gnutls-cli --strict-tofu -p %p %h"
;      starttls-extra-arguments '("--strict-tofu"))

;; IMAP

;(setq gnus-select-method
;      '(nnimap "portemanteau"
;	     (nnimap-address "portemanteau.ca")
;	     (nnimap-server-port 993)
					;	     (nnimap-stream ssl)))

(setq gnus-select-method
      '(nnimap "gmail"
	       (nnimap-address "imap.gmail.com")
	       (nnimap-server-port 993)
	       (nnimap-stream ssl)))

;(add-to-list 'gnus-secondary-select-methods
;	     '(nnimap "gmail"
;		      (nnimap-address "imap.gmail.com")
;		      (nnimap-server-port 993)
;		      (nnimap-stream ssl)))

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

(setq user-mail-address "nicolas.couture@gmail.com")
(setq user-full-name "Nicolas Couture")

;(setq message-send-mail-function 'smtpmail-send-it
;      smtpmail-starttls-credentials '(("portemanteau.ca" 465 nil nil))
;      smtpmail-auth-credentials '(("portemanteau.ca" 465
;				   "self@portemanteau.ca" nil))      
;      smtpmail-default-smtp-server "portemanteau.ca"
;      smtpmail-smtp-server "portemanteau.ca"
;      smtpmail-smtp-service 465
;      gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587
				   "nicolas.couture@gmail.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "gmail"
      smtpmail-smtp-service 587
      gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

(setq erc-server-auto-reconnect nil)

(provide '.emacs)
;;; .emacs ends here
