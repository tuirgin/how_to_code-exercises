;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname htdd-design_quiz-01-sasmita-code_review) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDD Design Quiz

;; Age is Natural
;; interp. the age of a person in years
(define A0 18)
(define A1 25)

#;
(define (fn-for-age a)
  (... a))

;; Template rules used:
;; - atomic non-distinct: Natural


; Problem 1:
;
; Consider the above data definition for the age of a person.
;
; Design a function called teenager? that determines whether a person
; of a particular age is a teenager (i.e., between the ages of 13 and 19).


;; Ages -> Boolean
;; Consumes person's age and determines whether the person is teenager

(check-expect (teenager? 12) false)
(check-expect (teenager? 13) true)
(check-expect (teenager? 16) true)
(check-expect (teenager? 19) true)
(check-expect (teenager? 20) false)

;(define (teenager? a) true)     ; Stub

;(define (teenager? a)           ; Template
;  (...a))


(define (teenager? a)
  (and (>= a 13) (<= a 19)))



; Problem 2:
;
; Design a data definition called MonthAge to represent a person's age
; in months.


;; MonthAge is Natural
;; interp. Person's age in months

(define MA1 1)
(define MA2 500)

#;
(define (fn-for-MonthAge a)
  (...a))

;; Template rules used:
;;  - atomic non-distinct: Natural


; Problem 3:
;
; Design a function called months-old that takes a person's age in years
; and yields that person's age in months.
;


;; Interger -> MonthAge
;; Consumes person's age in years and produce person's age in months.

(check-expect (months-old 2) 24)
(check-expect (months-old 0) 0)
(check-expect (months-old 20) 240)


;(define (months-old y) 24)       ; Stub

;(define (months-old y)           ; Template
;  (...y))


(define (months-old y)
  (* y 12))


; Problem 4:
;
; Consider a video game where you need to represent the health of your
; character. The only thing that matters about their health is:
;
;   - if they are dead (which is shockingly poor health)
;   - if they are alive then they can have 0 or more extra lives
;
; Design a data definition called Health to represent the health of your
; character.
;
; Design a function called increase-health that allows you to increase the
; lives of a character.  The function should only increase the lives
; of the character if the character is not dead, otherwise the character
; remains dead.



;; Health is one of:
;;  - dead
;;  - Natural
;; interp. dead means no lives, Interger means have extra lives

(define H1 "dead")
(define H2 2)

#;
(define (fn-for-Health h)
  (cond [(number? h) (...)]
        [else "dead"]))

;; Template rules used:
;;  - one of: 2 cases
;;  - atomic distinct: dead
;;  - atomic non-distinct: Integer

;; Health -> Health
;; Consumes character Health and increase health by 1 if not dead

(check-expect (increase-health 2) 3)
(check-expect (increase-health "dead") "dead")

;(define (increase-health h) 2)    ; Stub

; <template from Health>

(define (increase-health h)
  (cond [(number? h) (+ h 1)]
        [else "dead"]))



;; RUBRIC BASED EVALUATION
;;
;; 1. The program file should be set to beginning student language and there
;;    should be no require declarations.
;;
;;------------------------------------------------------------------------------
;;
;;    Unacceptable: There are require declarations, or the file is set to
;;                  something other than Beginning Student Language.
;;
;;    0 points
;;
;;------------------------------------------------------------------------------
;;
;;    Acceptable: The file is set to BSL, and there are no require declarations.
;;
;;    1 point
;;
;;------------------------------------------------------------------------------
;;
;; SCORE: Acceptable, 1 point
;;
;; COMMENTS:
;;
;;
;;==============================================================================
;;
;; 2. The file should be neat and tidy, no tests or code should be commented out
;;    other than stubs and templates and all scratch work should be removed.
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
;;    1 point
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
;; SCORE: Good, 2 points
;;
;; COMMENTS:
;;
;;==============================================================================
;;
;; 3. All HtDF and HtDD design elements should be present, and each element
;;    should be well formed.
;;
;;------------------------------------------------------------------------------
;;
;;    Poor: Two or more of the HtDF or HtDD design elements are missing or
;;          poorly formed.
;;
;;    0 points
;;
;;------------------------------------------------------------------------------
;;
;;    Fair: One HtDF or HtDD design element is missing or poorly formed.
;;
;;    3 points
;;
;;------------------------------------------------------------------------------
;;
;;    Good: All HtDF and HtDD design elements are present and well-formed.
;;
;;    5 points
;;
;;------------------------------------------------------------------------------
;;
;; SCORE: Fair, 3 points
;;
;; COMMENTS:
;;
;;     For templates, an ellipsis is a valid atom, and when preceded and/or
;;     followed by a variable (or another atom) must be separated by a space.
;;     You can check this by uncommenting the template and running the program.
;;     DrRacket understands that these are placeholders and will pass if they
;;     are well-formed or fail if there's a problem.
;;
;;     See lines 39, 61, and 85.
;;
;;     This:
       #;
       (define (teenager? a)            ; Template
         (... a))
;;
;;     versus this:
       #;
       (define (teenager? a)           ; Template
         (...a))
;;
;;
;;==============================================================================
;;
;; 4.1 For data definitions, the type comments should be correct, and the
;;     interpretations should be clear and complete.
;;
;; 4.2 The examples should cover all cases, and the template should be complete
;;     with the correct template rules used.
;;
;; 4.3 For function designs, the signature should be correct, the purpose should
;;     be clear and succinct, the examples should be sufficient to test and
;;     explain the function. The function name should be well chosen and should
;;     describe what the function does, not how it does it.
;;
;; 4.4 The stub should match the signature.
;;
;; 4.5 The template should be correct.
;;
;; 4.6 The function body should be clear.
;;
;; 4.7 When the program is run all the tests should pass, and those tests should
;;     cover the entire program.
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
;;    Excellent: All of the stated criteria are satisfied.
;;
;;    5 points
;;
;;------------------------------------------------------------------------------
;;
;; SCORE: Good, 3 points
;;
;; COMMENTS:
;;
;;    Be careful of the inconsistencies between the type statement of a data
;;    definition and actual use. Your data definition for health was as follows:
;;
;;        Health is one of:
;;        - dead
;;        - Natural
;;        interp. dead means no lives, Integer means have extra lives
;;
;;    There are two inconsistencies here, one within the data definition,
;;    itself, and one between the data definition and its use in a function:
;;
;;    1) The atomic value of "dead".
;;
;;       For Problem 4, I think it feels more natural and idiomatic that the
;;       "dead" case be represented by #f, but I don't think we've seen enough
;;       of it at this stage of the class to really make it the obvious choice,
;;       and the point subtraction wasn't for that design choice.
;;
;;       Instead, what I think is really relevant about it is the fact that the
;;       data definition uses the unquoted "dead" as an atomic value, while the
;;       template and increase-health function use the quoted "dead". When
;;       quoted, either as 'dead (a symbol) or "dead" (a string), this is a
;;       valid atomic value. When unquoted BSL will assume that it is a variable
;;       and try to reduce it to its referenced value, and when it cannot it
;;       will raise an error:
;;
;;           dead: this variable is not defined
;;
;;       The immediate correction would be:
;;
;;           Health is one of:
;;           - "dead"
;;           - Natural
;;           interp. "dead" means no lives, Integer means have extra lives
;;
;;       But again, as you will see in future lectures, the more natural design
;;       is for Health to be one of #f or Natural.
;;
;;       You probably actually ran into this already, as in your template and
;;       function design you do actually use the quoted form of "dead", which
;;       makes your definition use inconsistent with the template and function
;;       designs. See Enumerations within the the HtDD recipes and note that
;;       each of the "one of" cases is represented as a sting:
;;       https://bit.ly/2W3vNkY
;;
;;    2) The atomic class Natural vs the atomic class Integer
;;
;;       Your enumeration classes include "Natural" while your interpretation
;;       references the Integer class of data. Your function definition which
;;       consumes Health also references Integer. Natural is actually a
;;       sub-class of Integer: an Integer is simply any whole number within an
;;       infinite range of positive or negative values, while a Natural is
;;       simply a non-negative integer.
;;
;;       As Integer and Natural are both valid sub-classes of Number, which is
;;       the appropriate choice for the design?
;;
;;==============================================================================
;;
;; 5. The function and data designs should satisfy the problem statements. If
;;    there is any ambiguity in the problem statements the function and data
;;    design should identify and resolve those ambiguities.
;;
;;------------------------------------------------------------------------------
;;
;;    Poor: The design does not satisfy the problem statements.
;;
;;    0 points
;;
;;------------------------------------------------------------------------------
;;
;;    Fair: The design satisfies the problem statements, but is incomplete
;;          and/or ambiguities in the problem statements are not resolved.
;;
;;    1 point
;;
;;------------------------------------------------------------------------------
;;
;;    Good: All ambiguities are resolved and the resulting design satisfies the
;;          problem statements.
;;
;;    2 points
;;
;;------------------------------------------------------------------------------
;;
;; SCORE: Good, 2 points
;;
;; COMMENTS:
;;
;;
;;==============================================================================
;;
;; What aspects of this response stood out to you? What did it do well? How
;; could it improve?
;;
;;------------------------------------------------------------------------------
;;
;; COMMENTS:
;;
;;     Your solutions to the problems show you have a good understanding of the
;;     material. From my perspective the point subtractions were simply a matter
;;     of clarifying some minor details. You're doing good work and we're now
;;     starting to get into the real content of the class. I hope you enjoy it
;;     and find it valuable.
;;
;;==============================================================================
;;
;; TOTAL SCORE: 11 points out of 15 possible
;;
;;==============================================================================
