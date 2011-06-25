;;;; art.asd

(asdf:defsystem #:art
  :serial t
  :depends-on (#:vectometry
               #:commando
               #:alexandria)
  :components ((:file "package")
               (:file "art")
               (:file "circly")
               (:file "hexagraphic")))

