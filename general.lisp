(in-package :cl-user)

(setq lem::*deployed* t)
(lem-lisp-mode/swank-modules:require-swank-modules)

(defun launch (&optional (args (uiop:command-line-arguments)))
  (setup-foreign-library-directories)
  (apply #'lem:lem args))
