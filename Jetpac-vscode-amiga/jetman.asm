
updateJetman:
  movem.l    d0-d6/a0-a6,-(a7)
  tst.b      (m_right)
  bne        moveLeft
  tst.b      (m_flying)           ; Check to see if
  bne        walkingRight         ; If not, must be
  lea.l      flyingRight,a1       ; Pointer to the sprite control words
  move.l     a1,d0
  move.l     d0,animationFrame    ; Update the frame
  bra        updateRight
walkingRight:
;  lea.l      flyingRight,a1       ; Pointer to the control words
  lea.l      sprite2,a1
  move.l     a1,d0
  move.l     d0,animationFrame    ; Update the frame
updateRight:
  clr.l      d1
  move.b     m_x,d1               ; Store the x position into d1
  cmp        #$b0,d1              ; Check to see if the position is @ #$b0
  bge        moveLeft             ; Branch if its greater than or equal to
  add.b      #1,m_x               ; Increment x by 1

moveLeft:
  tst.b      (m_left)
  bne        moveUp
  tst.b      (m_flying)           ; Check to see if
  bne        walkingLeft          ; If not, must be
  lea.l      flyingLeft,a1        ; Pointer to the sprite control words
  move.l     a1,d0
  move.l     d0,animationFrame    ; Update the frame
  bra        updateLeft
walkingLeft:
  lea.l      flyingLeft,a1        ; Pointer to the sprite control words
  move.l     a1,d0
  move.l     d0,animationFrame    ; Update the frame
updateLeft:
  clr.l      d1
  move.b     m_x,d1               ; Store the x position into d1
  cmp        #$40,d1              ; Check to see if the position is @ #$40
  ble        moveUp               ; Branch if its greater than or equal to
  sub.b      #1,m_x               ; Decrement x by 1

moveUp:
  tst.b      (m_up)
  bne        moveDown
  tst.b      (m_flying)
  bne        moveDown
  clr.l      d1
  move.b     m_yTop,d1            ; Store the y position into d1
  cmp        #$30,d1              ; Check to see if the position is @ #$f0
  blo        moveDown             ; Branch if its greater than or equal to
  sub.b      #1,m_yTop            ; Decrement the top y position by 1
  sub.b      #1,m_yBottom         ; Decrement the bottom y position by 1

moveDown:
  tst.b      (m_down)
  bne        updateComplete
  tst.b      (m_flying)
  bne        updateComplete
  clr.l      d1
  move.b     m_yTop,d1            ; Store the y position into d1
  cmp        #$e0,d1              ; Check to see if the position is @ #$e0
;  bgt        updateComplete       ; Branch if its greater than or equal to
  bgt        walking              ; Branch if its greater than or equal to
  add.b      #1,m_yTop            ; Increment the top y position by 1
  add.b      #1,m_yBottom         ; Increment the bottom y position by 1
  bra        updateComplete
walking:
  move.b     #1,m_flying
updateComplete:
  movem.l    (a7)+,d0-d6/a0-a6
  rts




;  movem.l    d0-d6/a0-a6,-(a7)
;
;flyingFaceRight:
;  tst.b      (m_flying)           ; Check to see if Zero - flying
;  bne        walking              ; if not flying we must be walking
;  tst.b      (m_right)            ; Check the direction of movement
;  bne        flyingFaceLeft
;  lea.l      flyingRight,a1       ; Pointer to the sprite control words
;  lea.l      flyingLeft,a2        ; Pointer to the sprite control words
;  move.l     a1,d0
;  move.l     d0,animationFrame
;  ;move.l     a2,animationFrame    ; Update the animation frame with the sprite direction
;  bra        checkPositions
;flyingFaceLeft:
;  tst.b      (m_left)             ; Check the direction of movement
;  bne        checkPositions
;  lea.l      flyingLeft,a1        ; Pointer to the sprite control words
;  lea.l      flyingRight,a2       ; Pointer to the sprite control words
;  move.l     a1,d0
;  move.l     d0,animationFrame
;  bra        checkPositions
;walking:
;;;  lea.l      flyingRight,a1
;;  lea.l      sprite2,a1           ;
;;  lea.l      sprite3,a2
;;  lea.l      sprite4,a3
;;  lea.l      sprite5,a4
;checkPositions:
;  cmp.b      #200,(a1)            ; Check to see if the sprite control word (Y) == 200
;  bne        moveSprite           ; if not $10,$2f
;  move.b     #$50,(a1)            ;30 Reset the screen locations in the control words
;  move.b     #$64,2(a1)           ;44
;;    move.b #$200,(a1) ;30 Reset the screen locations in the control words
;;    move.b #$220,2(a1);44
;
;
;moveSprite:
;;moveRight: ; Walking
;  tst.b      (m_right)
;  bne        moveLeft
;  clr.l      d1
;  move.b     1(a1),d1
;  cmp        #$da,d1              ; Check to see if the position is @ #$f0
;  bge        moveLeft             ; Branch if its greater than or equal to
;  add.b      #1,1(a1)
;  add.b      #1,1(a2)
;  add.b      #1,1(a3)
;  add.b      #1,1(a4)
;
;moveLeft:
;  clr.l      d3
;  move.b     m_left,d3
;  tst.b      (m_left)
;  bne        moveUp               ;endUpdateJetman
;  clr.l      d1
;  move.b     1(a1),d1
;  cmp        #$40,d1              ; Check to see if the position is @ #$f0
;  ble        moveUp               ;endUpdateJetman      ; Branch if its greater than or equal to
;  sub.b      #1,1(a1)
;  sub.b      #1,1(a2)
;  sub.b      #1,1(a3)
;  sub.b      #1,1(a4)
;
;moveUp:
;  tst.b      (m_up)
;  bne        moveDown             ;endUpdateJetman
;  move.b     (a1),d1
;  cmp        #$2a,d1              ; Check to see if the position is @ #$f0
;  ble        moveDown             ;endUpdateJetman      ; Branch if its greater than or equal to
;  sub.b      #1,(a1)
;  sub.b      #1,2(a1)
;  sub.b      #1,(a2)
;  sub.b      #1,2(a2)
;  sub.b      #1,(a3)
;  sub.b      #1,2(a3)
;  sub.b      #1,(a4)
;  sub.b      #1,2(a4)
;
;moveDown:
;  tst.b      (m_down)
;  bne        endUpdateJetman
;  clr.l      d1
;  move.b     (a1),d1
;  cmp        #$d0,d1              ; Check to see if the position is @ #$f0
;  bge        endUpdateJetman      ;moveLeft             ; Branch if its greater than or equal to
;;  move.b     sprite_y,d5
;  add.b      #1,(a1)
;  add.b      #1,2(a1)
;  add.b      #1,(a2)
;  add.b      #1,2(a2)
;  add.b      #1,(a3)
;  add.b      #1,2(a3)
;  add.b      #1,(a4)
;  add.b      #1,2(a4)
;
;;  clr.b      sprite_y
;
;;fire:
;endUpdateJetman:
;  tst.b      (m_fire)             ; Test if the fire button has been pressed (m_fire == 0)
;  bne        endUpdate1           ; Skip if not zero
;  lea.l      mOne,a1              ; Load the adress of the meteor control word
;  clr.l      d1
;  move.b     (a1),d1
;  cmp        #$f0,d1              ; Check to see if the position is @ #$f0
;  bge        endUpdated           ; Branch if its greater than or equal to
;  add.b      #1,(a1)              ; Update the first byte of the control word
;  add.b      #1,2(a1)             ; Update the last byte of the control word
;  jmp        endUpdate1
;endUpdated:						  ; Testing nops
;  nop
;  nop
;endUpdate1:
;  movem.l    (a7)+,d0-d6/a0-a6
;  rts
;;Jetman
;;dc.w $508c,$6400
;;mOne:
;  ;	dc.w $508c,$5c00
;
;;	cmp.b #250,(a1)
;;	blo endUpdateJetman
;;;	subq.b #1,sprite_y
;
;;	move.b sprite2,d1
;;	cmp.b #200,(d1)
;;	bgt endUpdateJetman
;;    add.b   #1,(a1)  ; Vertical movement
;;    add.b   #1,2(a1) ;
;;    add.b   #1,(a2)  ; Vertical movement
;;    add.b   #1,2(a2) ;
;;    add.b   #1,(a3)  ; Vertical movement
;;    add.b   #1,2(a3) ;
;;    add.b   #1,(a4)  ; Vertical movement
;;    add.b   #1,2(a4) ;
;;	add.b #1,1(a1)  ; Horizontal movement
;;	add.b #1,1(a2)  ; Horizontal movement
;;	add.b #1,1(a3)  ; Horizontal movement
;;	add.b #1,1(a4)  ; Horizontal movement