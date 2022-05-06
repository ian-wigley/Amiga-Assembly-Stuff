; this routine reads the joystick and updates the values contained in the
; sprite_x and sprite_y variables

; universal sprite positioning routine.
;
; incoming parameters of unimuovisprite:
;
; a1 = address of the sprite
; d0 = vertical position y of the sprite on the screen (0-255)
; d1 = horizontal position x of the sprite on the screen (0-320)
; d2 = height of the sprite
;

checkJoystick:
           lea       m_left,a3      ; Store the address of the first bool
           move.b    #1,(a3)+       ; Reset the bools back to 1
           move.b    #1,(a3)+       ; Reset the bools back to 1
           move.b    #1,(a3)+       ; Reset the bools back to 1
           move.b    #1,(a3)+       ; Reset the bools back to 1
           move.b    #1,(a3)+       ; Reset the bools back to 1
           move.b    #1,(a3)+       ; Reset the bools back to 1
           move.b    #1,(a3)+       ; Reset the bools back to 1
           move.b    #1,(a3)+       ; Reset the bools back to 1
           move.w    $dff00c,d3     ; Store the address of joy1dat into d3
right:
           btst.l    #1,d3          ; bit 1 tells us if we go to the right
           beq.s     left           ; if it is zero, you don't go to the right
;	addq.b #1,sprite_x 	; if it is 1, move the sprite to a pixel
           clr.b     m_right
;          bsr       animateSprite    ; Update animation frame
           bra.s     up             ; go to the y check
left:
           btst.l    #9,d3          ; bit 9 tells us if you go left
           beq.s     up             ; if it is zero, you don't go left
;	subq.b #1,sprite_x 	; if it is 1 move the sprite
           clr.b     m_left
;          bsr       animateSprite    ; Update animation frame
up:
           move.w    d3,d2          ; copy the register value
           lsr.w     #1,d2          ; scrolls the bits of a place to the right
           eor.w     d2,d3          ; executes the exclusive or. now we can test
           btst.l    #8,d3          ; let's test if it goes high
           beq.s     down           ; if not, check if it goes down
;	subq.b #1,sprite_y 	; if you move the sprite
           clr.b     m_up

           move.b    #0,m_flying

           bra.s     fire
down:
           btst.l    #0,d3          ; let's test if it goes down
           beq.s     fire           ; if not finish

;;	move.b current_y,d4
;;	cmp #200,d4         ; if the current_y < 250
;;	bgt fire
;          addq.b    #1,sprite_y    ; if you move the sprite
;;	addq.b #1,current_y
           clr.b     m_down
fire:
           btst.b    #7,$bfe001
           bne       exitInput
;	subq.b #1,meteor_y 	;
           clr.b     m_fire
exitInput:
;	jmp checkJoystick
           rts

m_left:    dc.b      1,1            ;boolean;			// true if left control held
m_right:   dc.b      1,1            ;boolean;			// true if right control held
m_up:      dc.b      1,1            ;boolean;			// true if up control held
m_down:    dc.b      1,1            ;boolean;			// true if down control held
m_fire:    dc.b      1,1,0,0        ;boolean;			// true if fire control held
m_flying:  dc.b      0,0,0,0
           even