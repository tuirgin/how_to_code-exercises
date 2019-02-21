;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname htdf-design-quiz-03) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; PROBLEM:
;
; Design a function that consumes two images and produces true if the first is larger than the second.
;


;; IMAGE1 IMAGE2 -> boolean
;; Consumes two images and produce true if first image is larger than second else produce false

;; cdw: T1: width of img1 is larger than img2; height are equal
(check-expect (is-image1-larger? (rectangle 30 30 "solid" "red") (rectangle 20 30 "solid" "yellow")) false)
;; cdw: T2: img1/img2 dimensions are identical
(check-expect (is-image1-larger? (rectangle 20 30 "solid" "red") (rectangle 20 30 "solid" "yellow")) false)
;; cdw: T3: width of img1 is smaller than img2; height are equal
(check-expect (is-image1-larger? (rectangle 10 30 "solid" "red") (rectangle 20 30 "solid" "yellow")) false)
;; cdw: T4: width are equal; height of img1 is larger than img2
(check-expect (is-image1-larger? (rectangle 30 40 "solid" "red") (rectangle 30 30 "solid" "yellow")) false)
;; cdw: T5: width of img1 is larger than img2; height are equal. NOTE: Identical to T1
(check-expect (is-image1-larger? (rectangle 30 30 "solid" "red") (rectangle 20 30 "solid" "yellow")) false)
;; cdw: T6: width of img1 is larger than img2; height of img1 is smaller than img2
(check-expect (is-image1-larger? (rectangle 30 10 "solid" "red") (rectangle 20 30 "solid" "yellow")) false)
;; cdw: T7: width of img1 is larger than img2; height of img1 is larger than img2
(check-expect (is-image1-larger? (rectangle 20 30 "solid" "red") (rectangle 10 20 "solid" "yellow")) true)

;(define (is-image1-larger? IMAGE1 IMAGE2) true)    ;Stub

;(define (is-image1-larger? IMAGE1 IMAGE2)          ;Template
;          (... IMAGE1 IMAGE2))

(define (is-image1-larger? IMAGE1 IMAGE2)
         (and (> (image-height IMAGE1)
                 (image-height IMAGE2))
              (> (image-width IMAGE1)
                 (image-width IMAGE2))))


;; RUBRIC BASED EVALUATION
;;
;; 1. The file should be neat and tidy, no tests or code should be commented out
;;    other than stubs and templates and all scratch work should be
;;    removed.
;;
;;------------------------------------------------------------------------------
;;
;;    Poor: File is quite sloppy, multiple tests or other code are commented
;;          out, and/or scratch work is left behind.
;;
;;    0 points
;;
;;------------------------------------------------------------------------------
;;
;;    Fair: One test or other code fragment is commented out, or one bit of
;;          scratch work is left behind.
;;
;;    1 points
;;
;;------------------------------------------------------------------------------
;;
;;    Good: The file is neat and tidy. Except for stubs and templates, no tests
;;          or other code is commented. All scratch work has been removed.
;;
;;    2 points
;;
;;------------------------------------------------------------------------------
;;
;; SCORE: Good, 2pts
;;
;;==============================================================================
;;
;; 2. All HtDF design elements should be present, and each element should be
;;    well formed. For this quiz, this includes signature, purpose,
;;    check-expects, commented out stub, commented out template and function
;;    definition.
;;
;;------------------------------------------------------------------------------
;;
;;    Poor: Two or more elements of the HtDF design elements are missing or
;;          poorly formed.
;;
;;    0 points
;;
;;------------------------------------------------------------------------------
;;
;;    Fair: One HtDF design elements is missing or poorly formed.
;;
;;    3 points
;;
;;------------------------------------------------------------------------------
;;
;;    Good: All HtDF design elements are present and well-formed.
;;
;;    5 points
;;
;;------------------------------------------------------------------------------
;;
;; SCORE: Good, 5pts
;;
;;==============================================================================
;;
;; 3. The signature should be correct, the purpose should be clear and succinct,
;;    the examples should be sufficient to test and explain the function. The
;;    function name should be well chosen and should describe what the function
;;    does, not how it does it. The stub should match the signature. The
;;    template should be correct. The function body should be clear. When the
;;    program is run all the tests should pass, and those tests should cover the
;;    entire program.
;;
;;------------------------------------------------------------------------------
;;
;;    Poor: Three or more of the stated criteria are not satisfied.
;;
;;    0 points
;;
;;------------------------------------------------------------------------------
;;
;;    Fair: Two of the stated criteria are not satisfied.
;;
;;    2 points
;;
;;------------------------------------------------------------------------------
;;
;;    Good: One of the stated criteria is not satisfied.
;;
;;    3 points
;;
;;------------------------------------------------------------------------------
;;
;;    Excellent: All the stated criteria are satisfied.
;;
;;    5 points
;;
;;------------------------------------------------------------------------------
;;
;; SCORE: Good, 3pts
;;
;; COMMENTS:
;;
;; Solving where "larger" is defined as IMAGE1 having both greater width AND
;; height.
;;
;; Let's take a look at a table -- based on the one from the evaluation tutorial
;; video -- which sets out a pass/fail matrix for different conditions:
;;
;;                            HEIGHT
;;         ---------------------------------------------
;;        | <=> | <         | =             | >         |
;;        |-----+-----------+---------------+-----------|
;;        |  <  | false     | false: T3     | false     |
;; WIDTH  |  =  | false     | false: T2     | false: T4 |
;;        |  >  | false: T6 | false: T1, T5 | true: T7  |
;;
;; The thing to note here is that there are 3 conditions which are not tested.
;; Here's one way of building those up:

(define IMG2-WIDTH 20)
(define IMG2-HEIGHT 20)
(define IMG2 (rectangle IMG2-WIDTH IMG2-HEIGHT 'solid 'red))

(define IMG1-SMALLER_W-SMALLER_H
  (rectangle (- IMG2-WIDTH  10)
             (- IMG2-HEIGHT 10)
             'solid
             'black))

(define IMG1-EQUAL_W-SMALLER_H
  (rectangle IMG2-WIDTH
             (- IMG2-HEIGHT 10)
             'solid
             'black))

(define IMG1-SMALLER_W-BIGGER_HEIGHT
  (rectangle (- IMG2-WIDTH  10)
             (+ IMG2-HEIGHT 10)
             'solid
             'black))

(check-expect (is-image1-larger? IMG1-SMALLER_W-SMALLER_H     IMG2) #f)
(check-expect (is-image1-larger? IMG1-EQUAL_W-SMALLER_H       IMG2) #f)
(check-expect (is-image1-larger? IMG1-SMALLER_W-BIGGER_HEIGHT IMG2) #f)

;;==============================================================================
;;
;; 4. The function design should satisfy the problem statement. If there is any
;;    ambiguity in the problem statement the function design should identify and
;;    resolve that ambiguity.
;;
;;------------------------------------------------------------------------------
;;
;;    Poor: The design does not satisfy the problem statement.
;;
;;    0 points
;;
;;------------------------------------------------------------------------------
;;
;;    Fair: The design satisfies the problem statement, but is incomplete and/or
;;          ambiguities in the problem statement are not resolved.
;;
;;    1 points
;;
;;------------------------------------------------------------------------------
;;
;;    Good: All ambiguities are resolved and the resulting design satisfies the
;;          problem statement.
;;
;;    2 points
;;
;;------------------------------------------------------------------------------
;;
;; SCORE: Fair, 1pt
;;
;; COMMENTS:
;;
;; The function definition meets the requirements for producing True if, and
;; only if IMAGE1 is larger than IMAGE2, where the definition of "larger" is
;; that IMAGE1 is greater than IMAGE2 in both width and height. However, to
;; determine what is meant by "larger" I have to actually read the code --
;; there's nothing in the purpose or the function name that immediately point
;; out this specific interpretation of "larger".
;;
;;==============================================================================
;;
;; TOTAL POINTS: 11 out of 14
;;
;; | Rubric # | Rcv | Max |
;; |----------+-----+-----|
;; |        1 |   2 |   2 |
;; |        2 |   5 |   5 |
;; |        3 |   3 |   5 |
;; |        4 |   1 |   2 |
;; |----------+-----+-----|
;; |          |  11 |  14 |
;;
;;==============================================================================
;;
;; REVIEWER NOTES
;;
;; Other than the two things noted above you did a good job. Everything was
;; clear and coherent, and function is correct for the definition of "larger"
;; that was used, and it should be said that this definition of "larger" seems
;; to be the one expected by the class materials. Let's go a little further,
;; though, and see whether this definition might produce some counter-intuitive
;; outcomes.
;;
;; Consider the following where IMG-AREA-1000000 has a total area of 1,000,000
;; and IMG-AREA-10 has a total area of 10. Which is larger? According to our
;; working definition of "larger" IMG-AREA-1000000 is NOT larger than
;; IMG-AREA-10. is-image1-larger? rightly produces False:

(define IMG-AREA-1000000 (rectangle  1  1000000 'solid 'black))
(define IMG-AREA-10      (rectangle 10        1 'solid 'red))

;; Image -> Number
;; Given an image, produce the image's total area

(check-expect (image-area IMG-AREA-1000000) 1000000)
(check-expect (image-area IMG-AREA-10)           10)

(define (image-area img)
  (* (image-width img) (image-height img)))

;; And let's confirm that IMG-AREA-1000000 is, in fact NOT "larger" than
;; IMG-AREA-10

(check-expect (is-image1-larger? IMG-AREA-1000000 IMG-AREA-10) #f)

;; Is this okay? Yes. It's fine so long as we really are wanting to determine
;; whether IMG1 is larger than IMG2 in both width and height. Is it practical?
;; Maybe. It's certainly possible that this would be a useful comparison for
;; some particular use case. On the other hand, comparing the area of two
;; rectangles is very frequently useful. (Note that all raster images are
;; rectangles, no matter what the notion of visible shape, since an image is
;; always a rectangular matrix of pixels, even where many of the pixels are
;; transparent. You probably already know this, but I don't want to assume.)
;;
;; I think if I really needed a function which determined whether an image was
;; larger in both width and height, I would probably make it *very* explicitly
;; the point of the function:

#;
(define (image-wider-and-taller? img1 img2)
  (and (> (image-width img1)
          (image-width img2))
       (> (image-height img1)
          (image-height img2))))

;; Actually, I'm more likely to compose it, because I think I'm likely to use
;; image-wider? and image-taller? on their own far more frequently than I would
;; use image-wider-and-taller? Plus, doesn't image-wider-and-taller actually do
;; TWO things instead of our ideal of each function doing ONE thing?
;;
;; As a side-note, I probably wouldn't go to all the effort of lining everything
;; up as I have below, but you never know. If doing so benefits comprehension I
;; just might. After all, that's why I've done it here, and it has absolute
;; nothing to do with my liking everything neat and tidy. No nothing.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; CONSTANTS FOR TESTING
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Differentiating Units
;;
;; Widths
(define NARROWER-WIDTH (- IMG2-WIDTH 10))
(define WIDER-WIDTH    (+ IMG2-WIDTH 10))

;; Heights
(define SHORTER-HEIGHT (- IMG2-HEIGHT 10))
(define TALLER-HEIGHT  (+ IMG2-HEIGHT 10))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Comparison Images
;;
;; Widths
(define NARROWER             (rectangle NARROWER-WIDTH  IMG2-HEIGHT    'solid 'black))
(define WIDER                (rectangle WIDER-WIDTH     IMG2-HEIGHT    'solid 'black))

;; Heights
(define SHORTER              (rectangle IMG2-WIDTH      SHORTER-HEIGHT 'solid 'black))
(define TALLER               (rectangle IMG2-WIDTH      TALLER-HEIGHT  'solid 'black))

;; Widths and Heights
(define NARROWER-AND-SHORTER (rectangle NARROWER-WIDTH  SHORTER-HEIGHT 'solid 'black))
(define NARROWER-AND-TALLER  (rectangle NARROWER-WIDTH  TALLER-HEIGHT  'solid 'black))
(define WIDER-AND-SHORTER    (rectangle WIDER-WIDTH     SHORTER-HEIGHT 'solid 'black))
(define WIDER-AND-TALLER     (rectangle WIDER-WIDTH     TALLER-HEIGHT  'solid 'black))

;;
;; Let's show that we have all the inputs we need to test our scenarios.
;;
;; Note that you wouldn't normally include this in your code, but it's
;; definitely useful in building up your code.
;;
;;                                             HEIGHT
;;    ----------------------------------------------------------------------------------
;; W | <=> | <                           | =               | >                          |
;; I |-----+-----------------------------+-----------------+----------------------------|
;; D |  <  | false: NARROWER-AND-SHORTER | false: NARROWER | false: NARROWER-AND-TALLER |
;; T |  =  | false: SHORTER              | false: IMG2     | false: TALLER              |
;; H |  >  | false: WIDER-AND-SHORTER    | false: WIDER    | true:  WIDER-AND-TALLER    |
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; FUNCTIONS
;;

;; Image, Image -> Boolean
;; Produce True if img1 is wider than img2, otherwise produce False

(check-expect (image-wider? WIDER    IMG2) #t)
(check-expect (image-wider? NARROWER IMG2) #f)
(check-expect (image-wider? IMG2     IMG2) #f)

(define (image-wider? img1 img2)
  (> (image-width img1)
     (image-width img2)))


;; Image, Image -> Boolean
;; Produce True if img1 is taller than img2, otherwise produce False

(check-expect (image-taller? TALLER  IMG2) #t)
(check-expect (image-taller? SHORTER IMG2) #f)
(check-expect (image-taller? IMG2    IMG2) #f)

(define (image-taller? img1 img2)
  (> (image-height img1)
     (image-height img2)))


;; Image, Image -> Boolean
;; Produce True if img1 is taller and wider than img2, otherwise produce False

(check-expect (image-wider-and-taller? IMG2                 IMG2) #f)
(check-expect (image-wider-and-taller? SHORTER              IMG2) #f)
(check-expect (image-wider-and-taller? TALLER               IMG2) #f)
(check-expect (image-wider-and-taller? NARROWER             IMG2) #f)
(check-expect (image-wider-and-taller? WIDER                IMG2) #f)
(check-expect (image-wider-and-taller? NARROWER-AND-SHORTER IMG2) #f)
(check-expect (image-wider-and-taller? NARROWER-AND-TALLER  IMG2) #f)
(check-expect (image-wider-and-taller? WIDER-AND-SHORTER    IMG2) #f)
(check-expect (image-wider-and-taller? WIDER-AND-TALLER     IMG2) #t)

(define (image-wider-and-taller? img1 img2)
  (and (image-wider?  img1 img2)
       (image-taller? img1 img2)))

;; Note that image-wider? and image-taller? each do ONE thing. If you think
;; about it, image-wider-and-taller? now only does one thing, too: it calls on
;; image-wider? and image-taller? in order to test that they both return True
;; with the given images. We could have called the function
;; image-wider?-and-image-taller? which draws the focus to the fact that it's
;; this AND which is the ONE thing that the function is actually doing.
;;
;; The point of all of this is to really draw out and make as explicit as
;; possible what it is we are trying to do, and track all the variations in our
;; testing.
;;
;; So here's a question for you: do we really need these tests?
;;
;; (check-expect (image-wider-and-taller? IMG2                 IMG2) #f)
;; (check-expect (image-wider-and-taller? SHORTER              IMG2) #f)
;; (check-expect (image-wider-and-taller? TALLER               IMG2) #f)
;; (check-expect (image-wider-and-taller? NARROWER             IMG2) #f)
;; (check-expect (image-wider-and-taller? WIDER                IMG2) #f)
;;
;; Ask yourself what they achieve that isn't covered by the other tests? Do they
;; test logic or data that hasn't already been tested or are they a redundancy?
;; If they are a redundancy, is there any value to them? If so, what value?
