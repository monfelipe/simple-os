.set ALIGN,	   1<<0 				/* alinhar módulos carregados nos limites da página */
.set MEMINFO,  1<<1 				/* fornecer o mapa de memória */
.set FLAGS,	   ALIGN | MEMINFO
.set MAGIC,	   0x1BADB002 		/* 'número magico' permite que o bootloader encontre o cabeçalho */
.set CHECKSUM, -(MAGIC + FLAGS)

/* O padrão multiboot não define o valor do registro do ponteiro de pilha (esp) e cabe ao kernel fornecer uma pilha. */

.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

/*
O script do linker especifica _start como o ponto de entrada para o kernel e o
bootloader vai saltar para esta posição uma vez que o kernel foi carregado. É
não faz sentido para retornar desta função como o bootloader se foi.
*/

.section .bss
.align 16
stack_bottom:
.skip 16384 # 16 KiB
stack_top:

.section .text
.global _start
.type _start, @function
_start:

	mov $stack_top, %esp

	call kernel_main

	cli
1:	hlt    /* half life */
	jmp 1b /* tempos da engenharia revesa. */

/*
Defina o tamanho do símbolo _start para o local atual '.' menos o seu início.
Isso é útil ao depurar ou quando você implementa o rastreamento de chamadas.
*/

.size _start, . - _start