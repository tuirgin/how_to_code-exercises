;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname htdf-design-quiz-01) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
;; SCORE: 2
;;
;; COMMENTS: The file is neat and tidy. STubs and Templates are commented out
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
;; SCORE: 5
;;
;; COMMENTS: All the elements are present.
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
;; SCORE: 0
;;
;; COMMENTS:
;;          1) Signature is not correct: This function accepts two images and produce boolean, so signature should be IMAGE1 IMAGE2 -> boolean
;;          2) Purpose can be expressed more clearly. Else part of the purpose is not defined
;;          3) Function name could be more clear. It does not describe what the function does.
;;          4) Stub matches the Signature. But the template body is not correct. Template body should have Image1 and Image2 in it.
;;          5) Function body is clear and all the test are passed. But the test are not sufficient.
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
;; SCORE: 1
;;
;; COMMENTS:
;;     1) Function body says '>='  it should be just  '>' because if all the sides are same then also the function will generate result as True.
;;==============================================================================
;;
;; REVIEWER NOTES: 
