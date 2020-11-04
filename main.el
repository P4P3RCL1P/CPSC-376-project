;;;; CPSC 376 Pathfinding Algorithm
;;;; David Gillette & Adam Schultz
;;;; 9/20/2020
(defconst ROWS 15 "Number of rows in maze")        ;should by dynamically set based on user input
(defconst COLUMNS 15 "Number of columns in maze")  ;but for testing purposes we will stick to a static value
(defvar *totalCells*) 
(setf totalCells (* ROWS COLUMNS))
(defvar maze1)
(setf maze1 "maze.txt")
(defvar maze2)
(setf maze2 "maze2.txt")
(defvar maze3)
(setf maze3 "maze3.txt")
;;;;list of a 15x15 maze utilizing a vector of a vector. Elisp does not support multidimensional arrays

(require 'ido)
(require 'cl-lib)
(load "cl-extra")
;;macgyvered method of having 2d arrays because elisp did not build them into their language design.
(defun file-to-matrix (filename)
  (with-temp-buffer
    (insert-file-contents filename)
    (let ((list '()))  ;define list to store a list of a list. This will help make up for the lack of support of 2d arrays and matrices
      (while (not (eobp))   ;similar to eof in c++. Searches for end of the accessible portion of text or end of the buffer
        (let ((beg (point)))
          (move-end-of-line nil)   ;;set new line if text has a nil (null) value while reading in the file sets distinct rows
          (push (split-string (buffer-substring beg (point)) " ") list)
          (forward-char)))
      (nreverse list))))
(setq mazy (list 
  '(x x x x x)
  '(x 0 0 x x)
  '(x x x x x)
  '(x x x x x)
  '(x x x x x)
))
(defun iterateMaze (mazeList)    
(with-temp-buffer
(insert-file-contents "maze.txt" nil 0 500)
  (if (eq (point) "o")
   (goto-char (point)))
  )
)



;;THIS IS DONE AND WORKS!!!!
(defun printMaze (mazer)
  (progn 
    (princ (car mazer))
    (terpri))
  (if (cdr mazer)    
    (printMaze 
      (cdr mazer))
  )
)


(defun startMaze (userMaze)
    (message "Here is your maze:")
      (with-temp-buffer  
      (defvar maze)
      (setf maze(insert-file-contents "maze.txt" nil 0 500))
      (defvar mazeList)
      (setf mazeList(file-to-matrix userMaze)))
      (printMaze mazeList)
      ;;(file-to-array mazeList)
      ;;parse through 1d array for starting point
      ;;(startPos mazeList)
      ;;iterate through maze
      ;;call ruleset for moving through maze
      ;;cannot move to O
      ;;move forward
      ;;if can't move forward move right
      ;;if can't move forward move left
      ;;recursively call previous actions if they worked in the previous iteration
      ;;update maze file until program reaches o
      )
(defun pickMaze()
  (interactive)
  (message "Choose the maze you would like to see (1, 2, or 3)")
  (cl-case (read-char)
    (?1 (startMaze maze))
    (?2 (startMaze maze2))
    (?3 (startMaze maze3))
    (t (message "invalid input")))
)
(defun initializeMaze ()
  (interactive)
  (message (read-string "Enter your name:"))
  
  (if (y-or-n-p "Would you like to solve a maze?")
    (progn
      (pickMaze)
    )
  (progn
    (message "Too bad, see you next time!")
   )
  )
 )



;;binding keys
(defun bindKeys () (
  (global-set-key (w) 'up)
  (global-set-key (a) 'left)
  (global-set-key (s) 'down)
  (global-set-key (d) 'right)
 )
)
;;unbinding keys (if needed)


;;functions to move up. down. left and right inside the maze.
(defun down (pos) (
  (if (equals (bigMaze1((+ pos ROWS))) 0)
      nil   ;;then part
    (+ pos ROWS) ;;else part
    )
  )
)

(defun up (pos) (
  (if (equals (bigMaze1((- pos ROWS))) 0)
      nil   ;;then part
    (- pos ROWS) ;;else part
   )
  )  
)

(defun left (pos) (
  (if (equals (bigMaze1((- pos 1))) 0)
      nil   ;;then part
    (- pos 1) ;;else part
    )
  )  
)

(defun right (pos) (
  (if (equals (bigMaze1((+ pos 1))) 0)
      nil   ;;then part
    (+ pos 1) ;;else part
    )
  )  
)


;;not 100% if these work but I am done for tonight lol
;;*NEW* this method fills an 1d array (vector) with the contents of a given file
(defun file-to-array (file)
  (with-temp-buffer
    ;;idk if this works.
     (setq tempList (cl-loop for x in (insert-file-contents file) collect x))
      (setq totalCells (length 'tempList))
      (nreverse tempList)
    (setq finalArray (make-vector totalCells tempList))))


 ;;*NEW* 11/2 this method finds the starting position of a 1d array passed in a param.
 (defun startPos (maze)
   ;;the first x in the maze is the sstarting pos.
   (progn
   (cl-loop for x from 0 to (symbol-value totalCells)
 	   (setf startPos x)
	   until (char-equal (aref maze x) 'x')
 	   )
   ))

 ;;*NEW* 11/2 this method finds the rows and columns of a 1d square array
 (defun findRowCol (maze)
   (progn
   (setq sqSize (isqrt totalCells))
   (setf ROWS sqSize)
   (setf COLS sqSize))
  )
     