(ql:quickload :lem-ncurses)

(cffi:close-foreign-library 'async-process::async-process)

(defun setup-foreign-library-directories ()
  (setf cffi:*foreign-library-directories* '())
  (cffi:load-foreign-library (lem:lem-relative-pathname "lib/libasyncprocess.so")))

(load "general.lisp")

(sb-ext:save-lisp-and-die "darwin/arm64/lem"
                          :toplevel 'launch
                          :executable t)
