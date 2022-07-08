;nome: Victor Hugo de Oliveira Gomes
;matrícula: 21852452
;matéria: Arquitetura de Computadores
;professor: Juan Colonna

.code
addi	$s0, $zero, 0x5
addi	$s1, $zero, 0x3
addi	$s2, $zero, 0x4
addu	$s0, $s0, $s1
div		$s0, $s1
mflo	$s0
addi	$s1, $zero, 0x2
addi	$s2, $zero, 0x2
addu	$s1, $s1, $s2
addi	$s2, $zero, 0x3
mult	$s1, $s2
mflo	$s1
sub		$s0, $s0, $s1

syscall 0x0
