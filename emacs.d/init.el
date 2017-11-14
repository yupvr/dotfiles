;; Setup MELPA repository
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (multiple-cursors puppet-mode ox-twbs rainbow-mode zeal-at-point web-mode highlight-indent-guides robe inf-ruby rvm flycheck-gometalinter go-guru gotest go-snippets go-scratch go-eldoc company-go go-mode pass apache-mode nginx-mode flyspell-popup exec-path-from-shell docker-compose-mode dockerfile-mode ssh-config-mode ansible company-ansible indent-tools flycheck-yamllint yaml-mode ag json-mode chef-mode highlight-blocks yasnippet yasnippet-snippets all-the-icons-ivy counsel counsel-projectile ivy swiper projectile avy avy-flycheck flycheck company-quickhelp company company-statistics solarized-theme theme-changer zenburn-theme nyan-mode spaceline-all-the-icons spaceline all-the-icons-dired all-the-icons smex switch-window tabbar diff-hl magit smartparens markdown-mode)))
 '(spaceline-all-the-icons-clock-always-visible nil)
 '(spaceline-all-the-icons-separator-type (quote arrow))
 '(spaceline-all-the-icons-slim-render t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Hack" :foundry "simp" :slant normal :weight normal :height 120 :width normal)))))

;; Highlight current line
(global-hl-line-mode t)

;; Highlight parentheses
(show-paren-mode 1)

;; Delete trailing whitespaces before safe
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Set defaulr web browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox")

;; SMARTPARENS
;; Enable smartparens mode
(smartparens-global-mode 1)

;; DIFF-HL
;; Highlight diff in file and directory
(global-diff-hl-mode t)
(diff-hl-flydiff-mode 1)
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
(add-hook 'dired-mode-hook 'diff-hl-dired-mode)

;; TABBAR
;; Show tabs
(tabbar-mode 1)

;; SWITCH-WINDOW
;; Window switching, the visual way.
(global-set-key (kbd "C-x o") 'switch-window)

;; ;; SMEX
;; (global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; ;; This is your old M-x.
;; (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; ALL-THE-ICONS
;; Show file icons in dired mode
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

;; SPACELINE, NYAN-MODE
;; Customise status bar
(require 'spaceline-config)
(spaceline-emacs-theme)
(require 'spaceline-all-the-icons)
(spaceline-all-the-icons-theme)
(nyan-mode t)

;; THEME-CHANGER
;; Day/night themes toggling
(setq calendar-location-name "Gdansk, Poland")
(setq calendar-latitude 54.366667)
(setq calendar-longitude 18.633333)
(require 'theme-changer)
(change-theme 'solarized-light 'zenburn)

;; COMPANY
;; Enable company mode by default
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'after-init-hook 'company-statistics-mode)
;; Show function describtion
(company-quickhelp-mode 1)

;; AVY
;; Set avy key
(global-set-key (kbd "C-:") 'avy-goto-char)
(global-set-key (kbd "C-'") 'avy-goto-char-2)
(global-set-key (kbd "M-g f") 'avy-goto-line)
(global-set-key (kbd "M-g w") 'avy-goto-word-1)
(global-set-key (kbd "M-g e") 'avy-goto-word-0)

;; FLYSPELL
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'flyspell-mode-hook #'flyspell-popup-auto-correct-mode)
(require 'flyspell-popup)
(define-key flyspell-mode-map (kbd "C-;") 'flyspell-popup-correct)

;; FLYCHECK
(global-flycheck-mode)
(global-set-key (kbd "C-c e") 'avy-flycheck-goto-error)

;; PROJECTILE
;; Enable projectile dy default
(projectile-global-mode)

;; IVY
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
(counsel-projectile-on)
(setq projectile-completion-system 'ivy)
(setq ivy-count-format "(%d/%d) ")
(setq ivy-height 15)
(setq magit-completing-read-function 'ivy-completing-read)
(all-the-icons-ivy-setup)

;; MULTIPLE-CURSORS
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; YASNIPPET
;; Enable yasnippet
(yas-global-mode 1)
(require 'company-yasnippet)
(global-set-key (kbd "C-c y") 'company-yasnippet)

;; INDENT-TOOLS
(require 'indent-tools)
(global-set-key (kbd "C-c >") 'indent-tools-hydra/body)

;; HIGHLIGHT-INDENT-GUIDES
(require 'highlight-indent-guides)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
;; (setq highlight-indent-guides-method 'fill)

;; EXEC-PATH-FROM-SHELL
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; SHOW ZEAL
(global-set-key (kbd "C-c d") 'zeal-at-point)

;; RUBY
;; Show line numbers
(add-hook 'ruby-mode-hook 'linum-mode)
;; Highlight ruby blocks
(add-hook 'ruby-mode-hook 'highlight-blocks-mode)
;; Enable chef snippets
(add-hook 'ruby-mode-hook
	  (lambda ()
	    (yas-activate-extra-mode 'chef-mode)))
;; Load inf-ruby
(autoload 'inf-ruby-minor-mode "inf-ruby" "Run an inferior Ruby process" t)
(add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)
;; Enable robe
(add-hook 'ruby-mode-hook 'robe-mode)

;; ORG-MODE
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)
;; Set to the location of your Org files on your local system
(setq org-directory "~/org")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/org/flagged.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/Програми/MobileOrg")

;; JSON
;; Show line numbers
(add-hook 'json-mode-hook 'linum-mode)
;; Set indent lenth to 2
(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))

;; YAML
;; Show line numbers
(add-hook 'yaml-mode-hook 'linum-mode)
;; Highlight ruby blocks
(add-hook 'yaml-mode-hook 'highlight-blocks-mode)

;; ANSIBLE
(add-to-list 'company-backends 'company-ansible)

;; GO
;; Install requirement go packages
;; go get -u github.com/rogpeppe/godef
;; go get -u golang.org/x/tools/cmd/goimports
;; go get -u github.com/nsf/gocode
;; go get -u golang.org/x/tools/cmd/gorename
;; go get -u github.com/golang/lint/golint
;; go get -u github.com/kisielk/errcheck
;; go get -u github.com/mdempsky/unconvert
;; go get -u honnef.co/go/tools/cmd/megacheck
;; go get -u golang.org/x/tools/cmd/guru
;; go get -u github.com/alecthomas/gometalinter
;; Set environment variables
(setenv "PATH" (concat "/usr/local/go/bin:" (getenv "PATH")))
(setq exec-path (cons "/usr/local/go/bin" exec-path))
(setq exec-path (cons (concat (getenv "HOME") "/Huyakhuyak/golang/bin") exec-path))
(setenv "GOPATH" (concat (getenv "HOME") "/Huyakhuyak/golang"))
;; Enable line numbers
(add-hook 'go-mode-hook 'linum-mode)
;; Format code before safe
(add-hook 'before-save-hook 'gofmt-before-save)
;; update import list
(setq gofmt-command "goimports")
(add-to-list 'company-backends 'company-go)
(add-hook 'go-mode-hook 'go-eldoc-setup)
;; Create compile command
(defun go-compile ()
  (set (make-local-variable 'compile-command)
       "go build -v && go test -v && go vet"))
(add-hook 'go-mode-hook 'go-compile)
(add-hook 'go-mode-hook #'go-guru-hl-identifier-mode)
;; ;; Use gometalinter
;; (require 'flycheck-gometalinter)
;; (eval-after-load 'flycheck
;;   '(add-hook 'flycheck-mode-hook #'flycheck-gometalinter-setup))
