;;;; art.lisp

(in-package #:art)

;;; "art" goes here. Hacks and glory await!

(defvar *image-viewer-command*
  (or (probe-file "/usr/bin/open")
      (probe-file "/usr/bin/gnome-open")
      nil)
  "Set this to a command that can display image files.")

(defconstant 2pi (* pi 2))

(defun view (file)
  (unless *image-viewer-command*
    (error "Don't know how to view stuff; set ~S to something"
           '*image-viewer-command*))
  (commando:run *image-viewer-command* (pathname file)))

(defun rdegrees (radians)
  (* radians (/ 180 pi)))

(defun choose-one (&rest options)
  (elt options (random (length options))))

(define-compiler-macro choose-one (&rest options)
  `(aref #(,@options) (random ,(length options))))



