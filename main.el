;;;; CPSC 376 Pathfinding Algorithm
;;;; David Gillette & Adam Schultz
;;;; 9/20/2020

(defconst ROWS 39 "Number of rows in maze")        ;should by dynamically set based on user input
(defconst COLUMNS 24 "Number of columns in maze")  ;but for testing purposes we will stick to a static value
(defvar *totalCells*) 
(setf totalCells (* ROWS COLUMNS))
;;list of a 15x15 maze
(setq bigMaze1 '(
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
0 x 0 x x x x x x x 0 0 0 0 0 
0 x x x 0 0 x 0 0 x x x 0 0 0 
0 0 0 x x 0 x 0 0 0 0 x 0 0 0 
0 x x x 0 0 x x x x x x x x 0 
0 0 x 0 0 0 0 0 x 0 x 0 0 x 0 
0 0 0 0 0 0 x x x x x 0 0 x 0 
0 0 0 0 0 x x 0 0 x 0 0 x x 0 
0 0 x x x x 0 0 x x 0 x x 0 0 
0 x x 0 0 x x x 0 x 0 0 x x 0 
0 0 0 0 0 0 0 x 0 0 0 0 x 0 0 
0 0 0 0 0 0 x x 0 0 x x x 0 0 
0 0 0 0 0 0 x 0 0 0 x 0 0 0 0 
0 0 0 0 0 x x x 0 x x 0 0 0 0 
0 0 0 0 0 0 0 X 0 X 0 0 0 0 0 
))

(defun printMaze()
;;loop starts at 1 not 0
(setq upper (+ (* 15 15) 1))
(loop for i from 0 below upper do
  (if (= (mod 15 i) 0))
    (message "")
  )
  (message bigMaze1(i))
  ;;im in the call if youre done with your call
    
))

;; Maze in buffer is being formatted incorrectly. Perhaps this is in part because you can adjust the size of the buffer. Look into way for making output of function set to a fixed size rather than dynamically changing. May be more useful to use xs and dashes instead of formating a maze in unicode.;; 

(defun startMaze ())

(defun initializeMaze ()
  (interactive)
  (message "Welcome %s !" (read-string "Enter your name:"))
  
  (if (y-or-n-p "Would you like to solve a maze?")
    (progn
      (startMaze)
    )
  (progn
    (message "Too bad, see you next time!")
  )
  ))




;;binding keys
(def bindKeys () (
  (global-set-key (w) 'up)
  (global-set-key (a) 'left)
  (global-set-key (s) 'down)
  (global-set-key (d) 'right)
)

;;unbinding keys (if needed)


;;functions to move up. down. left and right inside the maze.
(defun down (pos) (
 ;;moves the user down in the list if they can
)

(defun up (pos) (
;;moves theuser up if they can
)

(defun left (pos) (
;; moves the user left if they can
)

(defun right (pos) (
;;moves the user right if they can
) 

(defq maze1Rows 6)
(defq maze1Cols 6)








     
|# all below is commented out
#####0--####
#####-#-####
#####-#-####
#####------X


;; This is an array ;;
(defparameter *my-array* ( make-array '(5 5) :initial-element 'W'))

* (destructuring-bind (n m) (array-dimensions a)
    (loop for i from 0 below 5 do 
      (loop for j from 0 below 5 do 
        my-array[i j] = 'X'
      )
    )
  )


;;other way we will prob do it;;



0 0 0 0 0 0
0 x 0 x x 0
0 x x x 0 0
0 0 0 x x 0
0 x x x 0 0
0 0 x 0 0 0 

* (defparameter 2dArray #2A(X X W X X) (X X W X X) (X X W X X) (X X W X X) (X X W X X)))

#|