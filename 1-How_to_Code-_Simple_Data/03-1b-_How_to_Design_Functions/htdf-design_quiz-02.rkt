;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname htdf-design-quiz) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; PROBLEM:
;;
;; Design a function that consumes two images and produces true if the first is
;; larger than the second.

;; Student Comment:
;; "Larger" seems ambiguous. Taller (height) or Wider (width) or Total Area?
;; Area seems most likely.


;; CONSTANTS

(define tiny-img-1 (square 0.5 'outline 'black))
(define tiny-img-2 (square 0.500001 'outline 'black))
(define tall-img (rectangle 1 2 'outline 'black))
(define small-img (square 12 'outline 'black))
(define large-img (square 24 'outline 'black))


;; FUNCTIONS

;; Image Image -> Boolean
;; Given two images, return #t if the first is largest by area.

;; Note that the implementation rounds to the nearest integer for calculating
;; image area.
(check-expect (larger? empty-image empty-image) #f)
(check-expect (larger? empty-image tiny-img-1) #f)
(check-expect (larger? tiny-img-1 empty-image) #f) ; Due to integer rounding
(check-expect (larger? tiny-img-2 empty-image) #t)
(check-expect (larger? tall-img (rotate 90 tall-img)) #f)
(check-expect (larger? small-img large-img) #f)
(check-expect (larger? large-img small-img) #t)

;(define (larger? img1 img2) #f) ; stub
;(define (larger? img1 img2)     ; template
;  (... img1 img2))

(define (larger? img1 img2)
  (> (image-area img1) (image-area img2)))


;; Image -> Integer
;; Given an image, return the area

;; Note that image-height and image-width round to the nearest integer
;; with a threshold of 0.5:
(check-expect (image-height (square 0.5 'outline 'black)) 0)
(check-expect (image-width  (square 0.5 'outline 'black)) 0)
(check-expect (image-height (square 0.500001 'outline 'black)) 1)
(check-expect (image-width  (square 0.500001 'outline 'black)) 1)

(check-expect (image-area tiny-img-1) (* 0 0))
(check-expect (image-area tiny-img-2) (* 1 1))
(check-expect (image-area tall-img) (* 1 2))

;(define (image-area img) 0); stub

(define (image-area img)
    (* (image-height img) (image-width img)))