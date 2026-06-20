.text

# Simula los partidos entre los 4 equipos ingreados por el usuario
simular_partidos:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    # grupo[0] vs grupo[1]
    li $a0, 0
    li $a1, 1
    jal jugar_partido

    # grupo[0] vs grupo[2]
    li $a0, 0
    li $a1, 2
    jal jugar_partido

    # grupo[1] vs grupo[2]
    li $a0, 1
    li $a1, 2
    jal jugar_partido

    # grupo[1] vs grupo[3]
    li $a0, 1
    li $a1, 3
    jal jugar_partido

    # grupo[2] vs grupo[3]
    li $a0, 2
    li $a1, 3
    jal jugar_partido

    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra



# Simula un partido entre dos equipos (A Y B), actualizando sus estadísticas
jugar_partido:
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)

    # Gnerar goles para ambos equipos
    jal random_gol
    move $t2, $v0   # goles A
    jal random_gol
    move $t3, $v0   # goles B

    # actualizar GF y GC
    lw $a0, 4($sp)   # equipo A
    lw $a1, 8($sp)   # equipo B

    move $a2, $t2   # goles A
    move $a3, $t3   # goles B

    jal actualizar_estadisticas

    lw $ra, 0($sp)
    addi $sp, $sp, 12
    jr $ra



# Genera un número aleatorio entre 0 y 5 (goles)
random_gol:
    li $v0, 42      # random
    li $a0, 0       # generador aleatorio 0
    li $a1, 6       # rango 0–5
    syscall
    move $v0, $a0
    jr $ra



# Actualiza las estadísticas de los equipos después de un partido
actualizar_estadisticas:
    # a0 = equipo A
    # a1 = equipo B
    # a2 = goles A
    # a3 = goles B

    # GF y GC equipo A
    la $t0, gf
    sll $t1, $a0, 2
    add $t0, $t0, $t1

    lw $t2, 0($t0)
    add $t2, $t2, $a2
    sw $t2, 0($t0)

    la $t0, gc
    sll $t1, $a0, 2
    add $t0, $t0, $t1
    lw $t2, 0($t0)
    add $t2, $t2, $a3
    sw $t2, 0($t0)

    # GF y GC equipo B
    la $t0, gf
    sll $t1, $a1, 2
    add $t0, $t0, $t1

    lw $t2, 0($t0)
    add $t2, $t2, $a3
    sw $t2, 0($t0)

    la $t0, gc
    sll $t1, $a1, 2
    add $t0, $t0, $t1
    lw $t2, 0($t0)
    add $t2, $t2, $a2
    sw $t2, 0($t0)

    # Determinar resultado
    beq $a2, $a3, empate 
    bgt $a2, $a3, ganaA

    # gana B
    la $t0, puntos
    sll $t1, $a1, 2
    add $t0, $t0, $t1
    lw $t2, 0($t0)
    addi $t2, $t2, 3
    sw $t2, 0($t0)
    jr $ra

ganaA:
    la $t0, puntos
    sll $t1, $a0, 2
    add $t0, $t0, $t1
    lw $t2, 0($t0)
    addi $t2, $t2, 3
    sw $t2, 0($t0)
    jr $ra

empate:
    la $t0, puntos
    sll $t1, $a0, 2
    add $t0, $t0, $t1
    lw $t2, 0($t0)
    addi $t2, $t2, 1
    sw $t2, 0($t0)

    la $t0, puntos
    sll $t1, $a1, 2
    add $t0, $t0, $t1
    lw $t2, 0($t0)
    addi $t2, $t2, 1
    sw $t2, 0($t0)

    jr $ra
