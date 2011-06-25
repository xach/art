;;;; hexagraphic.lisp

(in-package #:art)

(defun hexagon (center radius &key (rotation 0))
  "Draw a hexagon at CENTER with vertexes inscribed in a circle of
RADIUS size."
  (let* ((step (/ pi 3))
        (angle rotation)
        (point (add center (apoint angle radius))))
    (move-to point)
    (dotimes (i 5)
      (incf angle step)
      (line-to (add center (apoint angle radius))))
    (close-subpath)))

(defun call-for-tiling (&key box fun radius)
  "Call FUN with the centerpoint of each hexagon of size RADIUS tiled
  into BOX"
  (let* ((r radius)
         (oddp nil)
         (offset r)
         (width (+ r (width box)))
         (height (+ r (height box)))
         (xstep (sqrt (- (expt (* r 2) 2)
                         (expt r 2))))
         (ystep (* r 2)))
    (print xstep)
    (loop for x below width by xstep
          do
          (if oddp
              (setf oddp nil offset 0)
              (setf oddp t offset r))
          (loop for y below height by ystep
                do
                (funcall fun (point x (+ offset y)))))))

(defun colorizer (point)
  (lambda (p)
    (let ((a (angle point p)))
      (hsv-color (rdegrees a) 1 (choose-one 0.2 0.3 0.4 0.5)))))

(defun tiler (&key width height radius file)
  (let* ((canvas (box 0 0 width height))
         (colorizer (colorizer (centerpoint canvas))))
    (with-box-canvas canvas
      (set-fill-color *black*)
      (clear-canvas)
      (call-for-tiling :box canvas
                       :radius radius
                       :fun (lambda (point)
                              (hexagon point radius)
                              (set-fill-color (funcall colorizer point))
                              (fill-path)
                              (set-fill-color (rgba-color 0 0 0
                                                          (choose-one 0.75
                                                                      0.85)))
                              (hexagon point (* radius
                                                (choose-one 0.9 0.85)))
                              (fill-path)))
      (save-png file))))





