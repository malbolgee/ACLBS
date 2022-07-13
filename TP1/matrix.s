;nome: Victor Hugo de Oliveira Gomes
;matrícula: 21852452
;matéria: Arquitetura de Computadores
;professor: Juan Colonna

.data

matrix_a:		.word32			1, 2, 3, 4, 5, 6, 7, 8, 9, 6, 5, 4
matrix_b:		.word32			3, 2, 6, 5, 8, 7
matrix_c:		.word32

.code

setup:			addi			$s3, $zero, 0x4	;; matrix_a/c number of rows (rows_a, rows_c)
			addi			$s4, $zero, 0x2	;; matrix_b/c number of columns (cols_b, cols_c)
			addi			$s5, $zero, 0x3	;; matrix_b number of rows (rows_b, cols_a)
loopi:			bne			$s0, $s3,  upd_idx_j
			b			done
upd_idx_j:		movz			$s1, $zero, $zero	;; restart j index
loopj:			bne			$s1, $s4, upd_idx_k
			addi			$s0, $s0, 0x1
			b			loopi
upd_idx_k:		movz			$s2, $zero, $zero	;; restart k index
loopk:			bne			$s2, $s5, statement
			addi			$s1, $s1, 0x1
			b			loopj
statement:		mult			$s0, $s5		;; w = i * cols_a
			mflo			$s7
			add			$s7, $s7, $s2		;; w = w + k
			mult			$s7, $s3
			mflo			$s7
			lw			$s7, matrix_a($s7)	;; a[i * cols_a + k]
			mult			$s2, $s4		;; t = k * cols_b
			mflo			$t0
			add			$t0, $t0, $s1		;; t = t + j
			mult			$t0, $s3
			mflo			$t0
			lw			$t0, matrix_b($t0)	;; b[k * cols_b + j]
			mult			$t0, $s7		;; a[i * cols_a + k] * b[k * cols_b + j]
			mflo			$t0
			mult			$s0, $s4		;; z = i * cols_c
			mflo			$s7
			add			$s7, $s7, $s1		;; z = z + j
			mult			$s7, $s3		;; z = z * 0x4
			mflo			$s7
			lw			$s6, matrix_c($s7)
			add			$s6, $s6, $t0
			sw			$s6, matrix_c($s7)	;; c[i * cols_c + j] += a[i * cols_a + k] * b[k * cols_b + j]
			addi			$s2, $s2, 0x1		;; update k index
			b			loopk
done:			syscall		0x0
