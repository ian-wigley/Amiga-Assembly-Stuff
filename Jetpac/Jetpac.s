           section    flashtro,code_c

begin:
           bsr        setupHardware
           jmp        mainloop
           rts


;****************************************************************** START of sprite.asm ***********************************************

 ;         INCLUDE    sprite.asm
 ;         INCLUDE    input.asm
 ;         INCLUDE    jetman.asm

setupHardware:
           move.l     4.w,a6                        ; Get base of exec lib
           lea        gfxName(pc),a1                ; Adress of gfxlib string to a1
           jsr        -408(a6)                      ; Call OpenLibrary()
           move.l     d0,gfxBase                    ; Save base of graphics.library
           move.l     #copperBuffer,$dff080         ; Set new copperlist
           move.w     #$4000,$dff09a
           ; move.w     #$01a0,$dff096
           move.w     #$3200,$dff100
           move.w     #$0000,$dff102
           move.w     #$003f,$dff104
           move.w     #0,$dff108
           move.w     #0,$dff10a
           move.w     #$2c81,$dff08e                ; DIWStart
           move.w     #$f4c1,$dff090                ; DIWStop
           move.w     #$0038,$dff092
           move.w     #$00d0,$dff094
           move.w     $dff088,d0
           ; move.w     #$81a0,$dff096
           move.w     #$81ff,$dff096
           ; bsr        extractLevelBitplaneInformation
           rts

mainloop:
           move.b $bfec01,d0       ; Check if the escape Key
           eor.b #$ff,d0           ; has been pressed
           ror.b #1,d0
           cmp.b #$45,d0           ; No, continue
           beq.s exit
           ; Check if either mouse button/joystick 1 or 2 pressed, if so exit
           btst.b     #6,$bfe001
           beq        exit
waitBeamLine0:      ; wait until at beam line 0
           move.l     $dff004,d0
           asr.l      #8,d0
           and.l      #$1ff,d0
           cmp.w      #0,d0
           bne        waitBeamLine0

waitBeamLine1:     ; wait until at beam line 1
           move.l     $dff004,d0
           asr.l      #8,d0
           and.l      #$1ff,d0
           cmp.w      #1,d0
           bne        waitBeamLine1
           bsr        updateJetman
           move.w     $dff00e,d0
           cmp.w      #$85fe,d0                     ;Test for collsion between Jet Man & 2nd rocket piece
           bne        continue
           btst       #10,$dff00e                   ;CLXDAT
           beq        continue
           clr.l      d0

continue:
           bsr        checkJoystick
           bsr        checkKeyBoard
;;  bsr animateSprite
;   bsr updateJetman
;    bsr movesprite

           bsr        doublebuffer
           bra        mainloop

exit:
           move.w     #$0080,$dff096
           move.l     $04,a6
           move.l     156(a6),a1
           move.l     38(a1),$dff080
           move.w     #$8080,$dff096
           move.w     #$c000,$dff09a
           moveq      #0,d0
           rts

gfxName:   dc.b       "graphics.library", 0, 0
gfxBase:   dc.l       0
oldView:   dc.l       0
oldInt:    dc.w       0
oldDMA:    dc.w       0

; Animation table
walkingSpriteAnimation:
           dc.l       sprite2
           dc.l       sprite3
           dc.l       sprite4
           dc.l       sprite5
           dc.l       0
           dc.l       0
flyingFacingRight:
           dc.l       flyingRight
flyingFacingLeft:
           dc.l       flyingLeft
counter:
           dc.l       0
           dc.l       0
           dc.l       0
           dc.l       0
delayCounter:
           dc.l       0
           dc.l       0
animationFrame:
           dc.l       flyingRight
;     dc.l       flyingLeft
           dc.l       sprite2
           dc.l       sprite3
           dc.l       sprite4
           dc.l       sprite5
           dc.b       0,0,0,0

animateSpriteWalking:
           add.l      #1,delayCounter
           cmp.l      #$10,delayCounter
           bne        delayReturn
           clr.l      delayCounter
           lea        sprite2,a2
           lea        sprite3,a3
           lea        sprite4,a4
           lea        sprite5,a5
           move.l     walkingSpriteAnimation,a0
           move.l     a0,d0
;   move.l 0(a0),d0
;   move.l 2(a0),d0
;   add.l counter(a0),d0
           add.l      counter,d0
           add.l      #$64,counter
           cmp.l      #$64*4,counter
           bne        done
           clr.l      counter
done:
           move.l     d0,animationFrame
delayReturn:
;   jmp animateSprite
           rts


; Double buffer to ensure smooth movement by display on copper list
; Whilst updating the second, before switching between them.
;
doublebuffer:
           nop
           move.l     frame,d0
           add        #1,d0
           and.l      #1,d0
           move.l     d0,frame
           bne        usecopper2
           bra        usecopper1
usecopper2:
           move.l     #copper2,a6
           bra        storeSelection
usecopper1:
           move.l     #copper1,a6

storeSelection:
           move.l     a6,copperBuffer
           move.l     #$01060000,(a6)+              ; AGA compatible
           move.l     #$01fc0000,(a6)+

           lea.l      animationFrame,a1             ; Store the address of the Jetman data into a1
           move.l     (a1),a2
           move.b     m_yTop,(a2)
           move.b     m_x,1(a2)
           move.b     m_yBottom,2(a2)
           move.l     (a2),d0
;     move.b     m_x,d1
;     add.b      d1,1(a2)
;add.b m_y,1(a1)
;add.b mx+#$e,2(a1)
;   lea.l   animationFrame,a1                 ; Store the address of the sprite data into a1
           move.w     #$0122,(a6)+                  ; Add the sprite 0 High Word to the copper list
           move.l     (a1),d1                       ; Store the address in a1 into d1
           move.w     d1,(a6)+                      ; Copy the LOW byte address into the copper list
           move.w     #$0120,(a6)+                  ; Add the sprite 0 Low Word to the copper list
           swap       d1                            ; Swap the byte order in d1
           move.w     d1,(a6)+                      ; Copy the HIGH byte address into the copper list

           lea.l      metOne,a1                     ; Store the address of the meteor sprite data into a1
           sub.b      #1,1(a1)                      ; ***** Temp test to move the object *****
           move.w     #$0126,(a6)+                  ; Add the sprite 0 High Word to the copper list
           move.l     a1,d1                         ; Store the address in a1 into d1
           move.w     d1,(a6)+                      ; Copy the LOW byte address into the copper list
           move.w     #$0124,(a6)+                  ; Add the sprite 0 Low Word to the copper list
           swap       d1                            ; Swap the byte order in d1
           move.w     d1,(a6)+                      ; Copy the HIGH byte address into the copper list

;; No colours set below

           lea.l      metTwo,a1                     ; Store the address of the meteor sprite data into a1
           move.w     #$012a,(a6)+                  ; Add the sprite 0 High Word to the copper list
           move.l     a1,d1                         ; Store the address in a1 into d1
           move.w     d1,(a6)+                      ; Copy the LOW byte address into the copper list
           move.w     #$0128,(a6)+                  ; Add the sprite 0 Low Word to the copper list
           swap       d1                            ; Swap the byte order in d1
           move.w     d1,(a6)+                      ; Copy the HIGH byte address into the copper list

           lea.l      rocketOnePartOne,a1           ; Store the address of the meteor sprite data into a1
           move.w     #$012e,(a6)+                  ; Add the sprite 0 High Word to the copper list
           move.l     a1,d1                         ; Store the address in a1 into d1
           move.w     d1,(a6)+                      ; Copy the LOW byte address into the copper list
           move.w     #$012c,(a6)+                  ; Add the sprite 0 Low Word to the copper list
           swap       d1                            ; Swap the byte order in d1
           move.w     d1,(a6)+                      ; Copy the HIGH byte address into the copper list

           lea.l      rocketOnePartTwo,a1           ; Store the address of the meteor sprite data into a1
           move.w     #$0132,(a6)+                  ; Add the sprite 0 High Word to the copper list
           move.l     a1,d1                         ; Store the address in a1 into d1
           move.w     d1,(a6)+                      ; Copy the LOW byte address into the copper list
           move.w     #$0130,(a6)+                  ; Add the sprite 0 Low Word to the copper list
           swap       d1                            ; Swap the byte order in d1
           move.w     d1,(a6)+                      ; Copy the HIGH byte address into the copper list

           lea.l      rocketOnePartThree,a1         ; Store the address of the meteor sprite data into a1
           move.w     #$0136,(a6)+                  ; Add the sprite 0 High Word to the copper list
           move.l     a1,d1                         ; Store the address in a1 into d1
           move.w     d1,(a6)+                      ; Copy the LOW byte address into the copper list
           move.w     #$0134,(a6)+                  ; Add the sprite 0 Low Word to the copper list
           swap       d1                            ; Swap the byte order in d1
           move.w     d1,(a6)+                      ; Copy the HIGH byte address into the copper list

           move.l     #$2c01fffe,(a6)+
           move.l     #$01002200,(a6)+              ; Bitplane control

           lea.l      background,a1
           move.w     #$00e2,(a6)+
           move.l     a1,d1
;     move.w     d1,d2
           move.w     d1,(a6)+
           move.w     #$00e0,(a6)+
           swap       d1
           move.w     d1,(a6)+

           lea.l      background+(4800*2+320),a1
           move.w     #$00e6,(a6)+
           move.l     a1,d1
;     move.w     d1,d2
           move.w     d1,(a6)+
           move.w     #$00e4,(a6)+
           swap       d1
           move.w     d1,(a6)+

           move.l     #$01800000,(a6)+              ; Colours
           move.l     #$018200f0,(a6)+
           move.l     #$01840ff0,(a6)+
           move.l     #$01860ffd,(a6)+
           move.l     #$01880ff0,(a6)+
           move.l     #$018a0ff0,(a6)+
           move.l     #$018c0ff0,(a6)+
           move.l     #$018e0ff0,(a6)+

     ;....
           move.l     #$019c05f5,(a6)+              ; Colours
           move.l     #$019e05f5,(a6)+              ; Colours

           move.l     #$01a005f5,(a6)+              ; Colours
           move.l     #$01a2055f,(a6)+              ; Colours

           move.l     #$01a40555,(a6)+              ; Colours
           move.l     #$01a60ff0,(a6)+              ; Colours
           move.l     #$01a80ff0,(a6)+              ; Colours

           move.l     #$01aa0fff,(a6)+              ; Meteor Colour
           move.l     #$01ac0f00,(a6)+              ; Colours

           move.l     #$01ae0f00,(a6)+              ; Colours
           move.l     #$01b000f0,(a6)+              ; Colours

           move.l     #$01b2000f,(a6)+              ; Colours
           move.l     #$01b4000f,(a6)+              ; Colours

           move.l     #$01b6000f,(a6)+              ; Colours
           move.l     #$01b8000f,(a6)+              ; Colours

           move.l     #$01ba000f,(a6)+              ; Colours
           move.l     #$01bc000f,(a6)+              ; Colours


           move.l     #$ffdffffe,(a6)+
           move.l     #$2c01fffe,(a6)+
           move.l     #$01000200,(a6)+              ; Bitplane control

           move.l     #$fffffffe,(a6)+              ; End of the list
           move.l     copperBuffer,$dff080
           rts

; Hacky method to quickly get a pointer to the start of the Bitplane
extractLevelBitplaneInformation:
           clr.l      d0
           lea        background,a0
testBody:
           move.l     (a0),d0
           cmp.l      #"FORM",(a0)                  ;$464f524d,d0                       ; 'FORM',d0                          ;,(a1)+
;     tst.w      d0
           beq        doneExtraction
           move.l     (a0)+,d0                      ; The next long word is the size of the file - 8
           add        #8,d0
           move.l     (a0)+,d0
           cmp        'ILBM',d0                     ; Compare if d0 contains 'ILBM'
           tst        d0                            ; Test the result : -1, 0, 1
           bmi        doneExtraction
           move.l     (a0)+,d0
           cmp        'BMHD',d0                     ; Compare if d0 contains 'BMHD'
           tst        d0                            ; Test the result : -1, 0, 1
           bmi        doneExtraction
           move.l     (a0)+,d0
           move.l     (a0)+,d0
           cmp        'BODY',d0                     ; Compare if d0 contains 'BODY'
           tst        d0
           move.l     a0,m_levelBitPlaneOne
doneExtraction:
           rts

;******************************************************************

           Section    ChipRAM,Data_c
     ; $508c,$6400
m_x:
           dc.b       $8c,0
m_yTop:
           dc.b       $50,0
m_yBottom:
           dc.b       $64,0

;m_flying:
;     dc.b       0,0
           even

m_levelBitPlaneOne:
           dc.l       0
m_score:
           dc.l       0
m_level:
           dc.l       0
frame:
           dc.l       0
screen:
           blk.b      10240,0
     ;include    Dev:Jetpac/jetman_data.asm
     ;include    Dev:Jetpac/meteor.asm
     ;include    Dev:Jetpac/rocket_data.asm

copperBuffer:
           dc.l       0,0

; datalists aligned to 32-bit
           CNOP       0,4
copper1:
           dc.l       $ffffffe
           blk.l      1023,0
           CNOP       0,4
copper2:
           dc.l       $ffffffe
           blk.l      1023,0
background:
;     incbin     "background.iff"
           incbin     "background_224x224.raw"

           ;end
           
;****************************************************************** END of sprite.asm ***********************************************

           section    flashtro,code_c

;****************************************************************** START of input.asm ***********************************************

checkJoystick:
           lea        m_left,a3                     ; Store the address of the first bool
           move.b     #1,(a3)+                      ; Reset the bools back to 1
           move.b     #1,(a3)+                      ; Reset the bools back to 1
           move.b     #1,(a3)+                      ; Reset the bools back to 1
           move.b     #1,(a3)+                      ; Reset the bools back to 1
           move.b     #1,(a3)+                      ; Reset the bools back to 1
           move.b     #1,(a3)+                      ; Reset the bools back to 1
           move.b     #1,(a3)+                      ; Reset the bools back to 1
           move.b     #1,(a3)+                      ; Reset the bools back to 1
           move.w     $dff00c,d3                    ; Store the address of joy1dat into d3
right:
           btst.l     #1,d3                         ; bit 1 tells us if we go to the right
           beq.s      left                          ; if it is zero, you don't go to the right
;	addq.b #1,sprite_x 	; if it is 1, move the sprite to a pixel
           clr.b      m_right
;          bsr       animateSprite    ; Update animation frame
           bra.s      up                            ; go to the y check
left:
           btst.l     #9,d3                         ; bit 9 tells us if you go left
           beq.s      up                            ; if it is zero, you don't go left
;	subq.b #1,sprite_x 	; if it is 1 move the sprite
           clr.b      m_left
;          bsr       animateSprite    ; Update animation frame
up:
           move.w     d3,d2                         ; copy the register value
           lsr.w      #1,d2                         ; scrolls the bits of a place to the right
           eor.w      d2,d3                         ; executes the exclusive or. now we can test
           btst.l     #8,d3                         ; let's test if it goes high
           beq.s      down                          ; if not, check if it goes down
           ;subq.b #1,sprite_y 	; if you move the sprite
           clr.b      m_up
           move.b     #0,m_flying
           bra.s      fire
down:
           btst.l     #0,d3                         ; let's test if it goes down
           beq.s      fire                          ; if not finish

;;	move.b current_y,d4
;;	cmp #200,d4         ; if the current_y < 250
;;	bgt fire
;          addq.b    #1,sprite_y    ; if you move the sprite
;;	addq.b #1,current_y
           clr.b      m_down
fire:
           btst.b     #7,$bfe001
           bne        exitInput
;	subq.b #1,meteor_y 	;
           clr.b      m_fire
exitInput:
;	jmp checkJoystick
           rts

checkKeyBoard:
;+-------+-------+-------+-------+-------+-------+
;   0  |   -   | CURS  | CURS  | CURS  | CURS  | HELP  |
;(PC.0)|note 3 | DOWN  | RIGHT | LEFT  |  UP   |       |
;      | (4A)  | (4D)  | (4E)  | (4F)  | (4C)  | (5F)  |
;+-------+-------+-------+-------+-------+-------+

           move.b     $bfec01,d0                    ; Check if the escape Key
           eor.b      #$ff,d0                       ; has been pressed
           ror.b      #1,d0
           cmp.b      #$45,d0                       ; No, continue
           bne        exitKeyboardInput
           clr.b      m_down
exitKeyboardInput:
           rts

m_left:    dc.b       1,1                           ;boolean;			true if left control held
m_right:   dc.b       1,1                           ;boolean;			true if right control held
m_up:      dc.b       1,1                           ;boolean;			true if up control held
m_down:    dc.b       1,1                           ;boolean;			true if down control held
m_fire:    dc.b       1,1,0,0                       ;boolean;			true if fire control held
m_flying:  dc.b       0,0,0,0
           even

;****************************************************************** END of input.asm ***********************************************
;****************************************************************** START of jetman.asm ***********************************************


updateJetman:
           movem.l    d0-d6/a0-a6,-(a7)
           tst.b      (m_right)
           bne        moveLeft
           tst.b      (m_flying)                    ; Check to see if
           bne        walkingRight                  ; If not, must be
           lea.l      flyingRight,a1                ; Pointer to the sprite control words
           move.l     a1,d0
           move.l     d0,animationFrame             ; Update the frame
           bra        updateRight
walkingRight:
;  lea.l      flyingRight,a1       ; Pointer to the control words
           lea.l      sprite2,a1
           move.l     a1,d0
           move.l     d0,animationFrame             ; Update the frame
updateRight:
           clr.l      d1
           move.b     m_x,d1                        ; Store the x position into d1
           cmp        #$b0,d1                       ; Check to see if the position is @ #$b0
           bge        moveLeft                      ; Branch if its greater than or equal to
           add.b      #1,m_x                        ; Increment x by 1

moveLeft:
           tst.b      (m_left)
           bne        moveUp
           tst.b      (m_flying)                    ; Check to see if
           bne        walkingLeft                   ; If not, must be
           lea.l      flyingLeft,a1                 ; Pointer to the sprite control words
           move.l     a1,d0
           move.l     d0,animationFrame             ; Update the frame
           bra        updateLeft
walkingLeft:
           lea.l      flyingLeft,a1                 ; Pointer to the sprite control words
           move.l     a1,d0
           move.l     d0,animationFrame             ; Update the frame
updateLeft:
           clr.l      d1
           move.b     m_x,d1                        ; Store the x position into d1
           cmp        #$40,d1                       ; Check to see if the position is @ #$40
           ble        moveUp                        ; Branch if its greater than or equal to
           sub.b      #1,m_x                        ; Decrement x by 1

moveUp:
           tst.b      (m_up)
           bne        moveDown
           tst.b      (m_flying)
           bne        moveDown
           clr.l      d1
           move.b     m_yTop,d1                     ; Store the y position into d1
           cmp        #$30,d1                       ; Check to see if the position is @ #$f0
           blo        moveDown                      ; Branch if its greater than or equal to
           sub.b      #1,m_yTop                     ; Decrement the top y position by 1
           sub.b      #1,m_yBottom                  ; Decrement the bottom y position by 1

moveDown:
           tst.b      (m_down)
           bne        updateComplete
           tst.b      (m_flying)
           bne        updateComplete
           clr.l      d1
           move.b     m_yTop,d1                     ; Store the y position into d1
           cmp        #$e0,d1                       ; Check to see if the position is @ #$e0
;  bgt        updateComplete       ; Branch if its greater than or equal to
           bgt        walking                       ; Branch if its greater than or equal to
           add.b      #1,m_yTop                     ; Increment the top y position by 1
           add.b      #1,m_yBottom                  ; Increment the bottom y position by 1
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

;****************************************************************** END of jetman.asm ***********************************************

;****************************************************************** START of jetman_data.asm ***********************************************
           Section    ChipRAM,Data_c

flyingRight:
sprite1:
	;dc.w $108c,$2f00
           dc.w       $508c,$6400
           dc.w       $0000,$0000                   ; Sprite 1 - flying facing right
           dc.w       $0FC0,$0FC0
           dc.w       $0E00,$1FC0
           dc.w       $2C00,$3FC0
           dc.w       $2E00,$3FC0
           dc.w       $6FC0,$6FC0
           dc.w       $6780,$6780
           dc.w       $7700,$7700
           dc.w       $7780,$77B0
           dc.w       $7780,$77B0
           dc.w       $7400,$77FA
           dc.w       $7400,$77FA
           dc.w       $7BF0,$7BF0
           dc.w       $7BF0,$7BF0
           dc.w       $7C30,$7C30
           dc.w       $7C00,$7C30
           dc.w       $003C,$003C
           dc.w       $003C,$003C
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000

flyingLeft:
           dc.w       $508c,$6400
           dc.w       $0000,$0000
           dc.w       $03f0,$03f0
           dc.w       $0070,$03f8
           dc.w       $0034,$03fc
           dc.w       $0074,$03fc
           dc.w       $03f6,$03f6
           dc.w       $01e6,$01e6
           dc.w       $00ee,$00ee
           dc.w       $01ee,$0dee
           dc.w       $01ee,$0dee
           dc.w       $002e,$5fee
           dc.w       $002e,$5fee
           dc.w       $0fde,$0fde
           dc.w       $0fde,$0fde
           dc.w       $0c3e,$0c3e
           dc.w       $003e,$0c3e
           dc.w       $3c00,$3c00
           dc.w       $3c00,$3c00
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000

sprite2:
walkingRightFrameOne:
           dc.w       $508c,$6400
           dc.w       $0000,$0000                   ; 2
           dc.w       $0FC0,$0FC0
           dc.w       $0E00,$1FC0
           dc.w       $2C00,$3FC0
           dc.w       $2E00,$3FC0
           dc.w       $6FC0,$6FC0
           dc.w       $6780,$6780
           dc.w       $7700,$7700
           dc.w       $7780,$77B0
           dc.w       $7780,$77B0
           dc.w       $7400,$77FA
           dc.w       $7400,$77FA
           dc.w       $7780,$7780
           dc.w       $3780,$3780
           dc.w       $7B80,$7B80
           dc.w       $7B00,$7B00
           dc.w       $0300,$0300
           dc.w       $0300,$0300
           dc.w       $03C0,$03C0
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000

walkingLeftFrameOne:
           dc.w       $508c,$6400
           dc.w       $0000,$0000
           dc.w       $03f0,$03f0
           dc.w       $0070,$03f8
           dc.w       $0034,$03fc
           dc.w       $0074,$03fc
           dc.w       $03f6,$03f6
           dc.w       $01e6,$01e6
           dc.w       $00ee,$00ee
           dc.w       $01ee,$0dee
           dc.w       $01ee,$0dee
           dc.w       $002e,$5fee
           dc.w       $002e,$5fee
           dc.w       $01ee,$01ee
           dc.w       $01ec,$01ec
           dc.w       $01de,$01de
           dc.w       $00de,$00de
           dc.w       $00c0,$00c0
           dc.w       $00c0,$00c0
           dc.w       $03c0,$03c0
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000

sprite3:
           dc.w       $508c,$6400
           dc.w       $0000,$0000                   ; 3
           dc.w       $0E00,$1FC0
           dc.w       $2C00,$3FC0
           dc.w       $2E00,$3FC0
           dc.w       $6FC0,$6FC0
           dc.w       $6780,$6780
           dc.w       $7700,$7700
           dc.w       $7780,$77B0
           dc.w       $7780,$77B0
           dc.w       $7400,$77FA
           dc.w       $7400,$77FA
           dc.w       $7780,$7780
           dc.w       $3780,$3780
           dc.w       $7B80,$7B80
           dc.w       $7B80,$7B80
           dc.w       $06C0,$06C0
           dc.w       $0CC0,$0CC0
           dc.w       $0FF0,$0FF0
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000

walkingLeftFrameTwo:
           dc.w       $508c,$6400
           dc.w       $0000,$0000
           dc.w       $0070,$03f8
           dc.w       $0034,$03fc
           dc.w       $0074,$03fc
           dc.w       $03f6,$03f6
           dc.w       $01e6,$01e6
           dc.w       $00ee,$00ee
           dc.w       $01ee,$0dee
           dc.w       $01ee,$0dee
           dc.w       $002e,$5fee
           dc.w       $002e,$5fee
           dc.w       $01ee,$01ee
           dc.w       $01ec,$01ec
           dc.w       $01de,$01de
           dc.w       $01de,$01de
           dc.w       $0360,$0360
           dc.w       $0330,$0330
           dc.w       $0ff0,$0ff0
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000


sprite4:
           dc.w       $508c,$6400
           dc.w       $0000,$0000                   ; 4
           dc.w       $0FC0,$0FC0
           dc.w       $0E00,$1FC0
           dc.w       $2C00,$3FC0
           dc.w       $2E00,$3FC0
           dc.w       $6FC0,$6FC0
           dc.w       $6780,$6780
           dc.w       $7700,$7700
           dc.w       $7780,$77B0
           dc.w       $7780,$77B0
           dc.w       $7400,$77FA
           dc.w       $7400,$77FA
           dc.w       $7780,$7780
           dc.w       $3780,$3780
           dc.w       $7B80,$7B80
           dc.w       $7BC0,$7BC0
           dc.w       $0E60,$0E60
           dc.w       $3C60,$3C60
           dc.w       $3878,$3878
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000

walkingLeftFrameThree:
           dc.w       $508c,$6400
           dc.w       $0000,$0000
           dc.w       $03f0,$03f0
           dc.w       $0070,$03f8
           dc.w       $0034,$03fc
           dc.w       $0074,$03fc
           dc.w       $03f6,$03f6
           dc.w       $01e6,$01e6
           dc.w       $00ee,$00ee
           dc.w       $01ee,$0dee
           dc.w       $01ee,$0dee
           dc.w       $002e,$5fee
           dc.w       $002e,$5fee
           dc.w       $01ee,$01ee
           dc.w       $01ec,$01ec
           dc.w       $01de,$01de
           dc.w       $03de,$03de
           dc.w       $0670,$0670
           dc.w       $063c,$063c
           dc.w       $1e1c,$1e1c
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000

sprite5:
           dc.w       $508c,$6400
           dc.w       $0000,$0000                   ; 5
           dc.w       $0FC0,$0FC0
           dc.w       $0E00,$1FC0
           dc.w       $2C00,$3FC0
           dc.w       $2E00,$3FC0
           dc.w       $6FC0,$6FC0
           dc.w       $6780,$6780
           dc.w       $7700,$7700
           dc.w       $7780,$77B0
           dc.w       $7780,$77B0
           dc.w       $7400,$77FA
           dc.w       $7400,$77FA
           dc.w       $7780,$7780
           dc.w       $3780,$3780
           dc.w       $7B80,$7B80
           dc.w       $7B80,$7B80
           dc.w       $0780,$0780
           dc.w       $06C0,$06C0
           dc.w       $0CC0,$0CC0
           dc.w       $0FE0,$0FE0
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000

walkingLeftFrameFour:
           dc.w       $508c,$6400
           dc.w       $0000,$0000
           dc.w       $03f0,$03f0
           dc.w       $0070,$03f8
           dc.w       $0034,$03fc
           dc.w       $0074,$03fc
           dc.w       $03f6,$03f6
           dc.w       $01e6,$01e6
           dc.w       $00ee,$00ee
           dc.w       $01ee,$0dee
           dc.w       $01ee,$0dee
           dc.w       $002e,$5fee
           dc.w       $002e,$5fee
           dc.w       $01ee,$01ee
           dc.w       $01ec,$01ec
           dc.w       $01de,$01de
           dc.w       $01de,$01de
           dc.w       $01e0,$01e0
           dc.w       $0360,$0360
           dc.w       $0330,$0330
           dc.w       $07f0,$07f0
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000

jetmanColours:


blanksprite:
           dc.w       $0000,$0000

sprite_y:				; here the y of the sprite is stored
           dc.b       1                             ; amount to move the sprite by
           dc.b       0

sprite_x:				; here the x of the sprite is stored
           dc.b       1                             ; amount to move the sprite by
           dc.b       0

current_x:
           dc.b       0
           dc.b       0

current_y:
           dc.b       1
           dc.b       0

           CNOP       0,4

 ;****************************************************************** END of jetman_data.asm ***********************************************
  ;****************************************************************** start of meteor.asm ***********************************************

           Section    ChipRAM,Data_c

;          <- - - - 16 bits - - - - ->
;          ___________________________  __
;      |  |                           |   |    Each group of words
;         |      VSTART, HSTART       |   |    defines one vertical
;      |  |---------------------------|   |    usage of a sprite.
;         |    VSTOP, control bits    |   |--- Each one contains the
;      |  |___________________________|   |    starting location and
;                                         |    physical appearance
;      |   ___________________________  - | -  of this sprite image.

metOne:
           dc.w       $608c,$6c00
           dc.w       $0810,$0000                   ; Data_1
           dc.w       $1e80,$0000
           dc.w       $2fa4,$0000
           dc.w       $43da,$0000
           dc.w       $b9e4,$0000
           dc.w       $c7f7,$0000
           dc.w       $9fc9,$0000
           dc.w       $c7e4,$0000
           dc.w       $718a,$0000
           dc.w       $3740,$0000
           dc.w       $1f40,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000

;  dc.w       $0000,$0480
;  dc.w       $0000,$0FC0
;  dc.w       $0000,$1B60
;  dc.w       $0000,$1B60
;  dc.w       $0000,$3FD0
;  dc.w       $0000,$7A48
;  dc.w       $0000,$7FE8
;  dc.w       $0000,$7FFC
;  dc.w       $0000,$7FF8
;  dc.w       $0000,$3FF0
;  dc.w       $0000,$17A0
;  dc.w       $0000,$0840
;  dc.w       $0000,$0000

meteorOneX:
           dc.b       0
           dc.b       0

meteor_y:
           dc.b       0
           dc.b       0

metTwo:
           dc.w       $506c,$6000
           dc.w       $0248,$0000                   ; Data_2
           dc.w       $2958,$0000
           dc.w       $57d6,$0000
           dc.w       $fffa,$0000
           dc.w       $7ffc,$0000
           dc.w       $f99f,$0000
           dc.w       $366c,$0000
           dc.w       $766f,$0000
           dc.w       $f99e,$0000
           dc.w       $7ffc,$0000
           dc.w       $bfb2,$0000
           dc.w       $2ff0,$0000
           dc.w       $1768,$0000
           dc.w       $2250,$0000
           dc.w       $0000,$0000
           dc.w       $0000,$0000

meteorTwoX:
           dc.b       0
           dc.b       0

; metThree:
;   dc.w       $505c,$5c00
;   dc.w       $0000,$0400
;   dc.w       $0000,$1550
;   dc.w       $0000,$7ff0
;   dc.w       $0000,$7ff8
;   dc.w       $0000,$3ff8
;   dc.w       $0000,$fb78
;   dc.w       $0000,$3df0
;   dc.w       $0000,$fdf0
;   dc.w       $0000,$7b78
;   dc.w       $0000,$3ff8
;   dc.w       $0000,$5ff8
;   dc.w       $0000,$1ff0
;   dc.w       $0000,$1fe0
;   dc.w       $0000,$1d90
;   dc.w       $0000,$0000
;   dc.w       $0000,$0000

; meteorThreeX:
;   dc.b       0
;   dc.b       0

; metFour:
;   dc.w       $508c,$5c00
;   dc.w       $0300,$0000
;   dc.w       $0680,$0000
;   dc.w       $0780,$0000
;   dc.w       $0780,$0000
;   dc.w       $0480,$0000
;   dc.w       $7ff8,$0000
;   dc.w       $54ec,$0000
;   dc.w       $74fc,$0000
;   dc.w       $7ff8,$0000
;   dc.w       $2ec0,$0000
;   dc.w       $0780,$0000
;   dc.w       $0480,$0000
;   dc.w       $0780,$0000
;   dc.w       $0380,$0000
;   dc.w       $0000,$0000
;   dc.w       $0000,$0000

; meteorFourX:
;   dc.b       0
;   dc.b       0

; metFive:
;   dc.w       $508c,$5c00
;   dc.w       $0000,$0000
;   dc.w       $0000,$0000
;   dc.w       $1c00,$0000
;   dc.w       $3f80,$0000
;   dc.w       $63e0,$0000
;   dc.w       $fff8,$0000
;   dc.w       $ff80,$0000
;   dc.w       $cd80,$0000
;   dc.w       $fff8,$0000
;   dc.w       $63f8,$0000
;   dc.w       $3f80,$0000
;   dc.w       $1c00,$0000
;   dc.w       $1000,$0000
;   dc.w       $0000,$0000
;   dc.w       $0000,$0000
;   dc.w       $0000,$0000

; meteorFiveX:
;   dc.b       0
;   dc.b       0

; metSix:
;   dc.w       $608c,$6c00
;   dc.w       $0000,$0480
;   dc.w       $0000,$0FC0
;   dc.w       $0000,$1B60
;   dc.w       $0000,$1B60
;   dc.w       $0000,$3FD0
;   dc.w       $0000,$7A48
;   dc.w       $0000,$7FE8
;   dc.w       $0000,$7FFC
;   dc.w       $0000,$7FF8
;   dc.w       $0000,$3FF0
;   dc.w       $0000,$17A0
;   dc.w       $0000,$0840
;   dc.w       $0000,$0000

; meteorSixX:
;   dc.b       0
;   dc.b       0

; metSeven:
;   dc.w       $508c,$5c00
;   dc.w       $0000,$0000
;   dc.w       $1c00,$1c00
;   dc.w       $4fc0,$4fc0
;   dc.w       $7fb0,$7fb0
;   dc.w       $4700,$4700
;   dc.w       $1fc0,$1fc0
;   dc.w       $0000,$0000
;   dc.w       $0000,$0000

; meteorSevenX:
;   dc.b       0
;   dc.b       0

; metEight:
;   dc.w       $508c,$5c00
;   dc.w       $0000,$0200
;   dc.w       $0000,$0f80
;   dc.w       $0000,$1fc0
;   dc.w       $0000,$7ff0
;   dc.w       $0000,$fff8
;   dc.w       $0000,$7ff0
;   dc.w       $0000,$3fe0
;   dc.w       $0000,$0000

; meteorEightX:
;   dc.b       0
;   dc.b       0

; ;	CNOP 0,4
; ;	CNOP 0,4

 ;****************************************************************** END of meteor.asm ***********************************************
 ;****************************************************************** start of ROCKET.asm ***********************************************


           Section    ChipRAM,Data_c

rocketOnePartOne:
           dc.w       $705c,$8000
           dc.w       $1800,$1800                   ; RData_1
           dc.w       $1800,$1800
           dc.w       $2c00,$2c00
           dc.w       $2c00,$2c00
           dc.w       $5e00,$5e00
           dc.w       $5e00,$5e00
           dc.w       $9f00,$9f00
           dc.w       $8100,$8100
           dc.w       $9f00,$9f00
           dc.w       $9f00,$9f00
           dc.w       $9f00,$9f00
           dc.w       $9f00,$9f00
           dc.w       $9f00,$9f00
           dc.w       $9500,$9500
           dc.w       $9500,$9500
           dc.w       $9500,$9500

rocketOnePartOneX:
           dc.b       0
rocketOnePartOneY:
           dc.b       0
           CNOP       0,4

rocketOnePartTwo:
           dc.w       $5396,$6300
           dc.w       $0910,$0910                   ; RData_2
           dc.w       $09f0,$09f0
           dc.w       $09b0,$09b0
           dc.w       $0930,$0930
           dc.w       $09b0,$09b0
           dc.w       $1918,$1918
           dc.w       $19f8,$19f8
           dc.w       $29fc,$29fc
           dc.w       $29f4,$29f4
           dc.w       $59f6,$59f6
           dc.w       $59f6,$59f6
           dc.w       $89f1,$89f1
           dc.w       $b9f7,$b9f7
           dc.w       $b9f7,$b9f7
           dc.w       $b9f7,$b9f7
           dc.w       $b9f7,$b9f7

rocketOnePartTwoX:
           dc.b       0
rocketOnePartTwoY:
           dc.b       0
           CNOP       0,4

rocketOnePartThree:
           dc.w       $da84,$ea00
           dc.w       $b9f7,$b9f7                   ; RData_3
           dc.w       $b9f7,$b9f7
           dc.w       $b9f7,$b9f7
           dc.w       $b9f7,$b9f7
           dc.w       $f9ff,$f9ff
           dc.w       $a9f5,$a9f5
           dc.w       $a9f5,$a9f5
           dc.w       $aff5,$aff5
           dc.w       $f42f,$f42f
           dc.w       $f5ef,$f5ef
           dc.w       $55ea,$55ea
           dc.w       $52ca,$52ca
           dc.w       $8991,$8991
           dc.w       $b997,$b997
           dc.w       $b817,$b817
           dc.w       $b817,$b817

rocketOnePartThreeX:
           dc.b       0
rocketOnePartThreeY
           dc.b       0
           CNOP       0,4


 ;****************************************************************** start of ROCKET.asm ***********************************************