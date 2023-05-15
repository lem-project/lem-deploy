(in-package :cl-user)

(setq lem::*deployed* t)
(lem-lisp-mode/swank-modules:require-swank-modules)

(dolist (module sb-impl::*modules*)
  (require module))

(setq asdf:*output-translations-parameter* nil
      asdf/output-translations:*output-translations* nil)

;; XXX:
;; (ql:quickload :drakma) causes sb-bsd-sockets require to fail.
;; Override this method to work around it.
;; (defmethod asdf:perform ((o asdf:load-op) (s asdf:require-system))
;;   nil)

(defun launch (&optional (args (uiop:command-line-arguments)))
  (setup-foreign-library-directories)
  (apply #'lem:lem args))
