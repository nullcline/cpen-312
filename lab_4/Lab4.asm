$MODDE0CV

;my student number
N_7 EQU #00110000b ;3
N_6 EQU #00000000b ;8
N_5 EQU #11111001b ;1
N_4 EQU #11111001b ;1
N_3 EQU #00110000b ;3
N_2 EQU #00010010b ;5
N_1 EQU #00011001b ;4
N_0 EQU #00011001b ;4

;hex for hello
L_H EQU #00001001b 
L_E EQU #00000110b
L_L EQU #01000111b
L_O EQU #01000000b

;operation modes
M_0 EQU #0000000b
M_1 EQU #0000001b
M_2 EQU #0000010b
M_3 EQU #0000011b
M_4 EQU #0000100b
M_5 EQU #0000101b
M_6 EQU #0000110b
M_7 EQU #0000111b

BLANK EQU #01111111b

ORG 0
		ljmp init
		
delay:
	mov R5, #178 ;don't use same registers as the ones we use for scrolling
L2: mov R4, #250 ; 3 cycles -> 3*30ns*250 = 22.5us, 22.5us*250 = 5.625ms, 5.625ms*178 = pretty much 1 second
L1: mov R3, #250
L0: djnz R3, L0
	djnz R4, L1
	djnz R5, L2
	ret
	
shortDelay:
	mov R5, #69 ;don't use same registers as the ones we use for scrolling
L6: mov R4, #69
L5: mov R3, #69
L4: djnz R3, L4
	djnz R4, L5
	djnz R5, L6
	ret

init: 
	mov sp, #7fh
	mov LEDRA, #0
	mov LEDRB, #0
	
	lcall mode0

mode0: ;display 6 most sig
	mov a, swa
	cjne a, M_0, mode1
	mov HEX5, N_7
	mov HEX4, N_6
	mov HEX3, N_5
	mov HEX2, N_4
	mov HEX1, N_3
	mov HEX0, N_2
	ljmp mode0

mode1: ;display 2 least sig on h1 h2
	mov a, swa
	cjne a, M_1, mode2
	mov HEX5, BLANK
	mov HEX4, BLANK
	mov HEX3, BLANK
	mov HEX2, BLANK
	mov HEX1, N_1
	mov HEX0, N_0
	ljmp mode1

mode2: ;scroll left
	mov a, swa
	cjne a, M_2, mode3
	
	; initialize 7seg
	mov HEX5, N_7
	mov HEX4, N_6
	mov HEX3, N_5
	mov HEX2, N_4
	mov HEX1, N_3
	mov HEX0, N_2
	mov R1, N_1
	mov R0, N_0
	
	lcall delay
	ljmp scrollLeft
	
scrollLeft:
	mov a, swa
	cjne a, M_2, mode3
	
	mov R2, HEX5
	mov HEX5, HEX4
	mov HEX4, HEX3
	mov HEX3, HEX2
	mov HEX2, HEX1
	mov HEX1, HEX0
	mov HEX0, R1
	mov b, R0 ;need to place the value in accumulator or something idk
	mov R1, b
	mov b, R2
	mov R0, b
	
	lcall delay
	ljmp scrollLeft
	
mode3: ;scroll right
	mov a, swa
	cjne a, M_3, mode4
	
	; initialize 7seg
	mov HEX5, N_7
	mov HEX4, N_6
	mov HEX3, N_5
	mov HEX2, N_4
	mov HEX1, N_3
	mov HEX0, N_2
	mov R1, N_1
	mov R0, N_0
	
	lcall delay
	ljmp scrollRight
	
scrollRight:
	mov a, swa
	cjne a, M_3, mode4
	
	mov R2, HEX0
	mov HEX0, HEX1
	mov HEX1, HEX2
	mov HEX2, HEX3
	mov HEX3, HEX4
	mov HEX4, HEX5
	mov HEX5, R0
	mov b, R1
	mov R0, b
	mov b, R2
	mov R1, b
	
	lcall delay
	ljmp scrollRight
	
mode4: ;blink 6 least
	mov a, swa
	cjne a, M_4, mode5
	
	mov HEX5, N_5
	mov HEX4, N_4
	mov HEX3, N_3
	mov HEX2, N_2
	mov HEX1, N_1
	mov HEX0, N_0
	
	mov a, swa
	cjne a, M_4, mode5
	lcall delay
	
	mov HEX5, BLANK
	mov HEX4, BLANK
	mov HEX3, BLANK
	mov HEX2, BLANK
	mov HEX1, BLANK
	mov HEX0, BLANK
	
	lcall delay
	ljmp mode4

	
mode5: ;1 12 123 1234 type beat 
	lcall check5 ;use this long call cause my mode5 is so dummy thicc
	
	mov HEX5, BLANK
	mov HEX4, BLANK
	mov HEX3, BLANK
	mov HEX2, BLANK
	mov HEX1, BLANK
	mov HEX0, BLANK
	
	lcall check5
	lcall delay
	
	mov HEX5, N_7
	mov HEX4, BLANK
	mov HEX3, BLANK
	mov HEX2, BLANK
	mov HEX1, BLANK
	mov HEX0, BLANK
	
	lcall check5
	lcall delay
	
	mov HEX5, N_7
	mov HEX4, N_6
	mov HEX3, BLANK
	mov HEX2, BLANK
	mov HEX1, BLANK
	mov HEX0, BLANK
	
	lcall check5
	lcall delay
	
	mov HEX5, N_7
	mov HEX4, N_6
	mov HEX3, N_5
	mov HEX2, BLANK
	mov HEX1, BLANK
	mov HEX0, BLANK
	
	lcall check5
	lcall delay
	
	mov HEX5, N_7
	mov HEX4, N_6
	mov HEX3, N_5
	mov HEX2, N_4
	mov HEX1, BLANK
	mov HEX0, BLANK
	
	lcall check5
	lcall delay
	
	mov HEX5, N_7
	mov HEX4, N_6
	mov HEX3, N_5
	mov HEX2, N_4
	mov HEX1, N_3
	mov HEX0, BLANK
	
	lcall check5
	lcall delay
	
	mov HEX5, N_7
	mov HEX4, N_6
	mov HEX3, N_5
	mov HEX2, N_4
	mov HEX1, N_3
	mov HEX0, N_2
	
	lcall delay
	ljmp mode5

check5:
	mov a, swa
	cjne a, M_5, mode6
	ret
	
mode6: ;hello -> 6 sig -> hello 
	mov a, swa
	cjne a, M_6, mode7
	 
	mov HEX5, L_H ;hello
	mov HEX4, L_E
	mov HEX3, L_L
	mov HEX2, L_L
	mov HEX1, L_O
	mov HEX0, BLANK
	
	mov a, swa
	cjne a, M_6, mode7
	lcall delay
	
	mov HEX5, N_7 ;381135
	mov HEX4, N_6
	mov HEX3, N_5
	mov HEX2, N_4
	mov HEX1, N_3
	mov HEX0, N_2
	
	mov a, swa
	cjne a, M_6, mode7
	lcall delay
	
	mov HEX5, #01000110b ;CPN312
	mov HEX4, #00001100b
	mov HEX3, #01001000b
	mov HEX2, N_7
	mov HEX1, N_5
	mov HEX0, #00100100b
	
	lcall delay
	ljmp mode6

mode7: ;chaos
	mov a, swa
	cjne a, M_7, back
		
	mov HEX5, N_5
	mov HEX4, BLANK
	mov HEX3, N_3
	mov HEX2, BLANK
	mov HEX1, N_1
	mov HEX0, BLANK
	
	mov a, swa
	cjne a, M_7, back
	lcall shortDelay
	
	mov HEX5, BLANK
	mov HEX4, N_4
	mov HEX3, BLANK
	mov HEX2, N_2
	mov HEX1, BLANK
	mov HEX0, N_0
	
	mov a, swa
	cjne a, M_7, back
	lcall shortDelay
	
	mov HEX5, N_7
	mov HEX4, BLANK
	mov HEX3, N_5
	mov HEX2, BLANK
	mov HEX1, N_3
	mov HEX0, BLANK
	
	mov a, swa
	cjne a, M_7, back
	lcall shortDelay
	
	mov HEX5, BLANK
	mov HEX4, N_6
	mov HEX3, BLANK
	mov HEX2, N_4
	mov HEX1, BLANK
	mov HEX0, N_2
	
	lcall shortDelay 
	ljmp mode7
	
back:
	ljmp mode0
	
end