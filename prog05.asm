TITLE Program Template     (template.asm)

; Chad H. Glaser:
; CS 271 / Prog05 Selection Sort                 Date: 11/17/2014
; Description:
;	This program will introduce the program, Get s user request in the range
; of 10 to 200, generate random numbers from 100 to 999
; store those numbers in an array, display the list integers, 10 per line
; sort the integers biggest to smallest
; calculate and display the median value, rounded to the nearest int
; Display the sorted list, 10 per line

INCLUDE Irvine32.inc

; (insert constant definitions here)
TITLE_SCREEN		equ<"		Select Sort by CHAD H. GLASER",0 >
RULE1				equ<"The min and max",0>
RULE2				equ<"How many numbers do you want to display?",0>
RULE3				equ<"What range do you want the numbers to be in?", 0>
USERDATA				equ<"I am getting data now", 0>

MIN					=	10
MAX					=	200
LOWNUM				=	100
MAX					=	999



.data

; (insert variable definitions here)
	showTitle			BYTE		TITLE_SCREEN
	showRule1			BYTE		RULE1
	showRule2			BYTE		RULE2
	showRule3			BYTE		RULE3
	showGetData			BYTE		USERDATA


.code
main PROC

; (insert executable instructions here)

	call intro
	call rules
	call getData

exit	; exit to operating system

main ENDP

; (insert additional procedures here)

;-----------INTRO PROC-----------
;Procedure to display the program and the author of the program.
;receives: none
;returns: none
;preconditions:  none
;registers changed: EDX, EIP, EFL
	
	intro proc
	mov		EDX, OFFSET showTitle
		call	WriteString
		call	CRLF
		call	CRLF
		call	CRLF

		ret
	intro ENDP


;-----------RULES PROC-----------
;Procedure to display the program and the author of the program.
;receives: none
;returns: none
;preconditions:  none
;registers changed: EDX, EIP, EFL
	
	rules proc
	mov		EDX, OFFSET showrule1
		call	WriteString
		call	CRLF
	mov		EDX, OFFSET showrule2
		call	WriteString
		call	CRLF	
	mov		EDX, OFFSET showrule3
		call	WriteString
		call	CRLF
		ret
	rules ENDP


	;-----------GET DATA PROC-----------
;Procedure to display the program and the author of the program.
;receives: none
;returns: none
;preconditions:  none
;registers changed: EDX, EIP, EFL
	
	getData proc
	mov		EDX, OFFSET showGetData	
		call	WriteString
		call	CRLF
		call	CRLF
		call	CRLF

		ret
	getData ENDP










END main
