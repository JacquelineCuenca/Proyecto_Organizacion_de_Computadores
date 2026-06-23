.data
    orden_indices: .word 0,1,2,3
    msj_tabla_ordenada: .asciiz "\nTabla de posiciones (ordenada):\n"

.text
.globl ordenar_tabla
ordenar_tabla:
    addi $sp, $sp, -16
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)

    # Inicializar orden_indices con 0,1,2,3
    la $t0, orden_indices
    li $t1, 0
init_loop:
    bge $t1, 4, init_done
    sw $t1, 0($t0)
    addi $t0, $t0, 4
    addi $t1, $t1, 1
    j init_loop
init_done:

    # Bubble sort
    li $s0, 3        
outer_loop:
    beq $s0, $zero, sort_done
    li $s1, 0       
inner_loop:
    bge $s1, 3, inner_done

    # cargar indices i y i+1
    la $t0, orden_indices
    sll $t1, $s1, 2
    add $t2, $t0, $t1
    lw $t3, 0($t2)    

    addi $t4, $s1, 1
    sll $t5, $t4, 2
    add $t6, $t0, $t5
    lw $t7, 0($t6)    

    # cargar puntos[idx0] y puntos[idx1]
    la $t8, puntos
    sll $t1, $t3, 2
    add $t2, $t8, $t1
    lw $t9, 0($t2)    

    sll $t1, $t7, 2
    add $t2, $t8, $t1
    lw $t1, 0($t2)    

    # si puntos[idx0] < puntos[idx1] => swap
    blt $t9, $t1, do_swap
    beq $t9, $t1, cmp_diff
    j no_swap

cmp_diff:
    # calcular diff0 = gf[idx0] - gc[idx0]
    la $t8, gf
    sll $t1, $t3, 2
    add $t2, $t8, $t1
    lw $t4, 0($t2)  

    la $t8, gc
    sll $t1, $t3, 2
    add $t2, $t8, $t1
    lw $t5, 0($t2)   

    sub $t6, $t4, $t5  

    # calcular diff1 = gf[idx1] - gc[idx1]
    la $t8, gf
    sll $t1, $t7, 2
    add $t2, $t8, $t1
    lw $t4, 0($t2)    

    la $t8, gc
    sll $t1, $t7, 2
    add $t2, $t8, $t1
    lw $t5, 0($t2)    

    sub $t7, $t4, $t5  

    blt $t6, $t7, do_swap
    j no_swap

do_swap:
    # swap orden_indices[s1] and orden_indices[s1+1]
    la $t0, orden_indices
    sll $t1, $s1, 2
    add $t2, $t0, $t1
    lw $t3, 0($t2)
    addi $t4, $s1, 1
    sll $t5, $t4, 2
    add $t6, $t0, $t5
    lw $t7, 0($t6)
    sw $t7, 0($t2)
    sw $t3, 0($t6)

no_swap:
    addi $s1, $s1, 1
    j inner_loop

inner_done:
    addi $s0, $s0, -1
    j outer_loop

sort_done:
    lw $s2, 12($sp)
    lw $s1, 8($sp)
    lw $s0, 4($sp)
    lw $ra, 0($sp)
    addi $sp, $sp, 16
    jr $ra

.globl mostrar_tabla_ordenada
mostrar_tabla_ordenada:
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)

    # imprimir encabezado
    li $v0, 4
    la $a0, msj_tabla_ordenada
    syscall

    li $v0, 4
    la $a0, enc_tabla
    syscall

    li $s0, 0
loop_print:
    bge $s0, 4, end_print

    # obtener index ordenado
    la $t0, orden_indices
    sll $t1, $s0, 2
    add $t2, $t0, $t1
    lw $t3, 0($t2)  

    # imprimir nombre usando idx
    move $a0, $t3
    jal imprimir_nombre_equipo_grupo

    # tab
    li $v0, 4
    la $a0, sep_tab
    syscall

    # GF
    la $t4, gf
    sll $t5, $t3, 2
    add $t6, $t4, $t5
    lw $a0, 0($t6)
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, sep_tab
    syscall

    # GC
    la $t4, gc
    sll $t5, $t3, 2
    add $t6, $t4, $t5
    lw $a0, 0($t6)
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, sep_tab
    syscall

    # Puntos
    la $t4, puntos
    sll $t5, $t3, 2
    add $t6, $t4, $t5
    lw $a0, 0($t6)
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, salto_linea
    syscall

    addi $s0, $s0, 1
    j loop_print

end_print:
    lw $s1, 8($sp)
    lw $s0, 4($sp)
    lw $ra, 0($sp)
    addi $sp, $sp, 12
    jr $ra
