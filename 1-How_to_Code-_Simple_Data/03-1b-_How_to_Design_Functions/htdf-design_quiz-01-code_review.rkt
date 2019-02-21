;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Megan-htdf_Quiz1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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



;; REVIEWER COMMENTS
;;
;; SIGNATURE
;;
;; Careful with your signature. The function consumes 2 images and produces a
;; boolean, so the signature should be:
;;
;; Image Image -> Boolean
;;
;; And they appear to want commas between the inputs, so:
;;
;; Image, Image -> Boolean

;; FUNCTION NAME
;;
;; An ideal function gives as much context as possible in a concise way. "big?"
;; makes me think I'm going to be evaluating A thing, one thing, to determine
;; if it is big for some definition of "big". "bigger?" would be better as it
;; suggests comparison of one thing against one or more other things.
;;
;; Sometimes it is helpful to be clear about the kind of thing you're working on.
;; This is the style of a lot of Racket and BSL functions. image-larger? would
;; distinguish an image related function from number-larger? string-larger? etc.
;; In dynamic languages you see a lot less of this (and Racket and BSL are actually
;; dynamic, just less so than Python. For example you'll see the use of ">" in
;; multiple contexts. You could actually add a ">" function to the string or
;; image class in python in order to compare two images like this. More info than
;; you need right now, I know.

;; TESTS
;;
;; The case you're missing is the same-size case. Drawing out a matrix like they
;; show in the eval video can be helpful even after you've been doign this a while.
;; Admittedly, I never do, but there have been plenty of times when I probably
;; would have benefited from thinking it through in greater detail.

;; FORMATTING
;;
;; They want the signature and the interp to begin with two comment characters,
;; followed by a space, so:

;; Image, Image -> Boolean
;; given two images determine whether the first is larger

;; And I'll add that I prefer to capitalize:

;; Image, Image -> Boolean
;; Given two images, produce True if the first is larger

;; I also prefer to spell out what "larger" means, "larger by area", so that
;; the ambiguity is reduced.
;;
;; I'd also separate your stub and your template by a blank line. This makes
;; it read a little easier, but is also more convenient for commenting out
;; an s-expression, which they may not have covered, yet. The following is
;; stub and template are commented out, but maintain formatting, and syntax
;; highlighting:

#;
(define (yabba-dabba-doo? s) #f) ;; stub

#;
(define (yabba-dabba-doo? s) ;; template
  (... s))

(define (yabba-dabba-doo? s)
  (string=? "yabba-dabba-doo" s))

;; Finally, the formatting of the finished function can be improved a little.
;; You have:

#;
(define (big? IMAGE1 IMAGE2)

(and (>= (image-width IMAGE1)
         (image-width IMAGE2))
     (>= (image-height IMAGE1)
         (image-height IMAGE2))))

;; This is syntactically correct, but a little harder to read than this, which
;; shows a better sense of nesting through indentation. 

#;
(define (big? IMAGE1 IMAGE2)
  (and (>= (image-width IMAGE1)
           (image-width IMAGE2))
       (>= (image-height IMAGE1)
           (image-height IMAGE2))))

;; The indentation is not mandatory for this language. But in Python indentation
;; is actually part of the syntax. Proper indentation is enforced and can actually
;; change meaning in your logic. This sounds awful, but usually only trips up
;; absolute beginners, except where copy/paste mangling comes to play.

;; SUMMARY
;;
;; I think you show that you understand the fundamental ideas here. Any problems
;; were more in the nature of fit-and-finish details, except for the signature.
;; Signatures are just comments in BSL, but in many languages they are actually
;; part of the code, and an incorrect signature will cause compilation errors.
;; Your code works and that is the most important part. And it's readable, too,
;; which is incredibly important.