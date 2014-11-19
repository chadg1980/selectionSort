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
UNSORTED			equ<"Unsorted Number List: ",0>
SORTED				equ<"Sorted Number List: ",0>
THEMEDIAN			equ<"The median: ",0>

MIN					=	10
MAX					=	200
LOWNUM				=	100
HINUM				=	999



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

	showUnsorted		BYTE		UNSORTED
	showsorted			BYTE		SORTED
	showmedian			BYTE		THEMEDIAN
	
	arraySize			DWORD		?		;User inputs the number of ints they want
	numberList			DWORD		MAX DUP(?)

	;tens				DWORD		0		;counter to add a new line every ten integers

;---------------MAIN PROC-----------
.code
main PROC
	call	randomize
	call	intro

		push	OFFSET arraySize	;pass arraySize by reference
	call	getData
	
		push	OFFSET numberList	; First element of the array passed by reference
		push	arraySize			; pass arraySize by value
	call	fillArray
	
		mov		EDX, offset showUnsorted	;"Unsorted Number List: "
			call	WriteString				; Stating that before the call
			call	CRLF
		push	OFFSET numberList	; First element of the array passed by reference
		push	arraySize			; pass arraySize by value
	call	displayList
	
		push	OFFSET numberList	; First element of the array passed by reference
		push	arraySize			; pass arraySize by value
	call	sortList
	
	
	call	displayMedian

	mov		EDX, offset showSorted
		call	WriteString
		call	CRLF
	push	OFFSET numberList	; First element of the array passed by reference
	push	arraySize			; pass arraySize by value
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
	mov		EBP, ESP				
	;get int from the user
	mov		EBX, [EBP + 8]			; get address of arraySize
tryAgain:
	mov		EDX, OFFSET showGetData	;Prompt user for input
	call	WriteString
	call	readint
	mov		[EBX], EAX				;Store the value in arraySize
	
	cmp		EAX, MIN
	JGE		goOver
	mov		EDX, OFFSET	showNoGo
		call	WriteString
		call	CRLF
	jmp		tryAgain

goOver:
	cmp		EAX, MAX
	JLE		goOut
	mov		EDX, OFFSET	showNoGo
		call	WriteString
		call	CRLF
	jmp		tryAgain

goOut:
	pop		EBP
	ret		4
getData	ENDP

;-----------Fill Array PROC-----------
;Procedure to Fill the array with Random Numbers.				
;receives: arraySize, by value and Numberlist by Reference
;returns: The array filled with random numbers in a random order
;preconditions:  arraySize is entered by the user and within range
;registers changed: EAX, EDX, EBX, EIP, EFL
; I grabbed some code for this from Assembly Language for the x86 Processpr (6th edition)
;page 283 (I started on my own, but it looked similar, so I might as well site it)


;NumberList		[EBP + 12]
;arraySize		[EBP + 8]
;return address [EBP + 4]
;EBP			[0]
fillArray proc
	push	EBP				
	mov		EBP, ESP

	mov		ECX, [EBP + 8]					;Counter, arraySize 
	mov		ESI, [EBP+12]					;First element of the array
TOL:
	mov		EAX, [HINUM	- LOWNUM +1]		;This is from the book
	call	RandomRange						;Assembly Language for the x86 Processpr (6th edition)
	mov		[ESI], EAX						;Page 284 RandomRange is a library function call
	add		ESI, 4							;Move to the next array element (DWORD = 4)
loop tol									;tol(top of loop)
	
	
	pop		EBP
	ret		8
	fillArray ENDP


;-----------Sort List PROC-----------
;Procedure to sort the array							FIX ME!
;receives: none
;returns: none
;preconditions:  none
;registers changed: EDX, EIP, EFL

;NumberList		[EBP + 12]
;arraySize		[EBP + 8]
;return address [EBP + 4]
;EBP			[0]	
	sortList proc
	
	push	EBP				
	mov		EBP, ESP
	
	
	
	
	mov		EDX, OFFSET showPlace	
		call	WriteString
		call	CRLF
		call	CRLF
		call	CRLF
	
	
	
	pop		EBP
	ret		8
	
	sortList ENDP

	
;-----------Display Median PROC-----------
;Procedure to calculate and display the list median							FIX ME!
;receives: none
;returns: none
;preconditions:  none
;registers changed: EDX, EIP, EFL
	
	displayMedian proc
	push	EBP				
	mov		EBP, ESP

	mov		EDX, OFFSET showMedian	
		call	WriteString
		call	CRLF
	mov		EDX, OFFSET showPlace	
		call	WriteString
		call	CRLF
		call	CRLF
		call	CRLF
	
	pop		EBP
		ret	4
	displayMedian ENDP
	
	
;-----------Display List PROC-----------
;Procedure to  Display the list to the console				
;receives: 
;returns: arraySize by value, and the first element of the array numberList
;preconditions:  NumberList is filled in, arraySize is an int within range
;registers changed: EAX, EDX, EIP, EFL, EBP, ESI


;NumberList		[EBP + 20]
;arraySize		[EBP + 16]
;ten			[EBP - 4] I do not know why adding a local variable adds so much???
;return address [EBP + 4] I am looking at page 287 of 6th edition, 
;EBP			[0]
	displayList proc
		local tens:DWORD ;local var, to count to 10, I need a line every 10 elements

	push	EBP				
	mov		EBP, ESP
	
	mov		ECX, [EBP + 16]					;Counter, arraySize 
	mov		ESI, [EBP+20]					;Memory of the first element of the array
	
	mov		tens, 0							;before the loop, tens gets 0.
	


displayL:
	mov		AL, 20h						;Blank for readability
	call	writeChar
	call	writeChar
	call	writeChar

	mov		EAX, [ESI]					;put the array element in EAX to be dispayed
	call	WriteDec
	add		ESI, 4						;go to the next element in the array
	
	inc		tens						;increment the counter
	mov		EAX, tens					;Check for the 10th element
	cdq									;DIVIDE, if no remainder add a line
	mov		EBX, 10
	div		EBX
		cmp		EDX, 0
		JNZ		noLine
		call	CRLF					;add a new line if a miltiple of 10
	noLine:
		
loop displayL
	call	CRLF						;Blank line for seperation on console
	call	CRLF
	
	
	pop		EBP
		ret	8
	displayList ENDP





END main
