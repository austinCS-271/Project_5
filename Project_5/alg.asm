INCLUDE irvine32.inc

.code

;	fills array with random numbers
;recieves:	array reference and array size, number bounds
;returns:	none
fillArray PROC

	push	ebp
	mov		ebp, esp
	;saves array and counter
	mov		ecx, [ebp + 8]
	mov		esi, [ebp + 12]

start:
	;generates random number in bounds
	mov		eax, [ebp + 20]
	sub		eax, [ebp + 16]
	inc		eax
	call	RandomRange
	add		eax, [ebp + 16]
	;fills array
	mov		[esi], eax
	add		esi, 4
	loop	start

	pop		ebp

	ret		16
fillArray ENDP

;	sorts array in ascending order
;recieves:	array reference and array size
;returns:	none
sort PROC

	push	ebp												
	mov		ebp, esp
	;outer loop counter
	mov		ecx, [ebp + 8]									
	dec		ecx
		
	outer:
		;inner loop counter
		push	ecx											
		mov		esi, [ebp + 12]								
			
		inner:
			;checks for lower value
			mov		eax, [esi]									
			cmp		[esi + 4], eax								
			jl		skip
			;swaps values
			xchg	eax, [esi + 4]								
			mov		[esi], eax									

		skip:
			;increments loop
			add		esi, 4										
			loop	inner											
			
	pop		ecx												
	loop	outer												

	pop		ebp	
	
	ret		8
sort ENDP

end