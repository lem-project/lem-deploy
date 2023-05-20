(ql:quickload :lem-sdl2)

(cffi:close-foreign-library 'async-process::async-process)
(cffi:close-foreign-library 'sdl2::libsdl2)
(cffi:close-foreign-library 'sdl2-ttf::libsdl2-ttf)
(cffi:close-foreign-library 'sdl2-image::libsdl2-image)

(defun setup-foreign-library-directories ()
  (uiop:chdir (user-homedir-pathname))

  (setf cffi:*foreign-library-directories* '())
  (setf lem-sdl2/resource::*resource-directory*
        (lem:lem-relative-pathname "../Resources/"))

  (cffi:load-foreign-library (lem:lem-relative-pathname "../Frameworks/libasyncprocess.so"))
  (cffi:load-foreign-library (lem:lem-relative-pathname "../Frameworks/libSDL2-2.0.0.dylib"))
  (cffi:load-foreign-library (lem:lem-relative-pathname "../Frameworks/libSDL2_image-2.0.0.dylib"))
  (cffi:load-foreign-library (lem:lem-relative-pathname "../Frameworks/libSDL2_ttf-2.0.0.dylib")))

(lem:copy-file-or-directory (asdf:system-relative-pathname :lem-sdl2 "resources/")
                            "darwin/arm64/lem.app/Contents/Resources/resources/")

(load "general.lisp")

(sb-ext:save-lisp-and-die "darwin/arm64/lem.app/Contents/MacOS/lem"
                          :toplevel 'launch
                          :executable t
                          :compression nil)
