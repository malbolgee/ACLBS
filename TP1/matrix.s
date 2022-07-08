;nome: Victor Hugo de Oliveira Gomes
;matrícula: 21852452
;matéria: Arquitetura de Computadores
;professor: Juan Colonna

.data

matrix_a:		.word32			1, 2, 3, 4, 5, 6, 7, 8, 9, 6, 5, 4
matrix_b:		.word32			3, 2, 6, 5, 8, 7
matrix_c:		.word32			0, 0, 0, 0, 0, 0, 0, 0

.code

setup:			movz			$s0, $zero, $zero	;; i
				movz			$s1, $zero, $zero	;; j
				movz			$s2, $zero, $zero	;; k
				addi			$s3, $zero, 0x4		;; matrix_a/c number of rows
				addi			$s4, $zero, 0x2		;; matrix_b/c number of columns
				addi			$s5, $zero, 0x3		;; matrix_b number of rows (also cols_a)

loop_1:			bne				$s0, $s3,  upd_index_j
				b				done

upd_index_j:	movz			$s1, $zero, $zero	;; puts zero in the j index again
loop_2:			bne				$s1, $s4, upd_index_k
				addi			$s0, $s0, 0x1
				b				loop_1

upd_index_k:	movz			$s2, $zero, $zero	;; puts zero in the k index again
loop_3:			bne				$s2, $s5, statement ;; branch if k != rows_b
				addi			$s1, $s1, 0x1		;; when the loop_3 ends, update j index
				b				loop_2				;; if k is equal to rows_b, go back to the immediate external loop

statement:		mult			$s0, $s5			;; w = i * cols_a
				mflo			$s7
				add				$s7, $s7, $s2		;; w = w + k
				mult			$s7, $s3
				mflo			$s7
				lw				$s7, matrix_a($s7)	;; a[i * cols_a + k]

				mult			$s2, $s4			;; t = k * cols_b
				mflo			$t0
				add				$t0, $t0, $s1		;; t = t + j
				mult			$t0, $s3
				mflo			$t0
				lw				$t0, matrix_b($t0)	;; b[k * cols_b + j]

				mult			$t0, $s7			;; a[i * cols_a + k] * b[k * cols_b + j]
				mflo			$t0
				
				mult			$s0, $s4			;; z = i * cols_c
				mflo			$s7
				add				$s7, $s7, $s1		;; z = z + j
				mult			$s7, $s3			;; z = z * 0x4
				mflo			$s7
				lw				$s6, matrix_c($s7)	

				add				$s6, $s6, $t0

				sw				$s6, matrix_c($s7)	;; c[i * cols_c + j] += a[i * cols_a + k] * b[k * cols_b + j]

				addi			$s2, $s2, 0x1		;; update k index
				b				loop_3	

done:			syscall			0x0
