;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 4.7-traffic_lights) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

#|

Animation of a finite state machine dressed up like a traffic light.

Problem 59: https://htdp.org/2019-02-24/part_one.html#%28part._sec~3aworlds-more%29

Run the program then evaluate the following to begin the animation:

    (main 'red)

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

(define WIDTH 200)
(define HEIGHT (* 2/5 WIDTH))
(define X-CENTER (/ WIDTH 2))
(define Y-CENTER (/ HEIGHT 2))

(define BULB-SIZE (* 1/3 HEIGHT))
(define BULB-FRAME-SIZE (* 1.05 BULB-SIZE))
(define BULB-ON 255)
(define BULB-OFF 50)
(define SEP (square (* 0.3 BULB-SIZE) 0 'transparent))

(define SCENE (empty-scene WIDTH HEIGHT 'SlateGray))

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


;; A TrafficLight is one of the following Strings:
;; – 'red
;; – 'green
;; – 'yellow
;; interp. the three strings represent the three possible states that a traffic
;; light may assume
#;
(define (fn-for-TrafficLight tl)
  (cond
    [(symbol=? tl 'red) ...]
    [(symbol=? tl 'green) ...]
    [(symbol=? tl 'yellow) ...]))

;; BulbState is one of:
;; - #t
;; - #f
;; interp. #t for on, #f for off

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

;; TrafficLight -> TrafficLight
;; Given a TrafficLight, advance to the next TrafficLight
(check-expect (tl-next 'red) 'green)
(check-expect (tl-next 'green) 'yellow)
(check-expect (tl-next 'yellow) 'red)

(define (tl-next tl)
  (cond
    [(symbol=? tl 'red) 'green]
    [(symbol=? tl 'green) 'yellow]
    [(symbol=? tl 'yellow) 'red]))

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

;; TrafficLight -> Image
;; Render the traffic light
(check-expect (tl-render 'red) (place-image (bulb-array 'red) X-CENTER Y-CENTER SCENE))
(check-expect (tl-render 'yellow) (place-image (bulb-array 'yellow) X-CENTER Y-CENTER SCENE))
(check-expect (tl-render 'green) (place-image (bulb-array 'green) X-CENTER Y-CENTER SCENE))

(define (tl-render tl)
  (place-image (bulb-array tl) X-CENTER Y-CENTER SCENE))

;; TrafficLight -> Image
;; Render a bulb array
(define (bulb-array tl)
  (cond
    [(symbol=? tl 'red)
     (beside (bulb 'red #t) SEP (bulb 'yellow #f) SEP (bulb 'green #f))]
    [(symbol=? tl 'yellow)
     (beside (bulb 'red #f) SEP (bulb 'yellow #t) SEP (bulb 'green #f))]
    [(symbol=? tl 'green)
     (beside (bulb 'red #f) SEP (bulb 'yellow #f) SEP (bulb 'green #t))]))

;; Color BulbState -> Image
;; Produce a traffic bulb image.
(check-expect (bulb 'green  #t) (bulb+frame (circle BULB-SIZE BULB-ON  'green)  'green))
(check-expect (bulb 'yellow #f) (bulb+frame (circle BULB-SIZE BULB-OFF 'yellow) 'yellow))

(define (bulb color state)
  (if state
      (bulb+frame (circle BULB-SIZE BULB-ON color) color)
      (bulb+frame (circle BULB-SIZE BULB-OFF color) color)))

;; Image Color -> Image
;; Given a bulb image and a color, produce a bulb with frame
(define (bulb+frame img color)
  (overlay img
           (circle BULB-SIZE 'solid 'DarkGray)
           (circle BULB-FRAME-SIZE 'solid color)))

;
;
;
;   ███  ███    ▒██▒     ██████   ███   ██
;   ███  ███    ▓██▓     ██████   ███   ██
;   ███▒▒███    ████       ██     ███▒  ██
;   ███▓▓███    ████       ██     ████  ██
;   ██▓██▓██   ▒█▓▓█▒      ██     ██▒█▒ ██
;   ██▒██▒██   ▓█▒▒█▓      ██     ██ ██ ██
;   ██░██░██   ██  ██      ██     ██ ██ ██
;   ██ ██ ██   ██████      ██     ██ ▒█▒██
;   ██    ██  ░██████░     ██     ██  ████
;   ██    ██  ▒██  ██▒     ██     ██  ▒███
;   ██    ██  ███  ███   ██████   ██   ███
;   ██    ██  ██▒  ▒██   ██████   ██   ███
;
;
;
;

(define (main tl)
  (big-bang tl
            [to-draw tl-render]
            [on-tick tl-next 1]))
