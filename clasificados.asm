.data
    msj_clasificados: .asciiz "\nEquipos clasificados a la siguiente etapa: \n"
    salto_linea: .asciiz "n

.text
.globl mostrar_clasificados


mostrar_clasificados:

    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $s0, 4($sp)

    #imprimir mensaje
    li $v0, 4
    la $a0, msj_clasificados
    syscall



    #mostrar el primer clasificado

    la $t0, orden_indices
    lw $t1, 0($t0)

    move $a0, $t1
    jal imprimir_nombre_equipo_grupo


    li $v0, 4
    la $a0, salto_linea
    syscall


    #mostrar el segundo clasificado

    lw $t1, 4($t0)

    jal imprimir_nombre_equipo_grupo

    li $v0, 4
    la $a0, salto_linea
    syscall

    lw $s0, 4($sp)
    lw $ra, 0($sp)

    addi $sp, $sp, 8


    jr $ra