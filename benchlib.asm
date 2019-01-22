SECTION .text
	GLOBAL prime
	GLOBAL getName
	GLOBAL primes

; void primes(int n, int* buf), n is EDI, buf is ESI
primes:
	CMP EDI, 0			; if n == 0, then ret 0
	JE ret0
					; n is EDI, buf is ESI
	MOV DWORD [ESI], 2		; Start with 2
	MOV EAX, 1			; How many primes we have (i)
	MOV EBX, 3			; Current number (j)
primes_loop:
	PUSH RSI
	PUSH RDI
	PUSH RAX
	PUSH RBX

	MOV EDI, EBX			; Set 1st arg for prime to j
	CALL prime			; prime(j)
	MOV ECX, EAX			; Move result to ECX

	POP RBX
	POP RAX
	POP RDI
	POP RSI

	CMP ECX, 0
	JE primes_skip			; If 0 then hop to skip
	LEA EDX, [ESI + EAX * 4]	; Load our pointer
	MOV [EDX], EBX	 		; buf[i] = j;
	INC EAX				; i++
primes_skip:
	ADD EBX, 2			; j += 2
	CMP EAX, EDI			; CMP i, n
	JL primes_loop			; If i < n, loop
	RET

; int prime(int n) - n is in edi
prime:
	CMP EDI, 2
	JE ret1			; if n == 2, return 1
	JLE ret0		; if n < 2 return 0
	MOV EBX, 1
	AND EBX, EDI
	JZ ret0			; if n&1 == 0, return 0
	MOV ESI, 3		; Start at 3
				; Register map: ESI is i, EDI is n
prime_loop:			; for(int i = 3; i < n; i += 2;
	MOV EDX, 0		; Clear the remainder (can cause a FPE if not done)
	MOV EAX, EDI		; Set the dividend to n
	IDIV ESI		; Divide n by i
				; EAX is now our quotient, EDX our remainder
	CMP EDX, 0		; Check if remainder is 0
	JE ret0			; If n % i == 0 then return 0
	ADD ESI, 2		; Increment by 2
	CMP ESI, EDI		; Ending comparison, if i < n skip back
	JL prime_loop		; End of loop
	MOV EAX, 1
	RET

; char* getName()
getName:
	MOV EAX, asm
	RET
ret0:				; Return 0
	MOV EAX, 0
	RET
ret1:				; Return 1
	MOV EAX, 1
	RET

SECTION .data
	asm DB "Assembly"
