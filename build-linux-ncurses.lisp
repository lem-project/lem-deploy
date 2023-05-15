(ql:quickload :lem-ncurses)

(cffi:close-foreign-library 'async-process::async-process)

(defun setup-foreign-library-directories ()
  (setf cffi:*foreign-library-directories* '())
  (cffi:load-foreign-library (lem:lem-relative-pathname "lib/libasyncprocess.so")))

(load "general.lisp")

(apply #'sb-ext:save-lisp-and-die
       "linux/lem-ncurses"
       :toplevel 'launch
       :executable t
       #+sb-core-compression
       '(:compression -1)
       #-sb-core-compression
       '())
