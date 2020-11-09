INCLUDE irvine32.inc

.data

	getNum BYTE "How many numbers should be generated? [", 0
	comma BYTE ", ", 0
	getNum2 BYTE "]: ", 0
	invalid BYTE "Invalid Input", 13, 10, 0
	ok BYTE "OK!", 13, 10, 0
	space BYTE "	", 0
	newLine BYTE 13, 10, 0

	medianTitle BYTE "The median is ", 0
	averageTitle BYTE "The average is ", 0

.code

;	gets input from the user
;recieves:	input bounds
;returns:	value inputted
getData PROC

	push	ebp
	mov		ebp, esp
	jmp		inputData
;input out of bounds
dataError:
	mov		edx, OFFSET invalid
	call	WriteString

inputData:
	;ask for value
	mov		edx, OFFSET getNum
	call	WriteString
	mov		eax, [ebp + 8]
	call	WriteInt
	mov		edx, OFFSET comma
	call	WriteString
	mov		eax, [ebp + 12]
	call	WriteInt
	mov		edx, OFFSET getNum2
	call	WriteString
	;get value
	call	ReadInt
	;check bounds
	cmp		eax, [ebp + 8]
	jl		dataError
	cmp		eax, [ebp + 12]
	jg		dataError
	;save value
	mov		ecx, [ebp + 16]
	mov		[ecx], eax

	mov		edx, OFFSET ok
	call	WriteString

	pop		ebp

	ret		12
getData ENDP

;	prints array
;recieves:	array and size
;returns:	none
printArray PROC

	push	ebp
	mov		ebp, esp
	;loads array and size
	mov		ecx, [ebp + 8]
	mov		esi, [ebp + 12]
	
	mov		edx, [ebp + 16]
	call	WriteString

start:
	;prints value
	mov		eax, [esi]
	call	WriteInt
	;format numbers into rows
	mov		edx, OFFSET space
	call	WriteString
	mov		eax, [ebp + 8]
	sub		eax, ecx
	inc		eax
	mov		edx, 0
	mov		ebx, 5
	div		ebx
	cmp		edx, 0
	jne		noSkip
	mov		edx, OFFSET newLine
	call	WriteString

noSkip:
	add		esi, 4
	loop	start

	pop		ebp

	ret		12
printArray ENDP

;	displays median of the array
;recieves:	array and size
;returns:	none
displayMedian PROC
	
	push	 ebp
	mov		ebp, esp
	;loads array
	mov		esi, [ebp + 12]
	;goes to middle of the array
	mov		edx, 0
	mov		eax, [ebp + 8]
	mov		ecx, 2
	div		ecx

	mov		ecx, 4
	mul		ecx
	;gets median value
	add		esi, eax
	mov		eax, [esi]

	cmp		edx, 0
	jne		skip

	sub		esi, 4
	add		eax, [esi]

	mov		edx, 0
	mov		ecx, 2
	div		ecx

	skip:
	;displays value
	mov		edx, OFFSET medianTitle
	call	WriteString
	call	WriteInt

	pop		ebp

	ret		8
displayMedian ENDP

;	gets input from the user
;recieves:	input bounds
;returns:	value inputted
displayAverage PROC

	push	 ebp
	mov		ebp, esp
	;loads array and size
	mov		esi, [ebp + 12]
	mov		ecx, [ebp + 8]

	mov		eax, 0

	start:
	;sums array contents
	add		eax, [esi]
	add		esi, 4

	loop	start
	;divides by size
	mov		edx, 0
	mov		ecx, [ebp + 8]
	div		ecx
	;displays value
	mov		edx, OFFSET averageTitle
	call	WriteString
	call	WriteInt

	pop		ebp

	ret		8
displayAverage ENDP

end