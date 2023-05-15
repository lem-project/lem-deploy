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
(defmethod asdf:perform ((o asdf:load-op) (s asdf:require-system))
  nil)

(defmethod asdf:output-files :around ((operation t) (component t))
  (call-next-method)
  ;; XXX:
  ;; Disable the following code defined in asdf
  ;; because the target environment may refer to directories in the host environment
  #+(or)
  (do-asdf-cache `(output-files ,operation ,component)
    (values
     (multiple-value-bind (pathnames fixedp) (call-next-method)
       ;; 1- Make sure we have absolute pathnames
       (let* ((directory (pathname-directory-pathname
                          (component-pathname (find-component () component))))
              (absolute-pathnames
                (loop
                  :for pathname :in pathnames
                  :collect (ensure-absolute-pathname pathname directory))))
         ;; 2- Translate those pathnames as required
         (if fixedp
             absolute-pathnames
             (mapcar *output-translation-function* absolute-pathnames))))
     t)))

(defun launch (&optional (args (uiop:command-line-arguments)))
  (setup-foreign-library-directories)
  (apply #'lem:lem args))
