;;;; CPSC 376 Pathfinding Algorithm
;;;; David Gillette & Adam Schultz
;;;; 9/20/2020
(defconst ROWS 15 "Number of rows in maze")        ;should by dynamically set based on user input
(defconst COLUMNS 15 "Number of columns in maze")  ;but for testing purposes we will stick to a static value
(defvar *totalCells*) 
(setf totalCells (* ROWS COLUMNS))
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


(defun startMaze ()
    (message "Here is your maze:")
      (with-temp-buffer  
      (defvar maze)
      (setf maze(insert-file-contents "maze.txt" nil 0 500))
      (defvar mazeList)
      (setf mazeList(file-to-matrix "maze.txt")))
      (printMaze mazeList)
	;;(cl-loop for i from 0 below (length '(mazeList)) do
		;;(cl-loop for j from 0 below (length '(mazeList)) do
		       ;;(message "mazeList[~mazeList ~mazeList] = ~mazeList~%" i j)))
                       ;;tried iterating through list. Might have to reduce dimensionality of the list first or implement multiple loops for each dimension
      )
(defun pickMaze()
  (interactive)
  (message "Choose the maze you would like to see (1, 2, or 3)")
  (cl-case (read-char)
    (?1 (startMaze))
    (?2 (startMaze))
    (?3 (startMaze))
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