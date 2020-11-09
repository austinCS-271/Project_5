; Author: Austin Chayka
; Project name: Program #5
; Description: 
;	Gets the number of terms from the user,
;	fills and displays a list with that many random
;	numbers, and then finds the average and median
;	and sorts the list

INCLUDE irvine32.inc
INCLUDE io.inc
INCLUDE alg.inc

MIN = 16
MAX = 256
LOW_BOUNDS = 64
HIGH_BOUNDS = 1024

CAPACITY = 256

.data

	intro BYTE "Sorting Random Integers Programmed		by Austin Chayka", 13, 10, 
			   "This program generates random numbers in the range [64, 1024], displays the original list,", 13, 10,
			   "sorts the list, and calculates the median value and the average value. Finally,", 13, 10, 
			   "it displays the list sorted in descending order.", 13, 10, 13, 10, 0
	newLine BYTE 13, 10, 0
	unsortTitle BYTE "Unsorted List:", 13, 10, 0
	sortTitle BYTE "Sorted List:", 13, 10, 0

	terms DWORD	?
	array DWORD CAPACITY DUP(?)

.code

main PROC
	;seeds the random number generator
	call	Randomize
	;prints intro and gets number of terms from the user
	mov		edx, OFFSET intro
	call	WriteString
	push	OFFSET terms
	push	max
	push	min
	call	getData

	mov		edx, OFFSET newLine
	call	WriteString
	;fills the array
	push	HIGH_BOUNDS
	push	LOW_BOUNDS
	push	OFFSET array
	push	terms
	call	fillArray
	;displays the array
	push	OFFSET unsortTitle
	push	OFFSET array
	push	terms
	call	printArray
	
	mov		edx, OFFSET newLine
	call	WriteString
	;sorts the array
	push	OFFSET array
	push	terms
	call	sort	
	
	mov		edx, OFFSET newLine
	call	WriteString
	;finds the median
	push	OFFSET array
	push	terms
	call	displayMedian

	mov		edx, OFFSET newLine
	call	WriteString
	;finds the average
	push	OFFSET array
	push	terms
	call	displayAverage

	mov		edx, OFFSET newLine
	call	WriteString
	
	mov		edx, OFFSET newLine
	call	WriteString
	;prints sorted list
	push	OFFSET sortTitle
	push	OFFSET array
	push	terms
	call	printArray

	exit
main ENDP

end main