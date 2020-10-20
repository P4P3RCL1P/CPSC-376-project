;;;; CPSC 376 Pathfinding Algorithm
;;;; David Gillette & Adam Schultz
;;;; 9/20/2020

(defconst ROWS 15 "Number of rows in maze")        ;should by dynamically set based on user input
(defconst COLUMNS 15 "Number of columns in maze")  ;but for testing purposes we will stick to a static value
(defvar *totalCells*) 
(setf totalCells (* ROWS COLUMNS))
;;list of a 15x15 maze
(setq m-array (make-vector 15 nil))
(dotimes (i 15)
  (setf (aref m-array i) (make-vector 15 0)))
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
0 0 0 0 0 0 0 X 0 o 0 0 0 0 0 
)) 

(defun file-to-matrix (filename)
  (with-temp-buffer
    (insert-file-contents filename)
    (let ((list '()))
      (while (not (eobp))   ;similar to eof in c++. Searches for end of the accessible portion of text
        (let ((beg (point)))
          (move-end-of-line nil)   ;set new line if text has a nil (null) value while reading in the file (sets distinct rows)
          (push (split-string (buffer-substring beg (point)) " ") list)
          (forward-char)))
      (nreverse list))))


;; Maze in buffer is being formatted incorrectly. Perhaps this is in part because you can adjust the size of the buffer. Look into way for making output of function set to a fixed size rather than dynamically changing. May be more useful to use xs and dashes instead of formating a maze in unicode.;; 

(defun startMaze ()
  (message "Here is your maze:")
  (find-file "maze")
  
 
 )

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
(defun bindKeys () (
  (global-set-key (w) 'up)
  (global-set-key (a) 'left)
  (global-set-key (s) 'down)
  (global-set-key (d) 'right)
)

;;unbinding keys (if needed)


;;functions to move up. down. left and right inside the maze.
(defun down (pos) (
  (if (equals (bigMaze1((+ pos ROWS))) 0)
      nil   ;;then part
    (+ pos ROWS) ;;else part
  )
)

(defun up (pos) (
  (if (equals (bigMaze1((- pos ROWS))) 0)
      nil   ;;then part
    (- pos ROWS) ;;else part
  )  
)

(defun left (pos) (
  (if (equals (bigMaze1((- pos 1))) 0)
      nil   ;;then part
    (- pos 1) ;;else part
  )  
)

(defun right (pos) (
  (if (equals (bigMaze1((+ pos 1))) 0)
      nil   ;;then part
    (+ pos 1) ;;else part
  )  
)


     
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