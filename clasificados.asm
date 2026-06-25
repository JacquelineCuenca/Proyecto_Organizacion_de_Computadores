.data
    msj_clasificados: .asciiz "\nEquipos clasificados a la siguiente etapa: \n"
 

.text
.globl mostrar_clasificados


mostrar_clasificados:

    addi $sp, $sp, -16
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)

    #imprimir mensaje
    li $v0, 4
    la $a0, msj_clasificados
    syscall
    
    
    la $t0, orden_indices
       
       
    #mostrar el primer clasificado

    lw $s1, 0($t0)

    move $a0, $s1
    jal imprimir_nombre_equipo_grupo


    li $v0, 4
    la $a0, salto_linea
    syscall


    #mostrar el segundo clasificado

    lw $s2, 4($t0)
     move $a0, $s2

    jal imprimir_nombre_equipo_grupo

    li $v0, 4
    la $a0, salto_linea
    syscall


    lw $s2, 12($sp)
    lw $s1, 8($sp)
    lw $s0, 4($sp)
    lw $ra, 0($sp)
    addi $sp, $sp, 16


    jr $ra
