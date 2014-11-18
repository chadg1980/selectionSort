TITLE Select Sort     (prog05.asm)

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
RULE1				equ<"This program generats random number from 100 to 999",0>
RULE2				equ<"then displays the random list, sorts the list, ",0>
RULE3				equ<"finds the median value, Then displays the list in descending order", 0>
RULE4				equ<"as well as the median value.", 0>
USERDATA			equ<"Choose the amount of random integers you want 10 to 200: ", 0>
NOGO				equ<"That is a No Go! Try Again!",0>
PLACEHOLD			equ<"FIX ME.....................",0>


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
	showRule4			BYTE		RULE4
	
	showGetData			BYTE		USERDATA
	showNoGo			BYTE		NOGO
	showPlace			BYTE		PLACEHOLD

	arraySize			DWORD		?		;User inputs the number of ints they want



.code
main PROC
	call randomize
	call	intro

	push	OFFSET arraySize	;pass arraySize by reference
	call	getData
	
	push	arraySize			; pass arraySize by value
	call	fillArray
	call	sortList
	call	displayMedian
	call	displayList

exit	; exit to operating system

main ENDP



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
		
	mov		EDX, OFFSET showrule1
		call	WriteString
		call	CRLF
	mov		EDX, OFFSET showrule2
		call	WriteString
		call	CRLF	
	mov		EDX, OFFSET showrule3
		call	WriteString
		call	CRLF
	mov		EDX, OFFSET showrule4
		call	WriteString
		call	CRLF
		call	CRLF
		call	CRLF
		ret
	intro ENDP





	;-----------GET DATA PROC-----------
;Procedure to Get user input for the amount of ints in the list
;	Which will be the size of the array. Between 10 and 200.
;	The data will be validated in this procedure 
;receives: address of arraySize
;returns: The users input for the amount of ints in the list
;preconditions:  none
;registers changed: EAX, EBX, EDX, EIP, EFL, ESP

getData proc
	push	EBP
	mov		EBP, ESP				;return call +0, ArraySize[+8]
	;get int from the user
	mov		EBX, [ebp + 8]			; get address of arraySize
	mov		EDX, OFFSET showGetData	;Prompt user for input
	call	WriteString
	call	readint
	mov		[EBX], EAX				;Store the value in arraySize
	
	pop		EBP
	ret		4
getData	ENDP

;-----------Fill Array PROC-----------
;Procedure to Fill the array with Random Numbers.				FIX ME!
;receives: arraySize
;returns: none
;preconditions:  none
;registers changed: EDX, EIP, EFL
	
	fillArray proc
	push	EBP
	mov		EBP, ESP

	mov		EAX, [EBP + 8]
	call	writeDec
	call	CRLF
	
	mov		EDX, OFFSET showPlace	
		call	WriteString
		call	CRLF
		call	CRLF
		call	CRLF
	pop		EBP
	ret		4
	fillArray ENDP


;-----------Sort List PROC-----------
;Procedure to sort the array							FIX ME!
;receives: none
;returns: none
;preconditions:  none
;registers changed: EDX, EIP, EFL
	
	sortList proc
	mov		EDX, OFFSET showPlace	
		call	WriteString
		call	CRLF
		call	CRLF
		call	CRLF

		ret
	sortList ENDP

	
;-----------Display Median PROC-----------
;Procedure to calculate and display the list median							FIX ME!
;receives: none
;returns: none
;preconditions:  none
;registers changed: EDX, EIP, EFL
	
	displayMedian proc
	mov		EDX, OFFSET showPlace	
		call	WriteString
		call	CRLF
		call	CRLF
		call	CRLF

		ret
	displayMedian ENDP
	
	
;-----------Display List PROC-----------
;Procedure to  Display the list to the console						FIX ME!
;receives: none
;returns: none
;preconditions:  none
;registers changed: EDX, EIP, EFL
	
	displayList proc
	mov		EDX, OFFSET showPlace	
		call	WriteString
		call	CRLF
		call	CRLF
		call	CRLF

		ret
	displayList ENDP





END main
