;nome: Victor Hugo de Oliveira Gomes
;matricula: 21852452
;matéria: Arquitetura de Computadores
;professor: Juan Colonna

.data

array:              .byte	10, 8, 12, 5, 24, 2, 15, 0
size:               .byte   8                   ;; update according to the array size
format_str:	        .asciiz	"%i\n"
format_error_str:   .asciiz "The array does not have any element!"
params_sys5:	    .space 	8
res:	            .space	8

.code

setup:          addi    $s2, $zero, size        ;; it seems that if we try to get a value from the .data section, it puts in the destination register the data's address instead of its value (the same array logic).
                lb      $s2, size($zero)        ;; so we need this to set up the array size. And of course, lb because we know that the array is not that big.
                beq     $s2, $zero, end_error   ;; check if the array has some element.
                addi    $s0, $zero, array
                lb      $s0, array($s0)         ;; if the array has at least one element, the current bigger is the first item in the array.
                add     $s1, $zero, $zero       ;; sets up array index.
                b       loop                    ;; jumps to the beginning of the loop

loop:           bne     $s2, $s1, check_bigger  ;; checks if the array is not over
                j       end                     ;; if it is, end this program's misery.

check_bigger:   lb      $t0, array($s1)         ;; fetch the element in the $s1 position.
                sub     $s4, $s0, $t0           ;; it seems we don't have an instruction to check if a number is greater/lesser than the other, so we get our hands dirty.
                bgez    $s4, update_index       ;; if the subtraction yielded a number greater than 0, the first is bigger than the second, we must just update the index.
                j       update_bigger           ;; if not, update the current bigger.

update_index:   addi    $s1, $s1, 0x1           ;; update the index by 1. NOTE: we have an array in which each element takes a byte size, so we can afford to just add 1 to the offset.
                j       loop                    ;; just get back to the loop.

update_bigger:  movn    $s0, $t0, $t0           ;; apparently, we do have this instruction to move the value of a register into another, let's use it.
                j       update_index            ;; have we finished updating the new bigger? update the index now.

end:            daddi   $a0, $zero, format_str
                sw		$a0, params_sys5($zero)
                addi    $t6, $zero, params_sys5
                sw      $s0, res($zero)
                syscall 0x5						;; printing the value
                j       end_end

end_error:      daddi   $a0, $zero, format_error_str
                sw      $a0, params_sys5($zero)
                daddi   $t6, $zero, params_sys5
                syscall 0x5						;; printing the error message
                j       end_end

end_end:        syscall 0x0
