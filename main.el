;;;; CPSC 376 Pathfinding Algorithm
;;;; David Gillette & Adam Schultz
;;;; 9/20/2020
(defvar ROWS); "Number of rows in maze")        ;should by dynamically set based on user input
(defvar COLS) ; "Number of columns in maze")  ;but for testing purposes we will stick to a static value
(defvar totalCells) 
(defvar maze1)
(setf maze1 "maze1.txt")
(defvar maze2)
(setf maze2 "maze2.txt")
(defvar maze3)
(setf maze3 "maze3.txt")


;;THis is basically our constructor for these vars so we dont have to worry about them. I am gonna adda call to this in start maze or wherever they pick the maze.
(defun initVars (file)
  (setq longList (file-to-matrix file))
  (setq ROWS (length longList))
  (setq COLS ROWS)
  (setq totalCells (length (listsToList '() longList)))
  (print ROWS)
  (print COLS)
  (print totalCells))

(require 'dash)
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

      ;;for ttesting
(setq mazy (list 
  '(x x x x x)
  '(x 0 0 x x)
  '(x x x x x)
  '(x x x x x)
  '(x x x x x)
))



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


;;this method currently does not call maybesolve or solvemaze.
;;this method is called with the correct file that the user chooses and then calls the proper funcs to run the program.
(defun startMaze (file)  
  (with-temp-buffer
    ;initiallizes totalCells, ROWS, COLS, and mazeArr to vals.    
	(initVars file)
	;;this is a copy of the maze so we have a before and after
	(setq initialMaze (file-to-array file)))
	;;solving the maze
	;(setq mazeArr (solveMaze ROWS COLS totalCells (file-to-array file))))
	;;printing out the unsolved and solved maze.
	;(setq mazeArr (maybeSolve ROWS totalCells file (file-to-array file))))
  (princ "the maze before it was solved:")
  (printMaze initialMaze totalCells ROWS)
  (terpri)
  (terpri)
      (princ "the maze  after it was solved:")
      (terpri))
      ;(printMaze mazeArr totalCells ROWS))



;;this func asks the user which maze they want.
(defun pickMaze()
  (interactive)
  (message "Choose the maze you would like to see (1, 2, or 3)")
  (cl-case (read-char)
    (?1 (startMaze maze))
    (?2 (startMaze maze2))
    (?3 (startMaze maze3))
    (t (message "invalid input")))
  )

;;this function is similar to a main and starts our program, asking the user if they want to see a maze solved
(defun initializeMaze ()
  (interactive)
  (message (read-string "Enter your name:"))
  
  (if (y-or-n-p "Would you like to solve a maze solved?")
    (progn
      (pickMaze)
    )
  (progn
    (message "Too bad, see you next time!")
   )
  )
 )

;;this is the old version before I made it cool and good with recursion. (also made it work)
;; ;;*NEW* this method fills an 1d array (vector) with the contents of a given file
;; (defun file-to-array (file)
;;   (with-temp-buffer
;;     ;;idk if this works.
;;     ;;maybe this instead?km
;;     ;;(setq tempList (cl-loop for x in (insert-file-contents file) collect x))
;;     (setq tempList (file-to-matrix file))
;;     (setq mainList '())
;;     (setq otherTemp '())
;;     (setq listLength (- (length tempList) 1))

;;     ;;maybe this will work. no.
;;     ;;(setq mainBoi (cl-loop for x in tempList collect (cl-loop for i in x collect x)))

;;      (cl-loop for i to listLength
;;      	     do 
;;      	     (setq otherTemp (car tempList))
;;      	     (setq tempList (cdr tempList))	      
;;    	     (cl-loop for x to listLength
;;      		      do
;; 		      (push (car otherTemp) mainList)	
;;     		      (setq otherTemp (cdr otherTemp))))
     
;;      (nreverse otherTemp)
;;      (print otherTemp)
;;     (setq totalCells (length mainList)))
;;   (setq finalArray (make-vector totalCells mainList))
;;   )


;;*NEW* this method takes in an empty list and a 2d list and returns a 1d version of the nested list
(defun listsToList (emptyList  lists)
  (if (equal (length lists) 1)
      (setq emptyList (append emptyList (car lists)))
    (progn
      (setq emptyList (append emptyList (car lists)))
      (listsToList emptyList (cdr lists)))))

;;*NEW* this function uses the listsTOList function and makes a 1d array out of one of our maze text files.
;;it does this by taking in a the 1d list created by ListsToList and makes it into an array.
(defun file-to-array (file)
  (setq mainList (listsToList '() (file-to-matrix file)))
  (setq totalCells (length mainList))
  (setq finalArr (make-vector totalCells 0))
  (cl-loop for x to (- totalCells 1)
	   do (aset finalArr x (car mainList))
	   (setq mainList (cdr mainList)))
  (copy-sequence finalArr))

  ;;This function returns an array verison of a passed in list. 11/11
(defun list-to-array (arrList)
  (setq workingList (copy-sequence arrList))
  (setq numVals (length workingList))
  (setq toReturn (make-vector numVals 0))
  (cl-loop for x to (- numVals 1)
	   do (aset toReturn x (car workingList))
	   (setq workingList (cdr workingList)))
  (copy-sequence toReturn))

;for testing
(setq mazeRows 3)
(setq mazeCols 3)
(setq mazeSize 9)
(setq mazeArray [0 x 0 0 x 0 0 x 0])


;;Helper function for maybeSolve, returns the number of possible directions for the current index.
(defun numDecisions (argarr argindex argrows)
  (setq count 0)
  (progn
  (if (equal (aref argarr (+ argindex 1)) '"X")
      (setq count (+ count 1)))
  (if (equal (aref argarr (+ argindex argrows)) '"X")
      (setq count (+ count 1)))
  (if (equal (aref argarr (- argindex 1)) '"X")
      (setq count (+ count 1)))
  (if (equal (aref argarr (- argindex argrows)) '"X")
      (setq count (+ count 1)))
  (if (equal (aref argarr (+ argindex 1)) '"x")
      (setq count (+ count 1)))
  (if (equal (aref argarr (+ argindex argrows)) '"x")
      (setq count (+ count 1)))
  (if (equal (aref argarr (- argindex 1)) '"x")
      (setq count (+ count 1)))
  (if (equal (aref argarr (- argindex argrows)) '"x")
      (setq count (+ count 1))))
  count
 )

;;this method checks to see if the curIndex is contained in the pastindex array.
(defun beenHere (curIndex pastIndex)
  (setq yes nil)
  (cl-loop for x below (- (length pastIndex) 1)
	   do (if(equal (aref pastIndex x) curIndex)
		  (setq yes t)))
  yes)

;;*new* maybe works 9:13 11/10/2020
;;arr index rows
(defun maybeSolve (mazeRows mazeSize file mazeArray)
  (setq badArr (copy-sequence mazeArray))
  (setq currentIndex (seq-position mazeArray '"x"))
  (setq currentDirection "down")
  (setq decIndex '())
  (setq finalDirs '())
  (setq lastIndex 0)
  (setq decArr (list-to-array badArr))
  (numDecisions arr currentIndex ROWS)

  (while (not (eq (aref mazeArray currentIndex) '"X"))
    (setq decArr (list-to-array decIndex))
    (setq intDecisions (numDecisions decArr currentIndex ROWS))    

    (if (> (length decArr) 0)
	(progn
    (if (> (numDecisions decArr currentIndex ROWS) 2)
	(progn
	  (if (beenHere currentIndex decIndex)
	      (aset badArr currentIndex 0)
	    (push currentIndex decIndex))))))

    ;;if the number of decisions is one, meaning it is at a dead end this allows it to backtrack.
    (if (eq indecisions 1)
	(if (equal (aref badArr (+ currentIndex 1)) "x")
		(progn
		  (setq lastIndex currentIndex)
		  (setq currentIndex (+ currentIndex 1)))
	      (progn
		(if (equal (aref badArr (- currentIndex mazeRows)) "x")
		    (progn
		      (setq lastIndex currentIndex)
		      (setq currentIndex (- currentIndex mazeRows)))
		  (progn
		    (if (equal (aref badArr (- currentIndex 1)) "x")
			(progn
			  (setq lastIndex currentIndex)
			  (setq currentIndex (- currentIndex 1)))
		      (progn
			(if (equal (aref badArr (+ currentIndex mazeRows)) "x")
			    (progn
			      (setq lastIndex currentIndex)
			      (setq currentIndex (+ currentIndex mazeRows)))
			  (progn
			    (message "this sucker broke"))))))))))
    ;;if the number of decisions is greater than 1 then this makes sure the it doesnt backtrack by mistake.
    (if (> intDecisions 1)
	(if (equal (aref badArr (+ currentIndex 1)) "x")
	    (if (not (eq pastIndex (+ currentIndex 1)))
		(progn
		  (setq lastIndex currentIndex)
		  (setq currentIndex (+ currentIndex 1)))
	      (if (equal (aref badArr (+ currentIndex mazeRows)) "x")
		  (if (not (eq pastIndex (+ currentIndex mazeRows)))
		      (progn
			(setq lastIndex currentIndex)
			(setq currentIndex (+ currentIndex mazeRows)))
		    (if (equal (aref badArr (- currentIndex 1)) "x")
			(if (not (eq pastIndex (- currentIndex 1)))
			    (progn
			      (setq lastIndex currentIndex)
			      (setq currentIndex (- currentIndex 1)))
			  (if (equal (aref badArr (- currentIndex mazeRows)))
			      (if (not (eq pastIndex (- currentIndex mazeRows)))
				  (progn
				    (setq lastIndex currentIndex)
				    (setq currentIndex (- currentIndex mazeRows)))
				(if (equal (aref badArr (+ currentIndex 1)) "x")
				    (progn
				      (setq lastIndex currentIndex)
				      (setq currentIndex (+ currentIndex 1)))
				  (progn
				    (if (equal (aref badArr (- currentIndex mazeRows)) "X")
					(progn
					  (setq lastIndex currentIndex)
					  (setq currentIndex (- currentIndex mazeRows)))
				      (progn
					(if (equal (aref badArr (- currentIndex 1)) "X")
					    (progn
					      (setq lastIndex currentIndex)
					      (setq currentIndex (- currentIndex 1)))
					  (progn
					    (if (equal (aref badArr (+ currentIndex mazeRows)) "X")
						(progn
						  (setq lastIndex currentIndex)
						  (setq currentIndex (+ currentIndex mazeRows)))
					      (progn
						(if (equal (aref badArr (+ currentIndex 1)) "X")
						  progn
						  (setq lastIndex currentIndex)
						  (setq currentIndex (+ currentIndex 1)))
						(progn
						  (message "this sucker broke"))))))))))))))))))))
	
  badArr)










(defun solveMaze (mazeRows mazeCols mazeSize mazeArray)
  (setq up '());;store locations where decisions were made
  (setq down '())
  (setq right '())
  (setq left '())
  (setq allDecisions '())
  (defvar multipleDecsions)
  (setf mulitpleDecisions '());;stores index where more than one decision could've been made
  (setq forbidden '()) ;;values that lead to dead-ends
  (defvar counter)
  (setf counter 0)
  (setq counterList '())
  (defvar startIndex)
  (setf startIndex (seq-position mazeArray '"X"));;finds starting position in 1d array assuming that the element is not wrapped in double quotes
  (defvar endIndex)
  (setf endIndex (seq-position mazeArray '"o"))
  (defvar mazePosition)
  (setf mazePosition startIndex) ;;variable is updated when decision is made in loop
  (setq x 0)
  (setq y 0)
  ;;the across keyword allows us to iterate through an array
  (setcar (nthcdr startIndex mazeArray) '*);;change character for starting point 
  (cl-loop for x across mazeArray until endIndex
	   do((goto-char mazePosition)
	      (while (not 'allDecisions)  ;;cannot iterate through already existing decisions *
	      (if (equal (nth (- mazePosition 15) listMaze1) x)
	            (progn(setf mazePosition (goto-char (- mazePosition 15))) ;;progn will allow for multistatement execution within the if statement
		          (setcar (nthcdr (cl-position (- mazePossition 15))mazeArray) '*)
		          (push (nth (- mazePosition 15) mazeArray) up)
			  (push (nth (- mazePosition 15) mazeArray) allDecisions)
			  (setf counter (+ counter 1))))
	      (if (equal (nth (+ mazePosition 15) mazeArray) x)
		    (progn(setf mazePosition (goto-char (-mazePosition 15)))
		          (setcar (nthcdr (cl-position (+ mazePosition 15))mazeArray) '*)
		          (push (nth (+ mazePosition 15) mazeArray)down)
			  (push (nth (+ mazePosition 15) mazeArray) allDecisions)
			  (setf counter (+ counter 1))))
	      (if (equal (nth (+ mazePosition 1) mazeArray) x)
		    (progn(setf mazePosition (goto-char (+ mazePosition 1)))
		          (setcar (nthcdr (cl-position (+ mazePosition 1))listMaze1) '*)
		          (push (nth (+ mazePosition 1) mazeArray) right)
			  (push (nth (+ mazePosition 1) mazeArray) allDecisions)
		          (setf counter (+ counter1))))
	      (if (equal (nth (- mazePosition 1) mazeArray) x)
		    (progn(setf mazePosition (goto-char (- mazePosition 1)))
		          (setcar (nthcdr (cl-position (- mazePosition 1))listMaze1) '*)
		          (push (nth (- mazePosition 1) mazeArray) left)
			  (push (nth (- mazePosition 15) mazeArray) allDecisions)
		          (setf counter (+ counter 1))))

	      (push counter counterList)
	      ;;determine the number of decisions that were made for future reference.
	      (cl-case counter
		(2 (push mazePosition multipleDecisions))
		(3 (push mazePosition multipleDecisions))
		(4 (push mazePosition multipleDecisions)))
              (if (equal counter 1)
	          (progn
		       (while (eq (memql mazePosition forbidden) nil) ;;weeds out any unnecessary back and forth iteration
		         (setq tempCounter 0)
			 (nth tempCounter decisions) ;;get last element pushed to decisions list and point to that element
			 (setf mazePosition (goto-char  (nth tempCounter 'decisions)))
			 (push (pop decisions)forbidden) ;;always pop the first element in decisions as it will can no longer be used as a valid movement (leads to a dead-end). Move that value to a forbidden list that can later be used to avoid endless iteration
		    )
	          )
		)
	      (setf counter 0) ;;reset counter for next iteration
	      ;;only evaluates for values that are valid. Any indices that are a 0 are skipped in the current evaluation of the loop.
	      ;;figure out way of printing out updated maze after each iteration. Or we could just print the maze after the last iteration
	   )
       )
    )
  
  )
