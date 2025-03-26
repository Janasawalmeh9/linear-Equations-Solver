.data
array_2D: .byte 1, 2, 3, 8  # Coefficients for the first equation
           .byte 2, 5, 6, 8  # Coefficients for the second equation
           .byte 7, 8, 6, 8  # Coefficients for the third equation
result_D: .asciiz "Determinant D: "
result_DX: .asciiz "\nDeterminant DX: "
result_DY: .asciiz "\nDeterminant DY: "
result_DZ: .asciiz "\nDeterminant DZ: "
newline: .asciiz "\n"

.text
.globl main
main:
    # Load values from array_2D into registers
    la $t0, array_2D        # Base address of array_2D
    
    # Load coefficients for the equations into registers
    lb $t1, 0($t0)          # a1 = 1
    lb $t2, 1($t0)          # b1 = 2
    lb $t3, 2($t0)          # c1 = 3
    lb $t4, 3($t0)          # d1 = 8

    lb $t5, 4($t0)          # a2 = 2
    lb $t6, 5($t0)          # b2 = 5
    lb $s3, 6($t0)          # c2 = 6
    lb $t8, 7($t0)          # d2 = 8

    lb $t9, 8($t0)          # a3 = 7
    lb $s2, 9($t0)          # b3 = 8
    lb $a1, 10($t0)         # c3 = 6
    lb $a2, 11($t0)         # d3 = 8

    # Calculate D
    mul $t4, $t6, $a1       # b2*c3
    mul $t8, $s3, $s2       # c2*b3
    sub $t4, $t4, $t8      # (b2*c3 - c2*b3)
    mul $t4, $t1, $t4     # a1 * (b2*c3 - c2*b3)

    
    mul $t8, $t5, $a1       # a2*c3
    mul $v0, $s3, $t9       # c2*a3
    sub $t8, $t8, $v0      # (a2*c3 - c2*a3)
    mul $t8, $t2, $t8      # b1 * (a2*c3 - c2*a3)
    sub $t4, $t4, $t8       # D part 2 subtraction
      
    mul $t8, $t5, $s2      # a2*b3
    mul $v0, $t6, $t9       # b2*a3
    sub $t8, $t8, $v0      # (a2*b3 - b2*a3)
    mul $t8, $t3, $t8      # c1 * (a2*b3 - b2*a3)
    add $t4, $t4, $t8       # Finalize D

    # Print D
    li $v0, 4               # syscall for print string
    la $a0, result_D
    syscall

    move $a0, $t4        # Move D to $a0 for printing
    li $v0, 1               # syscall for print integer
    syscall
    
    
    

    # Calculate DX
    
      lb $t4, 3($t0)          # d1 = 8
      lb $t8, 7($t0)          # d2 = 8
      lb $a2, 11($t0)         # d3 = 8
     
    mul $t1, $t6, $a1       # b2*c3
    mul $t5, $s3, $a2       # c2*d3
    sub $t1, $t1, $t5       # (b2*c3 - c2*d3)
    mul $t1, $t4, $t1      # d1 * (b2*c3 - c2*d3)
    
   
    
    mul $t5, $t4, $a1       # d2*c3
    mul $v0, $s3, $a2       # c2*d3
    sub $t5, $t5, $v0      # (d2*c3 - c2*d3)
    mul $t5, $t2, $t5       # -b1 * (d2*c3 - c2*d3)
    sub $t1, $t1, $t5       # DX part 2 subtraction
    
 
    
    mul $t5, $t8, $s2       # d2*b3
    mul $v0, $t6, $a2      # b2*d3
    sub $t5, $t5, $v0      # (d2*b3 - b2*d3)
    mul $t5, $t3, $t5       # c1 * (d2*b3 - b2*d3)
    add $t1, $t1, $t5       # Finalize DX
    
         
    # Print DX
    li $v0, 4               # syscall for print string
    la $a0, result_DX
    syscall
    
      move $a0, $t1           # Move DZ to $a0 for printing
    li $v0, 1               # syscall for print integer
    syscall
  

    # Calculate DY
    
      lb $t1, 0($t0)          # a1 = 1
      lb $t5, 4($t0)          # a2 = 2
      lb $t9, 8($t0)          # a3 = 7
      
    mul $t2, $t8, $a1       # d2*c3
    mul $t6, $s3, $a2       # c2*d3
    sub $t2, $t2, $t6       # (d2*c3 - c2*d3)
    mul $t2, $t1, $t2       # a1 * (d2*c3 - c2*d3)
    
    mul $t6, $t5, $a1       # a2*c3
    mul $v0, $s3, $t9       # c2*a3
    sub $t6, $t6, $v0       # (a2*c3 - c2*a3)
    mul $t6, $t4, $t6       # d1 * (a2*c3 - c2*a3)
    sub $t2, $t2, $t6       # DY part 2 subtraction
   
    
    mul $t6, $t5, $a2       # a2*d3
    mul $v0, $t8, $t9       # d2*a3
    sub $t6, $t6, $v0       # (a2*d3 - d2*a3)
    mul $t6, $t3, $t6       # c1 * (a2*d3 - d2*a3) 
    add $t2, $t2, $t6      # Finalize DY

    # Print DY
    li $v0, 4               # syscall for print string
    la $a0, result_DY
    syscall
    
    move $a0, $t2          # Move DY to $a0 for printing
    li $v0, 1               # syscall for print integer
    syscall

  
    # Calculate DZ
    
    lb $t2, 1($t0)          # b1 = 2
    lb $t6, 5($t0)          # b2 = 5
    lb $s2, 9($t0)          # b3 = 8
    
    mul $t3, $t6, $a2       # b2*d3
    mul $s3, $t8, $s2       # d2*b3
    sub $t3, $t3, $s3       # (b2*d3 - d2*b3)
    mul $t3, $t1, $t3       # a1 * (b2*d3 - d2*b3)

   
    
    mul $s3, $t5, $a2       # a2*d3
    mul $v0, $t8, $t9       # d2*a3
    sub $s3, $s3, $v0       # (a2*d3 - d2*a3)
    mul $s3, $t2, $s3       # b1* (a2*d3 - d2*a3)
    sub $t3, $t3, $s3       # DZ part 2 subtraction

    mul $s3, $t5, $s2       # a2*b3
    mul $v0, $t6, $t9       # b2*a3
    sub $s3, $s3, $v0       # (a2*b3 - b2*a3)
    mul $s3, $t4, $s3       # d1* (a2*b3 - b2*a3)
    add $t3, $t3, $s3       # Finalize DZ

    # Print DZ
    li $v0, 4               # syscall for print string
    la $a0, result_DZ
    syscall

    move $a0, $t3           # Move DZ to $a0 for printing
    li $v0, 1               # syscall for print integer
    syscall
    
    

    # Exit
    li $v0, 10              # syscall for exit
    syscall
