;nome: Victor Hugo de Oliveira Gomes
;matricula: 21852452
;matéria: Arquitetura de Computadores
;professor: Juan Colonna

.data

array:		.byte		1, 2, 3
format_str:	.asciiz		"%d\n"
param:		.space		0x8
num:		.space		0x8

.code

setup:		movz		$s0, $zero, $zero  	;; put zero into the index register
			lb			$t0, array($s0)		;; fetch the array value in the index position
			addi		$s0, $s0, 0x1		;; update index
			lb			$t1, array($s0)		;; fetch the array value in the index position
			addu		$s1, $t0, $t1		;; add the fetched values from the array together ($s1 is the x variable)
			addi		$s0, $s0, 0x1		;; update index
			lb			$t2, array($s0)		;; fetch the array value in the index position
			sub			$s2, $s1, $t2		;; subtract the array value in $t2 from the added value
			movn		$s1, $t2, $s2		;; moves the value of $t2 to $s1 if $s2 is not zero (#s1 is not equal to $t2)

print:		daddi		$a0, $zero, format_str
			sw			$a0, param($zero)
			addi		$t6, $zero, param
			sw			$s1, num($zero)
			syscall		0x5

syscall 0x0
