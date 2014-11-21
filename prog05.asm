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
	numberList			DWORD		MAX dup(?)

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
	
	push	OFFSET	showUnsorted
	push	OFFSET numberList	; First element of the array passed by reference
	push	arraySize			; pass arraySize by value
	call	displayList
		
	push	OFFSET numberList	; First element of the array passed by reference
	push	arraySize			; pass arraySize by value
	call	sortList
	
	push	OFFSET numberList	; First element of the array passed by reference
	push	arraySize			; pass arraySize by value
	call	displayMedian
	
	push	OFFSET	showSorted	;
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
	mov		EDX, OFFSET showTitle	;Displays the title with the authors name
		call	WriteString
		call	CRLF
		call	CRLF
		
	mov		EDX, OFFSET showrule1	;Displays what the program does as well as the 
		call	WriteString			; range of input for the user
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
	call	readint					;Store the value in arraySize
	mov		[EBX], EAX				;in the memory location of EBX
					
	cmp		EAX, MIN
	JGE		goOver					;Data validation loop
	mov		EDX, OFFSET	showNoGo	;Shows a message if the number is not in range
	call	WriteString
	call	CRLF
	jmp		tryAgain				;IF the data is not in range, jump to tryAgain
									;to get another input
goOver:
	cmp		EAX, MAX
	JLE		goOut
	mov		EDX, OFFSET	showNoGo
	call	WriteString
	call	CRLF
	jmp		tryAgain

goOut:
	call	CRLF					;line
	pop		EBP						;prepare to return	
	ret		4						;return
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
	mov		EAX, [HINUM - LOWNUM]			;This is from the book
 	call	RandomRange				;Assembly Language for the x86 Processpr (6th edition)
	add		EAX, LOWNUM
	mov		[ESI], EAX						;Page 284 RandomRange is a library function call
	add		ESI, 4							;Move to the next array element (DWORD = 4)
loop tol									;tol(top of loop)
	
	
	pop		EBP
	ret		8
	fillArray ENDP


;-----------Sort List PROC-----------
;Procedure to sort the array		
;receives: ArraySize by value and the offset of the first element of NumberList
;returns: A sorted array in NumberList
;preconditions: NumberList is filled with valid numbers
;registers changed: EAX, EBX, ECX, EDX, ESI, EIP, EFL

;NumberList		[EBP + 24]
;arraySize		[EBP + 20]
;return address [EBP + 4]
;EBP			[0]	
;k				[EBP - 4]
;j				[EBP - 8]
	sortList proc
		local k:DWORD
		local j:DWORD
		

	push	EBP				
	mov		EBP, ESP
	
	mov		ESI, [EBP + 24]					;First element of the array
	mov		k, 0
	mov		EBX, k
		
outer:
	
	mov		k, EBX
	mov		j, EBX				
	mov		EBX, 0
	
inner:
	mov		EAX, 4
	add		EAX, EBX
	mov		EBX, EAX
	mov		EAX, [ESI]				;first value
	
	mov		EDX, [ESI + EBX]		;second value
	cmp		EAX, EDX				;compare for desending order
	jge noSwap						
	
	mov		[ESI], EDX					;Swap, values stored in registers go in the
	mov		[ESI+EBX], EAX				;other array value location
	
	
noSwap:
	inc		j							;inner loop counter
	mov		ECX, [EBP + 20]					;When I pushed and popped ECX I overwrote my 
	cmp		j, ECX							;local variables so I just called arraySize here
jl		inner
	

	inc		k							;outer loop counter
	mov		ECX, [EBP + 20]				;counter for array size
	mov		EBX, k
	add		ESI, 4
	mov		EAX, ECX
	DEC		EAX
	cmp		EBX, EAX
jl	outer
	
	
	pop		EBP
	ret		8			
	
	sortList ENDP

	
;-----------Display Median PROC-----------
;Procedure to calculate and display the list median							FIX ME!
;receives: arraySize by value, and numberList (first element) by reference
;returns: none
;preconditions:  numberlist in in order
;registers changed: EAX, EBX, ECX, EDX, EBP, EIP, EFL
	
;NumberList		[EBP + 12]
;arraySize		[EBP + 8]


	displayMedian proc
	push	EBP				
	mov		EBP, ESP
	mov		EDX, OFFSET	showMedian			;Print the header
	call	WriteString
	call	CRLF

	mov		ESI, [EBP + 12]					;First element of the array
	mov		EDX, [EBP + 8]					;arraySize
	mov		EAX, EDX
	mov		EBX, 2
	mov		EDX, 0
	div		EBX
	cmp		EDX, 0
JNZ		oddNum

mov		ECX, EAX
evenloop:
	
	add		ESI, 4
loop evenloop
	
	mov		EAX, [ESI]
	add		EAX, [ESI - 4]

	mov		EBX, 2
	mov		EDX, 0
	DIV		EBX

	mov		EBX, EDX		;added this part from prog 4, if the division is .5 or greater
	shr		EDX, 1			;I can do the average, not just throw out past dec
	cmp		EDX, EBX		; shift bits to the right and compare
JGE		display
	inc		EAX				;increment if .5 or greater

display:
	
	call writeDEC
	call CRLF

jmp exiting


	oddNum:
	mov		ECX, EAX
addloop:
	
	add		ESI, 4
loop addloop
	
	mov		EAX, [ESI]
	call	WriteDec
	call	CRLF
	

exiting:	
call	CRLF
	pop		EBP
	ret	8
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
		local tens:DWORD  ;local var, to count to 10, I need a line every 10 elements

	push	EBP				
	mov		EBP, ESP
	
	mov		ECX, [EBP + 16]					;Counter, arraySize 
	mov		ESI, [EBP + 20]					;Memory of the first element of the array
	mov		EDX, [EBP + 24]					;Memory of title
	call	WriteString
	Call	CRLF
	
	mov		tens, 0							;before the loop, tens gets 0.
	push	tens


displayL:
	mov		AL, 20h						;Blank for readability
	call	writeChar
	call	writeChar
	call	writeChar

	mov		EAX, [ESI]					;put the array element in EAX to be dispayed
	call	WriteDec
	add		ESI, 4						;go to the next element in the array
	
	pop		tens
	inc		tens						;increment the counter
	mov		EAX, tens					;Check for the 10th element
	push	tens
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
	
	pop		tens
	pop		EBP
		ret	12
	displayList ENDP



END main
