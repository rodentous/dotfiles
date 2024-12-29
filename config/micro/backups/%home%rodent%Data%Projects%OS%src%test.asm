%include "io.inc"

section .data
	hello: db "Hi", 0

section .text
	mov ebp, esp
	xor esi, esi
	GET_DEC 4, eax
	PRINT_DEC 4, esi
	NEWLINE
	PRINT_DEC 4, eax
	NEWLINE
	xor eax, eax
