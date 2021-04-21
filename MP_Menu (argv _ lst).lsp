;|
created: 20210420201439043
description: create a text menu and runs a function
modified: 20210421112945954
tags: AutoLisp API
title: MP:Menu (argv / lst)
type: text/plain
|;
(defun MP:Menu (argv / lst)
  (setq lst argv) ; list of the following:
                  ; '("1" "DOOR" MP:BLOCK->CREATE '("DOOR" T "A-DOOR"))
	    		  ;   |   |      |                |
		    	  ;   |   |      |                `-- function call parameters
			      ;   |   |      `-- Name of the function call
			      ;   |   `-- Name on the menu
			      ;   `-- Selection Character
  (TEXTSCR)
  (MAPCAR '(LAMBDA(X) (PRINC (STRCAT "\n" (strcase (CAR X)) ". " (CADR X)))) LST)
  (princ "\n")
  (setq ans (strcase (getstring "\nEnter choice: "))
        oexpert (getvar 'expert)
  )
  (cond
    ((MEMBER ANS (MAPCAR 'STRCASE (MAPCAR 'CAR LST)))(eval (CDDR (ASSOC ANS LST))))
    ((= 1 1)(princ "\nDo not know that choice!"))
  )
  (GRAPHSCR)
  (princ)
)
