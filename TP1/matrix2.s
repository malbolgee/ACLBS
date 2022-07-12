;nome: Victor Hugo de Oliveira Gomes
;matrícula: 21852452
;matéria: Arquitetura de Computadores
;professor: Juan Colonna

.data

matrix_a:		.word32			1, 2, 3, 4, 5, 6, 7, 8, 9, 6, 5, 4
matrix_b:		.word32			3, 2, 6, 5, 8, 7
matrix_c:		.word32

.code

setup:			addiu			$s3, $zero, 0x4		;; matrix_a/c number of rows (rows_a, rows_c)
				addiu			$s4, $zero, 0x2		;; matrix_b/c number of columns (cols_b, cols_c)
				addiu			$s5, $zero, 0x3		;; matrix_b number of rows (rows_b, cols_a)
loopi:			bne				$s0, $s3, upd_j
				b				done
upd_j:			movz			$s1, $zero, $zero	;; restart j index
loopj:			bne				$s1, $s4, upd_k
				addiu			$s0, $s0, 0x1
				b				loopi
upd_k:			movz			$s2, $zero, $zero	;; restart k index
loopk:			bne				$s2, $s5, statement
				addiu			$s1, $s1, 0x1
				b				loopj
statement:		multu			$s0, $s5
				mflo			$s7
				addu			$s7, $s7, $s2
				sll				$s7, $s7, 0x2
				lw				$s7, matrix_a($s7)	;; a[i * cols_a + k]
				sll				$t0, $s2, 0x1
				addu			$t0, $t0, $s1
				sll				$t0, $t0, 0x2
				lw				$t0, matrix_b($t0)	;; b[k * cols_b + j]
				sll				$t1, $s0, 0x1
				addu			$t1, $t1, $s1
				sll				$t1, $t1, 0x2
				lw				$s6, matrix_c($t1)	;; c[i * cols_c + j]
				mult			$t0, $s7
				mflo			$t0
				add				$s6, $s6, $t0		;; c[i * cols_c + j] += a[i * cols_a + k] * b[k * cols_b + j]
				sw				$s6, matrix_c($t1)
				addiu			$s2, $s2, 0x1		;; update k index
				b				loopk
done:			syscall			0x0
