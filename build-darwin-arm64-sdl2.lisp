(ql:quickload :lem-sdl2)

(cffi:close-foreign-library 'async-process::async-process)
(cffi:close-foreign-library 'sdl2::libsdl2)
(cffi:close-foreign-library 'sdl2-ttf::libsdl2-ttf)
(cffi:close-foreign-library 'sdl2-image::libsdl2-image)

#+(or)
(defun p (x)
  (with-open-file (out "~/lem.log"
                       :direction :output
                       :if-exists :append
                       :if-does-not-exist :create)
    (uiop:println x out)))

#+(or)
(defun depends-libs ()
  (loop :for lib :in (cffi:list-foreign-libraries)
        :for lib-pathname := (cffi:foreign-library-pathname lib)
        :unless (uiop:string-prefix-p "/System" (namestring lib-pathname))
        :collect lib-pathname))

(defun setup-foreign-library-directories ()
  ;; (p "setup-foreign-library-directories")

  ;; (setf (uiop:getenv "DYLD_FALLBACK_LIBRARY_PATH") (format nil "/usr/local/lib:/usr/lib:~A" (namestring (lem:lem-relative-pathname "../Frameworks/"))))
  ;; (setf (uiop:getenv "DYLD_LIBRARY_PATH") (namestring (lem:lem-relative-pathname "../Frameworks/")))

  (uiop:chdir (user-homedir-pathname))

  (setf cffi:*foreign-library-directories* '())
  (setf lem-sdl2/resource::*resource-directory*
        (lem:lem-relative-pathname "../Resources/"))

  (dolist (file (uiop:directory-files (lem:lem-relative-pathname "../Frameworks/")))
    (cffi:load-foreign-library file)))

(lem:copy-file-or-directory (asdf:system-relative-pathname :lem-sdl2 "resources/")
                            "darwin/arm64/lem.app/Contents/Resources/resources/")

(load "general.lisp")

(sb-ext:save-lisp-and-die "darwin/arm64/lem.app/Contents/MacOS/lem"
                          :toplevel 'launch
                          :executable t
                          :compression nil)
