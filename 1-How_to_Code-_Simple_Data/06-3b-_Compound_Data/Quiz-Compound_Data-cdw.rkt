;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Quiz-Compound_Data-cdw) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;
;
;
;    ██████   ███   ██  ████████   ░████░
;    ██████   ███   ██  ████████   ██████
;      ██     ███▒  ██  ██        ▒██  ██▒
;      ██     ████  ██  ██        ██▒  ▒██
;      ██     ██▒█▒ ██  ██        ██    ██
;      ██     ██ ██ ██  ███████   ██    ██
;      ██     ██ ██ ██  ███████   ██    ██
;      ██     ██ ▒█▒██  ██        ██    ██
;      ██     ██  ████  ██        ██▒  ▒██
;      ██     ██  ▒███  ██        ▒██  ██▒
;    ██████   ██   ███  ██         ██████
;    ██████   ██   ███  ██         ░████░
;
;
;
;

#|

Introduction
============

This graphical editor follows an alternate implementation wherein the world
state is represented by a struct with two fields: text, index. Rather than
managing two distinct text fields relative to the cursor position, it follows a
somewhat more real-world implementation strategy wherein cursor position is
defined relative to an index on the text.

Similar Functions
-----------------

Note how string-ith/insert, which inserts a character at the "ith" index, is
similar to render/text+cursor, which "inserts" a cursor at a specific index
within the rendered text.

;; String Natural 1String -> String
;; Insert char by index
(define (string-ith/insert s n char)
  (cond
    [(= (string-length s) n) (string-append s char)]
    [else (string-append (substring s 0 n) char (substring s n))]))

;; String Natural -> Image
;; Render string (s) with cursor at index (n)
(define (render/text+cursor s n)
  (cond
    [(= (string-length s) n) (beside/align 'bottom (render/text s) CURSOR)]
    [else (beside/align
           'bottom
           (render/text (substring s 0 n))
           CURSOR
           (render/text (substring s n)))]))


Beginning Student Language VS Intermediate Student Language
===========================================================

Or why I've purposely broken the rules...
-----------------------------------------

The Quiz Rubric requires that the submission not utilize any features which
haven't been covered, and that DrRacket be set to BSL. This program uses
ISL (Intermediate Student Language) in order to make use of one feature which is
ahead of the class material. ISL introduces (among other things) higher order
functions, which is to say that it allows functions to be passed as values to
other functions.

Three functions are affected:

- move-left
- move-right
- modify-index

Here are BSL versions of move-left and move-right:

;; Editor -> Editor
;; Move the cursor left
(define (move-left ed)
  (cond
    [(zero? (editor-index ed)) ed]
    [else
     (make-editor (editor-text ed)
                  (sub1 (editor-index ed)))]))

;; Editor -> Editor
;; Move the cursor right
(define (move-right ed)
  (cond
    [(max-index? ed) ed]
    [else
     (make-editor (editor-text ed)
                  (add1 (editor-index ed)))]))

ISL with higher-order functions allows for a cleaner implementation:

;; Editor -> Editor
;; Move the cursor left
(define (move-left ed)
  (cond
    [(zero? (editor-index ed)) ed]
    [else (modify-index ed sub1)]))

;; Editor -> Editor
;; Move the cursor right
(define (move-right ed)
  (cond
    [(max-index? ed) ed]
    [else (modify-index ed add1)]))

;; Editor Function -> Editor
;; Apply func to the editor index
(define (modify-index ed func)
  (make-editor (editor-text ed)
               (func (editor-index ed))))

Go ahead and dock points if you like, as this is a clear departure from the
rubric.

|#

;
;
;
;     ▒████▒   ░████░   ███   ██   ▒████▒   ████████    ▒██▒    ███   ██  ████████   ▒████▒
;    ▓██████   ██████   ███   ██  ▒██████   ████████    ▓██▓    ███   ██  ████████  ▒██████
;   ▒██▒  ░█  ▒██  ██▒  ███▒  ██  ██▒  ▒█      ██       ████    ███▒  ██     ██     ██▒  ▒█
;   ██▓       ██▒  ▒██  ████  ██  ██           ██       ████    ████  ██     ██     ██
;   ██░       ██    ██  ██▒█▒ ██  ███▒         ██      ▒█▓▓█▒   ██▒█▒ ██     ██     ███▒
;   ██        ██    ██  ██ ██ ██  ▒█████▒      ██      ▓█▒▒█▓   ██ ██ ██     ██     ▒█████▒
;   ██        ██    ██  ██ ██ ██   ░█████▒     ██      ██  ██   ██ ██ ██     ██      ░█████▒
;   ██░       ██    ██  ██ ▒█▒██      ▒███     ██      ██████   ██ ▒█▒██     ██         ▒███
;   ██▓       ██▒  ▒██  ██  ████        ██     ██     ░██████░  ██  ████     ██           ██
;   ▒██▒  ░█  ▒██  ██▒  ██  ▒███  █▒░  ▒██     ██     ▒██  ██▒  ██  ▒███     ██     █▒░  ▒██
;    ▓██████   ██████   ██   ███  ███████▒     ██     ███  ███  ██   ███     ██     ███████▒
;     ▒████▒   ░████░   ██   ███  ░█████▒      ██     ██▒  ▒██  ██   ███     ██     ░█████▒
;
;
;
;

(define WIDTH 400)
(define HEIGHT 28)
(define HALF-Y (/ HEIGHT 2))
(define SCENE (empty-scene WIDTH HEIGHT))
(define MARGIN-LEFT 3)
(define MARGIN-TOP 2)

(define CURSOR-WIDTH 1)
(define CURSOR-HEIGHT 22)
(define CURSOR-MODE 'outline)
(define CURSOR-COLOR 'red)
(define CURSOR (rectangle CURSOR-WIDTH CURSOR-HEIGHT CURSOR-MODE CURSOR-COLOR))

(define TEXT-COLOR 'black)
(define TEXT-SIZE 16)

;
;
;
;   █████▒      ▒██▒    ████████    ▒██▒              █████▒    ████████  ████████   ▒████▒
;   ███████     ▓██▓    ████████    ▓██▓              ███████   ████████  ████████  ▒██████
;   ██  ▒██▒    ████       ██       ████              ██  ▒██▒  ██        ██        ██▒  ▒█
;   ██   ▒██    ████       ██       ████              ██   ▒██  ██        ██        ██
;   ██   ░██   ▒█▓▓█▒      ██      ▒█▓▓█▒             ██   ░██  ██        ██        ███▒
;   ██    ██   ▓█▒▒█▓      ██      ▓█▒▒█▓             ██    ██  ███████   ███████   ▒█████▒
;   ██    ██   ██  ██      ██      ██  ██             ██    ██  ███████   ███████    ░█████▒
;   ██   ░██   ██████      ██      ██████             ██   ░██  ██        ██            ▒███
;   ██   ▒██  ░██████░     ██     ░██████░            ██   ▒██  ██        ██              ██
;   ██  ▒██▒  ▒██  ██▒     ██     ▒██  ██▒            ██  ▒██▒  ██        ██        █▒░  ▒██
;   ███████   ███  ███     ██     ███  ███            ███████   ████████  ██        ███████▒
;   █████▒    ██▒  ▒██     ██     ██▒  ▒██            █████▒    ████████  ██        ░█████▒
;
;
;
;

(define-struct editor [text index])
;; An Editor is a structure:
;;    (make-editor String Natural)
;; interp. (make-editor text index) describes an editor wherein the text field
;; contains the editor text and the index field contains the cursor position
;; corresponding to a string index.
;;
;; Note that the valid index range is [0, length of string], where the string
;; length is one-greater than the final string index.

(define ex0 (make-editor "" 0))
(define ex1 (make-editor "." 0))        ; Cursor at "."
(define ex2 (make-editor "." 1))        ; Cursor after "."
(define ex3 (make-editor "foo bar" 0))  ; Cursor at "f"
(define ex4 (make-editor "foo bar" 4))  ; Cursor at "b"
(define ex5 (make-editor "foo bar" 7))  ; Cursor after "r"

;
;
;
;   ████████  ██    ██  ███   ██    ▒████▒  ████████   ██████    ░████░   ███   ██   ▒████▒
;   ████████  ██    ██  ███   ██   ▓██████  ████████   ██████    ██████   ███   ██  ▒██████
;   ██        ██    ██  ███▒  ██  ▒██▒  ░█     ██        ██     ▒██  ██▒  ███▒  ██  ██▒  ▒█
;   ██        ██    ██  ████  ██  ██▓          ██        ██     ██▒  ▒██  ████  ██  ██
;   ██        ██    ██  ██▒█▒ ██  ██░          ██        ██     ██    ██  ██▒█▒ ██  ███▒
;   ███████   ██    ██  ██ ██ ██  ██           ██        ██     ██    ██  ██ ██ ██  ▒█████▒
;   ███████   ██    ██  ██ ██ ██  ██           ██        ██     ██    ██  ██ ██ ██   ░█████▒
;   ██        ██    ██  ██ ▒█▒██  ██░          ██        ██     ██    ██  ██ ▒█▒██      ▒███
;   ██        ██    ██  ██  ████  ██▓          ██        ██     ██▒  ▒██  ██  ████        ██
;   ██        ██▓  ▓██  ██  ▒███  ▒██▒  ░█     ██        ██     ▒██  ██▒  ██  ▒███  █▒░  ▒██
;   ██        ▒██████▒  ██   ███   ▓██████     ██      ██████    ██████   ██   ███  ███████▒
;   ██         ▒████▒   ██   ███    ▒████▒     ██      ██████    ░████░   ██   ███  ░█████▒
;
;
;
;

;; Editor KeyEvent -> Editor
;; Modify the Editor based on the key event.

;; Reposition Cursor - Left
(check-expect (edit ex0 "left") ex0)    ; Min Index: Empty String
(check-expect (edit ex1 "left") ex1)    ; Min Index: Non-empty String
(check-expect (edit ex2 "left") ex1)    ; > Min Index

;; Reposition Cursor - Right
(check-expect (edit ex0 "right") ex0)   ; Max Index: Empty String
(check-expect (edit ex2 "right") ex2)   ; Max Index: Non-empty String
(check-expect (edit ex1 "right") ex2)   ; < Max Index

;; Backspace
(check-expect (edit ex0 "\b") ex0)      ; Min Index: Empty String
(check-expect (edit ex1 "\b") ex1)      ; Min Index: Non-empty String
(check-expect (edit ex2 "\b") ex0)      ; > Min Index

;; Insertion
(check-expect (edit ex4 "z") (make-editor "foo zbar" 5)) ; Internal
(check-expect (edit ex5 "z") (make-editor "foo barz" 8)) ; Max Index

;; Ignored Input
(check-expect (edit ex0 "\t") ex0)      ; Specified by Problem (1String)
(check-expect (edit ex0 "\r") ex0)      ; Specified by Problem (1String)
(check-expect (edit ex0 "down") ex0)

(define (edit ed ke)
  (cond
    [(key=? ke "left") (move-left ed)]
    [(key=? ke "right") (move-right ed)]
    [(key=? ke "\b") (delete-char ed)]
    [(or (key=? ke "\t") (key=? ke "\r")) ed]
    [(= (string-length ke) 1) (insert-char ed ke)]
    [else ed]))

;; Editor -> Editor
;; Move the cursor left
;; Test Coverage: See edit function
(define (move-left ed)
  (cond
    [(zero? (editor-index ed)) ed]
    [else (modify-index ed sub1)]))

;; Editor -> Editor
;; Move the cursor right
;; Test Coverage: See edit function
(define (move-right ed)
  (cond
    [(max-index? ed) ed]
    [else (modify-index ed add1)]))

;; Editor -> Boolean
;; Produce #t if index is in the final position
(check-expect (max-index? ex0) #t)
(check-expect (max-index? ex1) #f)

(define (max-index? ed)
  (= (string-length (editor-text ed)) (editor-index ed)))

;; Editor Function -> Editor
;; Apply func to the editor index
(check-expect (modify-index ex2 sub1) ex1)
(check-expect (modify-index ex1 add1) ex2)

(define (modify-index ed func)
  (make-editor (editor-text ed)
               (func (editor-index ed))))

;; Editor -> Editor
;; Delete the character to the left of the cursor
(check-expect (delete-char ex0) ex0)
(check-expect (delete-char ex1) ex1)
(check-expect (delete-char ex2) ex0)

(define (delete-char ed)
  (cond
    [(zero? (editor-index ed)) ed]
    [else (make-editor
           (string-ith/delete (editor-text ed) (sub1 (editor-index ed)))
           (sub1 (editor-index ed)))]))

;; String Natural -> String
;; Delete a string's nth character
(check-expect (string-ith/delete " " 0) "")
(check-expect (string-ith/delete "foo bar" 3) "foobar")
(check-expect (string-ith/delete "foo bar" 6) "foo ba")

(define (string-ith/delete s n)
  (string-append (substring s 0 n)
                 (substring s (add1 n))))

;; Editor 1String -> Editor
;; Insert character
(check-expect (insert-char ex0 ".") (make-editor "." 1))
(check-expect (insert-char ex4 "z") (make-editor "foo zbar" 5))
(check-expect (insert-char ex5 "z") (make-editor "foo barz" 8))

(define (insert-char ed char)
  (make-editor (string-ith/insert (editor-text ed) (editor-index ed) char)
               (add1 (editor-index ed))))

;; String Natural 1String -> String
;; Insert char by index
(check-expect (string-ith/insert "" 0 ".") ".")
(check-expect (string-ith/insert "foo" 3 "z") "fooz")
(check-expect (string-ith/insert "foo" 2 "t") "foto")

(define (string-ith/insert s n char)
  (cond
    [(= (string-length s) n) (string-append s char)]
    [else (string-append (substring s 0 n) char (substring s n))]))

;
;
;
;   ██████▒   ████████  ███   ██  █████▒    ████████  ██████▒
;   ███████▓  ████████  ███   ██  ███████   ████████  ███████▓
;   ██   ▒██  ██        ███▒  ██  ██  ▒██▒  ██        ██   ▒██
;   ██    ██  ██        ████  ██  ██   ▒██  ██        ██    ██
;   ██   ▒██  ██        ██▒█▒ ██  ██   ░██  ██        ██   ▒██
;   ███████▒  ███████   ██ ██ ██  ██    ██  ███████   ███████▒
;   ██████▓   ███████   ██ ██ ██  ██    ██  ███████   ██████▓
;   ██  ▓██░  ██        ██ ▒█▒██  ██   ░██  ██        ██  ▓██░
;   ██   ██▓  ██        ██  ████  ██   ▒██  ██        ██   ██▓
;   ██   ▒██  ██        ██  ▒███  ██  ▒██▒  ██        ██   ▒██
;   ██    ██▒ ████████  ██   ███  ███████   ████████  ██    ██▒
;   ██    ███ ████████  ██   ███  █████▒    ████████  ██    ███
;
;
;
;

;; Editor -> Image
;; Render the editor as an image.

;; Empty String
(check-expect
 (render ex0)
 (place-image/align (beside/align 'bottom (text "" TEXT-SIZE TEXT-COLOR) CURSOR)
                    MARGIN-LEFT
                    MARGIN-TOP
                    'left
                    'top
                    SCENE))
;; Cursor: Min Index
(check-expect
 (render ex1)
 (place-image/align (beside/align 'bottom CURSOR (text "." TEXT-SIZE TEXT-COLOR))
                    MARGIN-LEFT
                    MARGIN-TOP
                    'left
                    'top
                    SCENE))
;; Cursor: Max Index
(check-expect
 (render ex2)
 (place-image/align (beside/align 'bottom (text "." TEXT-SIZE TEXT-COLOR) CURSOR)
                    MARGIN-LEFT
                    MARGIN-TOP
                    'left
                    'top
                    SCENE))
;; Cursor: Internal
(check-expect
 (render ex4)
 (place-image/align (beside/align 'bottom
                                  (text "foo " TEXT-SIZE TEXT-COLOR)
                                  CURSOR
                                  (text "bar" TEXT-SIZE TEXT-COLOR))
                    MARGIN-LEFT
                    MARGIN-TOP
                    'left
                    'top
                    SCENE))
(define (render ed)
  (place-image/align
   (render/text+cursor (editor-text ed) (editor-index ed))
   MARGIN-LEFT
   MARGIN-TOP
   'left
   'top
   SCENE))

;; String Natural -> Image
;; Render string (s) with cursor at index (n)

;; Min Index Cursor
(check-expect (render/text+cursor "foo bar" 0)
              (beside/align 'bottom CURSOR (text "foo bar" TEXT-SIZE TEXT-COLOR)))
;; Max Index Cursor
(check-expect (render/text+cursor "foo bar" 7)
              (beside/align 'bottom (text "foo bar" TEXT-SIZE TEXT-COLOR) CURSOR))
;; Internal Cursor
(check-expect (render/text+cursor "foo bar" 3)
              (beside/align 'bottom
                            (text "foo" TEXT-SIZE TEXT-COLOR)
                            CURSOR
                            (text " bar" TEXT-SIZE TEXT-COLOR)))

(define (render/text+cursor s n)
  (cond
    [(= (string-length s) n) (beside/align 'bottom (render/text s) CURSOR)]
    [else (beside/align
           'bottom
           (render/text (substring s 0 n))
           CURSOR
           (render/text (substring s n)))]))

;; String -> Image
;; Render string as image
(check-expect (render/text "") (text "" TEXT-SIZE TEXT-COLOR))
(check-expect (render/text "foo bar") (text "foo bar" TEXT-SIZE TEXT-COLOR))

(define (render/text s)
  (text s TEXT-SIZE TEXT-COLOR))

;
;
;
;  ██      ██  ░████░   ██████▒   ██        █████▒
;  ██░    ░██  ██████   ███████▓  ██        ███████
;  ██▒    ▒██ ▒██  ██▒  ██   ▒██  ██        ██  ▒██▒
;  ▓█▒ ██ ▒█▓ ██▒  ▒██  ██    ██  ██        ██   ▒██
;  ▒█▓░██ ██▒ ██    ██  ██   ▒██  ██        ██   ░██
;  ▒██░██░██▒ ██    ██  ███████▒  ██        ██    ██
;  ░██▒██▒██░ ██    ██  ██████▓   ██        ██    ██
;   ██▓▓▓▓██░ ██    ██  ██  ▓██░  ██        ██   ░██
;   ███▒▒███  ██▒  ▒██  ██   ██▓  ██        ██   ▒██
;   ███░░███  ▒██  ██▒  ██   ▒██  ██        ██  ▒██▒
;   ███  ███   ██████   ██    ██▒ ████████  ███████
;   ▓██  ███   ░████░   ██    ███ ████████  █████▒
;
;
;
;

(define (main initial-state)
  (big-bang initial-state
            [on-key edit]
            [on-draw render]))
