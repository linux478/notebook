(princ ".")
(defun MP:Entity->getColor (e)
  (setq d (MP:Entity->getDXF e)
        l (MP:DXF->get 'layer d)
        c (MP:DXF->get 'color d)
  )
  (if c
    c
    (cdr (assoc 62 (tblsearch "layer" l)))
  )
); defun
(princ ".")
(defun MP:Entity->getDXF (e)
  (entget e)
); defun
(princ ".")
(defun MP:Entity->getLayer (e)
  (MP:DXF->get 'layer (MP:Entity->getDXF e))
); defun
(princ ".")
(defun MP:Entity->moveToLayer (en la)
  (SETQ current_layer (MP:Entity->getLayer en)
        new_layer (GETSTRING (STRCAT "\nCHANGE LAYER " (CDR current_layer) " TO: ") T)
        color (MP:Entity->getColor en)
  )
  (COMMAND "-layer" "new" newlayer "" "CHPROP" EN "" "LA" NEWLAYER "")
); defun
(princ ".")
(defun MP:Entity->makeLayer (sName)
  (if (not (MP:Layer->isPresent sName))
    (entmake (list (cons 0 "LAYER")
                   (cons 100 "AcDbSymbolTableRecord")
                   (cons 100 "AcDbLayerTableRecord")
                   (cons 2 sName)
                   (cons 70 0))
    )
  )
); defun
(princ ".")
(defun MP:Layer->isPresent (name)
  (tblsearch "layer" name)
);defun
(princ ".")
(defun MP:Layer->setColor (sName iColor)
  (if (setq en (MP:Layer->isPresent sName))
    (entmod (subst (cons 62 iColor) (assoc 62 (setq d (MP:Entity->getDXF en)))  d))
    nil
  )
);defun
(princ ".")
(defun MP:Layout->isFocus ()
  (= 1 (getvar 'cvport))
); defun
(princ ".")
(defun MP:Layout->isModel ()
  (= "MODEL" (strcat (getvar 'ctab)))
); defun
(princ ".")
(defun MP:Layout->setFocus ()
  (setvar 'cvport 1)
); defun
(princ ".")
(defun MP:Layout->setViewportLayers ( / n)
  (if (and
        (not (MP:Layout->isModel))
        (not (MP:Layout->isFocus))
      )
      (progn
        (MP:Entity->layer (setq n (strcat "delete me%%--" (substr (getvar 'ctab) 1 2) "C-delete-me")))
        (command "vplayer"
                 "freeze"
                 "*"
                 "current"
                 "thaw" 
                 (strcat "*%%--*" (substr (MP:Layout->getName) 1 2) "*")
                 "current"
                 "color"
                 "7"
                 "*"
                 "current"
                 "")
        (cond
          ((= (getvar 'ctab) "MEZ") (command "vplayer" "thaw" "*%%--*ZB*" "current" ""))
          ((= (getvar 'ctab) "RD MEZZANINE") (command "vplayer" "thaw" "*%%--*ZC*" "current" ""))
          ((= (getvar 'ctab) "RD THIRD FLOOR") (command "vplayer" "thaw" "*%%--*ZD*,PW-ROOM-IDEN%%--PH" "current" ""))
          ((= (getvar 'ctab) "PHARMA 3") (command "vplayer" "thaw" "*%%--*ZA*" "current" ""))
          ((= (getvar 'ctab) "PW 2") (command "vplayer" "thaw" "*%%--*ZE*" "current" ""))
        )
        (command "vplayer"
                 "removeoverrides"
                 "color"
                 (strcat "*%%--*" (substr (MP:Layout->getName) 1 2) "c*")
                 "current"
                 ""
                 "-laydel"
                 "name"
                 n
                 ""
                 "yes"
      )
    )
  )
); defun
(princ ".")
(defun c:qw ()
  (MP:Layout->setViewportLayers)
  (princ)
)
(princ ".")
(DEFUN C:22 ()
  (SETQ EN (CAR (ENTSEL))
        DXF (ENTGET EN)
        PREFIX "LEGEND COLOR "
        NUMBER (GETINT "\nENTER COLOR INT: ")
        SEPARATOR "@@"
        REVISION "--"
        TABS "MA")
  (PRINC "\n")
  (setq NEWLAYER (strcat 
                   PREFIX
                   (ITOA NUMBER)
                   SEPARATOR
                   REVISION
                   TABS
                 )
  )
  (COMMAND "-layer" "new" (strcat prefix (itoa number) separator revision tabs)
                    "color" number (strcat prefix (itoa number) "`@`@" revision tabs)
                    "" 
           "CHPROP" EN "" "LA" NEWLAYER ""
  )
); defun
;|
(mapcar
  '(lambda (x) 
    (setq ed (entget x)
           c (MP:entity->getcolor x)
           p (cdr (assoc 2 ed))
           n (strcat "PATT-" P "-" (itoa C) "%%--MAC")
    )
    (COMMAND
      "-LAYER"
      "NEW"
      N
      "COLOR"
      C
      N
      ""
      "CHPROP"
      X
      ""
      "LAYER"
      N
      ""
    )
  )
  (MP:SS->tolist 
    (setq ss (ssget '((0 . "HATCH"))))
  )
); defun
|;
(princ ".")
(defun c:MP:ENTSEL-RENAME-LAYER ( /
                                  ed - entity defination of selected item
                                )
  (setq ed (entget (car (entsel)))
  )
  (MP:ENTSEL-RENAME-LAYER ed)
  (princ)
); defun
(princ ".")
(defun MP:ENTSEL-RENAME-LAYER (ed)
  (princ "\n")
  (princ (cdr (assoc 8 ed)))
  (command "-rename" "layer" (cdr (assoc 8 ed)) pause)
  (if 
    (not
      (= "MODEL" (strcase (getvar 'ctab)))
    )
    (C:qw)
  )
); defun
(princ ".")
(defun c:` ()
  (setvar 'tilemode (rem (1+ (getvar 'tilemode)) 2))
  (princ)
); defun
(princ ".")
(defun c:0 () 
  (setvar 'clayer "0")
  (princ)
); defun
(princ ".")
(defun c:MP:test ()
  (setq cnt 0)
  (while (setq ld (tblnext "LAYER" (not ld)))
    (setq n (cdr (assoc 2 ld))
    )
    (if (and
          (not (wcmatch n "*|*"))
          (wcmatch n "*%%--BA*")
        )
        (progn
          (setq cnt (- cnt 30))
          (command
            "TEXT"
            "_NON"
            (strcat "0," (itoa cnt))
            "0"
            n
            "chprop"
            "last"
            ""
            "layer"
            n
            ""
          )
        )
    )
  )
); defun
(princ ".")
(defun MP:SS->toList (ss)
  (if 
    (and
      (setq rtn nil
            cnt (sslength ss)
      )
    )
    (repeat cnt
      (princ "\ntesting")
      (setq rtn (cons
                  (ssname ss 
                          (setq cnt (1- cnt))
                  )
                  rtn
                )
      )
    )
  )
); defun
(princ ".")
(defun c:MP:test2 ()
  (if
    (and
      (setq ss (ssget '((0 . "TEXT"))))
      (setq lst (MP:SS->toList ss))
    )
    (progn (princ "\ntesting")
    (mapcar '(lambda (x)
               (setq ed (entget x)
                     txt (cdr (assoc 1 ed))
                     l (cdr (assoc 8 ed ))
               )
               (princ "\n")
               (princ txt)
               (command
                 "-rename"
                 "layer"
                 l
                 txt
               )
             )
      lst
    )
    )
  )
); defun
(princ ".")
(defun MP:Layout->getName ()
  (getvar 'ctab)
); defun
(princ ".")
(defun MP:Layout->loop (fun)
  (mapcar '(lambda (x)
             (setvar 'ctab x)
             (eval (list fun))
           )
    (layoutlist)
  )
); defun
(princ ".")
(defun MP:Layout->check ()
  (MP:Layout->setFocus)
  (MP:Layout->setViewportLayers)
); defun
(princ ".")
(defun MP:TBlock->get ()
  (ssget "all" (list
                 '(0 . "insert")
                 '(10 0 0 0)
                 (cons 410 (MP:Layout->getName))
               )
  )
); defun
(princ ".")
(defun MP:TBlock->isAtOrigin ( )
  (and
    (setq ss (MP:TBlock->get))
    (= 1 (sslength ss))
    (setq en (ssname ss 0))
    (setq ed (entget en))
    (or
      (= (cdr (assoc 2 ed)) (MP:TBlock->getName))
      (= (MP:Insert->getEffectivename en) (MP:TBlock->getName))
    )
  )
); defun
(princ ".")
(defun MP:Insert->getEffectivename ( en )
  (vla-get-Effectivename (vlax-ename->vla-object en)) 
)
(princ ".")
(defun MP:TBlock->getName ()
  "SHEET D"
); defun
(princ ".")
(defun MP:TBlock->getRevision ()
  (LM:vl-getattributevalue 
    (vlax-ename->vla-object (ssname (MP:TBlock->get) 0))
    "Revision"
  )
); defun
(princ ".")
(defun LM:getdynpropvalue ( blk prp )
  (setq prp (strcase prp))
  (vl-some '(lambda ( x )
              (if (= prp (strcase (vla-get-propertyname x)))
                (vlax-get x 'value)
              )
            )
            (vlax-invoke blk 'getdynamicblockproperties)
  )
); defun
(princ ".")
(defun LM:vl-getattributevalue ( blk tag )
  (setq tag (strcase tag))
  (vl-some '(lambda ( att )
              (if (= tag (strcase (vla-get-tagstring att)))
                (vla-get-textstring att)
              )
            )
            (vlax-invoke blk 'getattributes)
  )
); defun
(princ ".")
(defun MP:Revision->getName ()
  "Revision"
);defun
(princ ".")
(defun MP:Revisions->get ()
  (mapcar 'cadr
          (ssnamex
            (ssget "all" (list
                           '(0 . "insert")
                           (cons 2 (strcat "`*U," (MP:Revision->getName)))
                           '(-4 . "*,=,=")
                           '(10 0 14.0625 0)
                         )
            )
          )
  )
); defun
(princ ".")
(defun MP:Revision->get ()
  (apply 'min
    (mapcar 'car
      (mapcar '(lambda (x)
                 (cdr (assoc 10 (entget x)))
               )
               (MP:Revisions->get)
      )
    )
  )
); defun
(princ ".")
(defun MP:Coordinates->getX ( lPoints )
  (mapcar 'car lPoints)
);defun
(princ ".")
(defun c:MP:SS->addSuffixTolayer ()
  (MP:SS->addSuffixToLayer
    (ssget)
    (strcat "-"
             (getstring "\nEnter suffix: ")
    )
  )
); defun
(princ ".")
(defun MP:SS->addSuffixToLayer (ss suffix)
  (mapcar '(lambda (x) 
            (command "-rename" "layer" x (strcat x suffix))
           )
           (mapcar '(lambda (x) 
                     (princ "\n")(princ x)
                    )
                    (vl-sort 
                      (vl-remove 
                        nil 
                        (REM-DOUBLE
                          (mapcar '(lambda (x)
                                    (if (= 'ename (type (cadr x)))
                                      (cdr (assoc 8 (entget (cadr x))))
                                    )
                                   )
                                   (ssnamex ss)
                          )))
                       '<)))
); defun
(princ ".")
(defun rem-double (lst / _lst)
  (foreach x lst
    (if (not (member x _lst))
      (setq _lst (cons x _lst))
    )
  )
  _lst
)
(princ ".")
(defun c:zx ()
  (command "zoom" "extents")
  (princ)
)
(defun c:qa ()
  (setq ss  (MP:SS->toList (ssget))
        rtn ""
  )
  (mapcar '(lambda (y)
            (setq l (MP:Entity->getLayer (car ss))
            )

        (princ "\n")
        (princ b)
        (setq base (getstring "\nIs base correct? "))
        (cond
          ((= base "")(setq rtn (strcat rtn b)))
          ((T (setq rtn (strcat rtn base))))
        )
        (setq rtn (strcat rtn "%%-"))
        (mapcar '(lambda (x)
                    (princ "\n")
                    (princ b)
                    (setq base (getstring "\nIs keep? "))
                    (cond
                      ((= base "")(setq rtn (strcat rtn b)))
                      ((T (setq rtn (strcat rtn base))))
                    )
                  )
                  lo
        )
        (command "-layer" "new" rtn "")
        (command "chprop" y "" "la" rtn "")
    )
    ss
  )
)
(princ ".")
(defun MP:Enitty->moveToLayer (en la / )
  
