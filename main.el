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

;;added mazes in the forms of 1d arrays and lists.
(setq arrMaze1 [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 x 0 x x x x x x x 0 0 0 0 0 0 x x x 0 0 x 0 0 x x x 0 0 0 0 0 0 x x 0 x 0 0 0 0 x 0 0 0 0 x x x 0 0 x x x x x x x x 0 0 0 x 0 0 0 0 0 x 0 x 0 0 x 0 0 0 0 0 0 0 x x x x x 0 0 x 0 0 0 0 0 0 x x 0 0 x 0 0 x x 0 0 0 x x x x 0 0 x x 0 x x 0 0 0 x x 0 0 x x x 0 x 0 0 x x 0 0 0 0 0 0 0 0 x 0 0 0 0 x 0 0 0 0 0 0 0 0 x x 0 0 x x x 0 0 0 0 0 0 0 0 x 0 0 0 x 0 0 0 0 0 0 0 0 0 x x x 0 x x 0 0 0 0 0 0 0 0 0 0 0 X 0 o 0 0 0 0 0])
(setq arrMaze2 [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 x x x x x x x 0 0 0 0 0 0 x x x 0 0 x 0 0 x x x 0 0 0 0 0 0 x x x x 0 0 0 0 x 0 0 0 0 x x x 0 0 x x x x x x x x 0 0 0 x 0 0 0 x 0 x 0 0 0 0 0 0 0 x 0 0 0 0 x x x x x 0 0 0 0 0 x x 0 0 x x 0 0 x 0 0 x x 0 0 0 x x x x 0 0 x x 0 x x 0 0 0 x x 0 0 x x x 0 x 0 0 x x 0 0 0 0 0 0 0 0 x 0 0 0 0 x 0 00 0 0 0 0 0 0 x 0 0 x x x 0 0 0 x x x x x 0 0 0 x x x 0 0 0 0 0 x 0 0 x x x 0 x 0 0 0 0 0 0 0 X 0 0 0 0 X 0 o 0 0 0 0 0])
(setq arrMaze3 [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 x 0 x 0 0 x x x x 0 0 0 0 0 0 x x x x x x 0 0 x x x 0 0 0 0 0 0 x x 0 x 0 0 0 0 x 0 0 0 0 x x x 0 0 x x x x x x 0 0 0 0 0 x 0 0 0 0 0 x 0 x 0 0 x 0 0 0 0 0 0 0 x x x x x 0 0 x 0 0 0 0 0 0 x x 0 0 0 0 0 x x 0 0 0 x x x x 0 x x x x x x 0 0 0 x x 0 0 x x x 0 x 0 0 x x 0 0 x 0 0 0 0 0 x 0 0 0 0 x 0 0 0 x 0 x 0 0 x x 0 0 x x x 0 0 0 x x x 0 0 x 0 0 0 x 0 0 0 0 0 x 0 0 0 x x x 0 x x 0 0 0 0 0 0 0 0 0 0 0 X 0 o 0 0 0 0 0])

(setq listMaze1 '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 x 0 x x x x x x x 0 0 0 0 0 0 x x x 0 0 x 0 0 x x x 0 0 0 0 0 0 x x 0 x 0 0 0 0 x 0 0 0 0 x x x 0 0 x x x x x x x x 0 0 0 x 0 0 0 0 0 x 0 x 0 0 x 0 0 0 0 0 0 0 x x x x x 0 0 x 0 0 0 0 0 0 x x 0 0 x 0 0 x x 0 0 0 x x x x 0 0 x x 0 x x 0 0 0 x x 0 0 x x x 0 x 0 0 x x 0 0 0 0 0 0 0 0 x 0 0 0 0 x 0 0 0 0 0 0 0 0 x x 0 0 x x x 0 0 0 0 0 0 0 0 x 0 0 0 x 0 0 0 0 0 0 0 0 0 x x x 0 x x 0 0 0 0 0 0 0 0 0 0 0 X 0 o 0 0 0 0 0))
(setq listMaze2 '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 x x x x x x x 0 0 0 0 0 0 x x x 0 0 x 0 0 x x x 0 0 0 0 0 0 x x x x 0 0 0 0 x 0 0 0 0 x x x 0 0 x x x x x x x x 0 0 0 x 0 0 0 x 0 x 0 0 0 0 0 0 0 x 0 0 0 0 x x x x x 0 0 0 0 0 x x 0 0 x x 0 0 x 0 0 x x 0 0 0 x x x x 0 0 x x 0 x x 0 0 0 x x 0 0 x x x 0 x 0 0 x x 0 0 0 0 0 0 0 0 x 0 0 0 0 x 0 00 0 0 0 0 0 0 x 0 0 x x x 0 0 0 x x x x x 0 0 0 x x x 0 0 0 0 0 x 0 0 x x x 0 x 0 0 0 0 0 0 0 X 0 0 0 0 X 0 o 0 0 0 0 0))
(setq listMaze3 '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 x 0 x 0 0 x x x x 0 0 0 0 0 0 x x x x x x 0 0 x x x 0 0 0 0 0 0 x x 0 x 0 0 0 0 x 0 0 0 0 x x x 0 0 x x x x x x 0 0 0 0 0 x 0 0 0 0 0 x 0 x 0 0 x 0 0 0 0 0 0 0 x x x x x 0 0 x 0 0 0 0 0 0 x x 0 0 0 0 0 x x 0 0 0 x x x x 0 x x x x x x 0 0 0 x x 0 0 x x x 0 x 0 0 x x 0 0 x 0 0 0 0 0 x 0 0 0 0 x 0 0 0 x 0 x 0 0 x x 0 0 x x x 0 0 0 x x x 0 0 x 0 0 0 x 0 0 0 0 0 x 0 0 0 x x x 0 x x 0 0 0 0 0 0 0 0 0 0 0 X 0 o 0 0 0 0 0))




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



;;changed 11/5 so that it works with a 1d array instead of a 2d list. sorry had to eliminate recursion,
;;it was sweet Dr. Sam, sorry you missed it. printed a nested 2d list in 5 lines of code using princ terpri and recursion.
(defun printMaze (mazer arrSize arrRows)
  (setq space ?\s)
    (cl-loop for i from 0 to (- arrSize 1)
	     do(if(eq (mod i arrRows) 0)
		   (terpri))
	     do(princ (aref mazer i))))

;for testing
(setq arry [0 1 2 2 2 A a 2 1])


;;*KINDANEW* 11/5 Changing this method to be very similar to a "main" method.
(defun startMaze ()
    (message "Welcome to the Maze Solver")  
    (defvar mazeName)
    ;;starts the maze and asks the user what maze they would like.
    ;; this sets mazeName with the correct filename of the maze we are using.
      (setq mazeName (initializeMaze))
      (with-temp-buffer
	;;this uses file-to-matrix to create a 1d array that represents the maze.
	;; file to array also finds the length of the array (not last index, example: '1 '2 '3 = length 3)
	(setq mazeArr(file-to-array mazeName))
	;;finds the start index and 
	(setq startIndex (starPos mazeArr))
	;;this is a copy of the maze so we have a before and after
	(setq initialMaze (make-vector totalCells '0))	
	(cl-loop for x below totalCells
		 do (aset initialMaze x (aref mazeArr x)))
	(findRowCol)
	;;solving the maze
	(setq mazeArr (solveMaze ROWS COLS totalCells mazeArr)))
      ;;printing out the unsolved and solved maze.
      (message "the maze before it was solved:
")
      (printMaze initialMaze totalCells)
      (message "the maze before after it was solved:
")
      (printMaze mazeArr totalCells)
      
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


;;this kinda works, thre is some problem with scope, spent 6 hours working on it and I cant find the solution.
;;it will have the full list on the last iteration but it is not successfully pusing it to the list outside of the nested loop. edited 11/7
;;*NEW* this method fills an 1d array (vector) with the contents of a given file
(defun file-to-array (file)
  (with-temp-buffer
    ;;idk if this works.
    ;;maybe this instead?km
    ;;(setq tempList (cl-loop for x in (insert-file-contents file) collect x))
    (setq tempList (file-to-matrix file))
    (setq mainList '())
    (setq otherTemp '())
    (setq listLength (- (length tempList) 1))

    ;;maybe this will work. no.
    ;;(setq mainBoi (cl-loop for x in tempList collect (cl-loop for i in x collect x)))

     (cl-loop for i to listLength
     	     do 
     	     (setq otherTemp (car tempList))
     	     (setq tempList (cdr tempList))	      
   	     (cl-loop for x to listLength
     		      do
		      (push (car otherTemp) mainList)	
    		      (setq otherTemp (cdr otherTemp))))
     
     (nreverse otherTemp)
     (print otherTemp)
    (setq totalCells (length mainList)))
  (setq finalArray (make-vector totalCells mainList))
)


  ;;*NEW* 11/2 this method finds the starting position of a 1d array passed in a param.*EDITED* 11/6
 (defun startPos (maze)
   ;;the first x in the maze is the sstarting pos.
   (progn
     (cl-loop for x below totalCells
	      do(if ((char-equal (aref maze x) ?x) return x)))
 	   )
   )

 ;;*NEW* 11/2 this method finds the rows and columns of a 1d square array
 (defun findRowCol ()
   (progn
   (setq sqSize (isqrt totalCells))
   (setq ROWS sqSize)
   (setq COLS sqSize)
   ))

;;NOT DONE YET
(defun solveMaze (mazeRows mazeCols mazeSize mazeArray)
  (setq up '());;store locations where decisions were made
  (setq down '())
  (setq right '())
  (setq left '())
  (setq decisions '())
  (defvar numOfDecisions)
  (setf numOfDecisions '()) ;;stores index where more than one decision could've been made
  (defvar counter)
  (setf counter 0)
  (defvar startIndex)
  (setf startIndex (cl-position 'X mazeArray));;finds starting position in 1d array assuming that the element is not wrapped in double quotes
  (defvar endIndex)
  (setf endIndex (cl-position 'o mazeArray))
  (defvar mazePosition)
  (setf mazePosition (goto-char startIndex)) ;;variable is updated when decision is made in loop
  (cl-loop for x across mazeArray until (startIndex) ;;the across keyword allows us to iterate through an array 
	   do((if (equal x startIndex) t
		(setcar (nthcdr startIndex mazeArray) '*)))) ;;change character for starting point 
  (cl-loop for y across mazeArray until (endIndex)
	   do((goto-char mazePosition)
	      (if (equal (cl-position 'x (cl-position (- mazePosition 15))) t)
	            (progn(setf mazePosition (goto-char (- mazePosition 15))) ;;progn will allow for multistatement execution within the if statement (might solve our macro expansion error)
		          (setcar (nthcdr (cl-position (- mazePosition 15))mazeArray) '*)
		          (push (cl-position (- mazePosition 15) up))
			  (push (cl-position (- mazePosition 15) decisions))
			  (setf counter (+ counter 1))))
	      (if (equal (cl-position 'x (cl-position(+ mazePosition 15))) t)
		    (progn(setf mazePosition (goto-char (+ mazePosition 15)))
		          (setcar (nthcdr (cl-position (+ mazePosition 15))mazeArray) '*)
		          (push (cl-position (+ mazePosition 15)down))
			  (push (cl-position (+ mazePosition 15) decisions))
			  (setf counter (+ counter 1))))
	      (if (equal (cl-position 'x (cl-position (+ mazePosition 1))) t)
		    (progn(setf mazePosition (goto-char (+ mazePosition 1)))
		          (setcar (nthcdr (cl-position (+ mazePosition 1))mazeArray) '*)
		          (push (cl-position (+ mazePosition 1) right))
			  (push (cl-position (+ mazePosition 1) decisions))
		          (setf counter (+ counter1))))
	      (if (equal (cl-position 'x (cl-position ( - mazePosition 1))) t)
		    (progn(setf mazePosition (goto-char (- mazePosition 1)))
		          (setcar (nthcdr (cl-position (- mazePosition 1))mazeArray) '*)
		          (push (cl-position (- mazePosition 1) left))
			  (push (cl-position (- mazePosition 15) decisions))
		          (setf counter (+ counter 1))))
	      ;;determine the number of decisions that were made for future reference.
	      (cl-case counter
		(2 (push (cl-position mazePosition numOfDecisions)))
		(3 (push (cl-position mazePosition numOfDecisions)))
		(4 (push (cl-position mazePosition numOfDecisions))))
	      (if (equal counter 1)
                  (progn (goto-char (reverse(cdr (reverse decisions))))

		     )
		  )
	      (setf counter 0)
	      ;;only evaluates for values that are valid. Any indices that are a 0 are skipped in the current evaluation of the loop.
	      ;;figure out way of printing out updated maze after each iteration. Or we could just print the maze after the last iteration
	   )
       )
  )