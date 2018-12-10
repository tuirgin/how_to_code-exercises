;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname bullseye) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define SCENE-WIDTH 100)
(define SCENE-HEIGHT SCENE-WIDTH)
(define SCENE (empty-scene SCENE-WIDTH SCENE-HEIGHT))

(define MODE 'solid)

(define C1-RADIUS 10)
(define C1-COLOR 'yellow)
(define C1 (circle C1-RADIUS MODE C1-COLOR))
(define C2-RADIUS (* C1-RADIUS 2))
(define C2-COLOR 'red)
(define C2 (circle C2-RADIUS MODE C2-COLOR))
(define C3-RADIUS (* C1-RADIUS 3))
(define C3-COLOR 'cyan)
(define C3 (circle C3-RADIUS MODE C3-COLOR))
(define C4-RADIUS (* C1-RADIUS 4))
(define C4-COLOR 'black)
(define C4 (circle C4-RADIUS MODE C4-COLOR))

(define BULLSEYE
  (overlay C1 C2 C3 C4))

(place-image BULLSEYE
             (/ SCENE-WIDTH 2)
             (/ SCENE-HEIGHT 2)
             SCENE)