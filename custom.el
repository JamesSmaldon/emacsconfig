;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(cond-let eat inheritenv vterm))
 '(safe-local-variable-values
   '((eval let
           ((dape-configs-file
             (locate-dominating-file default-directory ".dape-configs.el")))
           (when dape-configs-file
             (load-file (concat dape-configs-file ".dape-configs.el"))))
     (eval let
           ((dap-templates-file
             (locate-dominating-file default-directory ".dap-templates.el")))
           (when dap-templates-file
             (load-file (concat dap-templates-file ".dap-templates.el")))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
