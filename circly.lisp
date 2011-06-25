;;;; circly.lisp

(in-package #:art)

(defun circly (output-file &key (width 500) (height 500)
            (line-width 10)
            (line-gap 4))
  (let* ((canvas (box 0 0 width height))
         (center (centerpoint canvas))
         (step (+ line-width line-gap))
         (radius 0))
    (with-box-canvas canvas
      (translate center)
      (set-fill-color *black*)
      (clear-canvas)
      (set-line-width line-width)
      (set-line-cap :round)
      (set-line-width line-width)
      (loop
        (incf radius step)
        (when (< width radius)
          (return))
        (dotimes (i 8)
          (rotate (random 2pi))
          (set-stroke-color (hsv-color (- 30 (random 60)) 1.0
                                       (aref #(1.0 0.0) (random 2))))
          (apply #'arc *origin* radius
                 (sort (list (random 2pi) (random 2pi))
                       #'<))
          (stroke)))
      (save-png output-file))))
