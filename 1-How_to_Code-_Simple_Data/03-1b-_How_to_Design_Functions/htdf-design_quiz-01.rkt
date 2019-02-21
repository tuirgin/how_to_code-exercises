;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Quiz1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
;;image -> boolean
;;given two images determine whether the first is larger

(check-expect (big? (rectangle 10 10 "solid" "blue") (rectangle 20 20 "solid" "red")) false)
(check-expect (big? (rectangle 20 20 "solid" "blue") (rectangle 10 10  "solid" "red")) true)

(check-expect (big? (rectangle 20 20 "solid" "blue") (rectangle 10 20 "solid" "red")) true)
(check-expect (big? (rectangle 20 20 "solid" "blue") (rectangle 20 10 "solid" "red")) true)

(check-expect (big? (rectangle 20 10 "solid" "blue") (rectangle 10 20 "solid" "red")) false)
(check-expect (big? (rectangle 10 20 "solid" "blue") (rectangle 20 10 "solid" "red")) false)

;;(define (big? IMAGE1 IMAGE2) 0)   ;stub
;;(define (big? IMAGE1 IMAGE2)      ;template
; (...true))

(define (big? IMAGE1 IMAGE2)

(and (>= (image-width IMAGE1)
         (image-width IMAGE2))
     (>= (image-height IMAGE1)
         (image-height IMAGE2))))