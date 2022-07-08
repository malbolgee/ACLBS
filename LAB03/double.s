;nome: Victor Hugo de Oliveira Gomes
;matrícula: 21852452
;matéria: Arquitetura de Computadores
;professor: Juan Colonna

.data

array:		.double		1.0, 2.0, 3.0
format_str:	.asciiz		"%d\n"
param:		.space		0x8
num:		.space		0x8

.code

setup:		movz		$s0, $zero, $zero       ;; setup the index as 0
            l.d         f0, array($s0)          ;; fetch the array value in the index position
            addi		$s0, $s0, 0x8           ;; update index 
            l.d         f1, array($s0)          ;; fetch the array value in the index position
            add.d		f2, f0, f1              ;; add the fetched array values together
            addi		$s0, $s0, 0x8			;; update index
            l.d         f3, array($s0)			;; fetch the array value in the index position
            c.eq.d		0x0, f3, f2             ;; test to see if the added value is equal to the previous fetched value and if it is, put 1 in the 1st bit of the FCSR
            movt.d		f3, f2, 0x0             ;; move the value of f2 to f3 if the FCSR's 1st (or 0th?) bit is set to 1.

print:		daddi		$a0, $zero, format_str 
            sw          $a0, param($zero)
            addi		$t6, $zero, param
            cvt.l.d		f3, f3                  ;; once we dont have a placeholder to print doubles, we must rely on the convertion of double to long to print it.
            dmfc1		$s0, f3                 ;; moves the converted value into a general purpuse register.
            sd          $s0, num($zero)         ;; loads to memory a double word.
            syscall		0x5 

syscall 0x0
