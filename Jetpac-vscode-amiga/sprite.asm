    section flashtro,code_c
        
    jmp        begin
    
    INCLUDE    Dev:Jetpac/input.asm
    INCLUDE    Dev:Jetpac/jetman.asm

begin:
    move.l 4.w,a6                             ; Get base of exec lib
    lea gfxName(pc),a1                        ; Adress of gfxlib string to a1
    jsr -408(a6)                              ; Call OpenLibrary()
    move.l d0,gfxBase                         ; Save base of graphics.library
    move.l #copperBuffer,$dff080              ; Set new copperlist
     move.w     #$4000,$dff09a
;     move.w     #$01a0,$dff096
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
;     move.w     #$81a0,$dff096
     move.w     #$81ff,$dff096
;     bsr        extractLevelBitplaneInformation

mainloop:
  ; Check if either mouse button/joystick 1 or 2 pressed, if so exit
     btst.b     #6,$bfe001
;  bne        mainloop
     beq        exit
;   btst.b #7,$bfe001
;   beq exit

wait:
     move.l     $dff004,d0
     asr.l      #8,d0
     and.l      #$1ff,d0
     cmp.w      #0,d0
     bne        wait

wait2:
     move.l     $dff004,d0
     asr.l      #8,d0
     and.l      #$1ff,d0
     cmp.w      #1,d0
     bne        wait2

     bsr        updateJetman

     move.w     $dff00e,d0
     cmp.w      #$85fe,d0                     ;Test for collsion between Jet Man & 2nd rocket piece
     bne        continue
     
     btst       #10,$dff00e                   ;CLXDAT
     beq        continue
     clr.l      d0

continue:
     bsr        checkJoystick
;;  bsr animateSprite
;   bsr updateJetman
;    bsr movesprite

     bsr        doublebuffer
     bra        mainloop

exit
     move.w     #$0080,$dff096
     move.l     $04,a6
     move.l     156(a6),a1
     move.l     38(a1),$dff080
     move.w     #$8080,$dff096
     move.w     #$c000,$dff09a
     moveq      #0,d0
     rts

gfxName:    dc.b    "graphics.library", 0, 0
gfxBase:    dc.l    0
oldView:    dc.l    0
oldInt:     dc.w    0
oldDMA:     dc.w    0

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
beg  nop
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
     move.l     #$01060000,(a6)+             ; AGA compatible
     move.l     #$01fc0000,(a6)+

    ;sprite2
     lea.l      animationFrame,a1            ; Store the address of the Jetman data into a1
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

;
;******************************************************************
;

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

     include    Dev:Jetpac/jetman_data.asm
     include    Dev:Jetpac/meteor.asm
     include    Dev:Jetpac/rocket_data.asm

copperBuffer:
     dc.l       0

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
     incbin     "Dev:Jetpac/background_224x224.raw"

     end
