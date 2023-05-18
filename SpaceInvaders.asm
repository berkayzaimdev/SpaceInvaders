ORG 100h 
jmp start  

centrey dw 00BAh
centrex dw ? 
 
msg db 10,     '' , 13,10
    db 10,10,  '' , 13,10
    db 10,    '', 13,10
    db     ' ', 13,10
    db     '          SPACE INVADERS ', 13,10
    db     '           ', 13,10
    db     '  Baslamak icin ENTER tusuna basin.','$'

start:
 mov ah,00
 int 10h
 LEA dx,msg
 mov Ah,9
 int 21h
 wait_for_enter:
 mov ah,00
 int 16h
 cmp AX,1c0dh
 jne wait_for_enter 


prepare:
mov ax,0013h
int 10h 
mov ax,0C30h
mov cx,0024h
mov dx,0015h
mov bp,8
mov bx,1

 
alienbuilder:
    push dx
    drawalien:
    a1:
      int 10h
      add cx,6
      int 10h
      inc dx
    a2:
      sub cx,5
      int 10h
      add cx,4
      int 10h
      inc dx
    a3:
      sub cx,5
      mov si,7
      writer3:
        int 10h
        inc cx
        dec si
        jnz writer3
      inc dx
    a4:
      sub cx,8
      mov si,2
      writer41:
        int 10h
        inc cx
        dec si
        jnz writer41
      inc cx
      mov si,3
      writer42:
        int 10h
        inc cx
        dec si
        jnz writer42
      inc cx
      mov si,2
      writer43:
        int 10h
        inc cx
        dec si
        jnz writer43 
      inc dx
    a5:
      sub cx,10
      mov si,11
      writer5:
        int 10h
        inc cx
        dec si
        jnz writer5
      inc dx
    a6:
      sub cx,11
      int 10h
      add cx,2
      mov si,7
      writer6:
        int 10h
        inc cx
        dec si
        jnz writer6
      inc cx
      int 10h
      inc dx
    a7:
      sub cx,10
      int 10h
      add cx,2
      int 10h
      add cx,6
      int 10h
      add cx,2
      int 10h
      inc dx
    a8:
      sub cx,10
      mov si,11
      writer7:
      int 10h
      inc cx
      dec si
      jnz writer7
    add cx,15h
    pop dx 
    dec bp
    jnz alienbuilder 

before_player_builder:        
mov cx,0099h
mov dx,00BAh
mov al,44h
mov bp,8
MOV di,1
player_builder:
  push cx
  PUSH di
  rowbuilder:
    int 10h
    inc cx
    dec di
    jnz rowbuilder
  pop di
  pop cx
  add di,2       
  dec CX
  inc dx 
  dec bp
  jnz player_builder

add cx,8
mov centrex,cx  

wait_for_key:
  mov ah,00h
  int 16h
  cmp ah,4bh
  je player_rebuilder_left
  cmp ah,4dh
  je player_rebuilder_right
  cmp ah,39h
  je shoot
  jmp wait_for_key
  
player_rebuilder_left:
  mov ax,0C00h
  dec cx
  sub dx,8
  mov bp,8
  mov di,1
  rebuilder_left:
    mov al,44h 
    push cx
    PUSH di
    rowbuilder_left:
      int 10h
      inc cx
      dec di
      jnz rowbuilder_left
    inc cx
    mov al,00h
    int 10h
    pop di
    pop cx
    add di,2       
    dec CX
    inc dx 
    dec bp
    jnz rebuilder_left
  add cx,8
  mov centrex,cx
  jmp wait_for_key
    
  
  
player_rebuilder_right:
  mov ax,0C00h
  inc cx
  sub dx,8
  mov bp,8
  mov di,1
  rebuilder_right:
    mov al,44h 
    push cx
    push di
    rowbuilder_right:
      int 10h    
      dec cx
      dec di
      jnz rowbuilder_right
    dec cx
    mov al,00h
    int 10h
    pop di
    pop cx
    add di,2       
    inc cx
    inc dx 
    dec bp
    jnz rebuilder_right
  sub cx,8
  mov centrex,cx
  jmp wait_for_key
  
  
shoot:
  push dx
  push cx
  mov dx,[centrey]
  mov cx,[centrex]
  sub dx,2
  mov di,dx
  dec di
  shooter:
    dec dx
    mov ah,0dh
    int 10h
    cmp al,30h
    je alienclearer
    inc dx
    mov ax,0c54h 
    int 10h
    dec dx
    add dx,2
    mov al,00h
    int 10h
    sub dx,2    
    dec di
    jnz shooter
  mov al,00    
  inc dx
  int 10h
  pop cx
  pop dx
  jmp wait_for_key 
  
alienclearer:
    mov ax,0C00h
    add dx,2
    int 10h
    mov dx,0015h
    xor ch,ch
    comparea01:   
    cmp cx,002Ch
    jge comparea11
    comparea02:
    cmp cx,0022h
    mov bp,0024h
    jge clearalien 
    
    comparea11:
    cmp cx,0040h
    jge comparea21
    comparea12:
    cmp cx,004Ah
    mov bp,0041h
    jge clearalien
    
    comparea21:
    cmp cx,005Eh
    jge comparea31
    comparea22:
    cmp cx,0068h
    mov bp,005Eh
    jle clearalien
    
    comparea31:
    cmp cx,007Ch
    jge comparea41
    comparea32:
    cmp cx,0086h
    mov bp,007Bh
    jle clearalien
    
    comparea41:
    cmp cx,009Ah
    jge comparea51
    comparea42:
    cmp cx,00A4h
    mov bp,0098h
    jle clearalien
    
    comparea51:
    cmp cx,00B8h
    jge comparea61
    comparea52:
    cmp cx,00C2h
    mov bp,00CCh
    jle clearalien
    
    comparea61:
    cmp cx,00D6h
    jge comparea71
    comparea62:
    cmp cx,00E0h
    mov bp,00D2h
    jle clearalien
    
    comparea71:
    cmp cx,00F4h
    mov bp,00EFh
    jle clearalien
    
    mov bp,010Ch
    
    
    clearalien:
    mov cx,bp
    ca1:
      int 10h
      add cx,6
      int 10h
      inc dx
    ca2:
      sub cx,5
      int 10h
      add cx,4
      int 10h
      inc dx
    ca3:
      sub cx,5
      mov si,7
      clearer3:
        int 10h
        inc cx
        dec si
        jnz clearer3
      inc dx
    ca4:
      sub cx,8
      mov si,2
      clearer41:
        int 10h
        inc cx
        dec si
        jnz clearer41
      inc cx
      mov si,3
      clearer42:
        int 10h
        inc cx
        dec si
        jnz clearer42
      inc cx
      mov si,2
      clearer43:
        int 10h
        inc cx
        dec si
        jnz clearer43 
      inc dx
    ca5:
      sub cx,10
      mov si,11
      clearer5:
        int 10h
        inc cx
        dec si
        jnz clearer5
      inc dx
    ca6:
      sub cx,11
      int 10h
      add cx,2
      mov si,7
      clearer6:
        int 10h
        inc cx
        dec si
        jnz clearer6
      inc cx
      int 10h
      inc dx
    ca7:
      sub cx,10
      int 10h
      add cx,2
      int 10h
      add cx,6
      int 10h
      add cx,2
      int 10h
      inc dx
    ca8:
      sub cx,10
      mov si,11
      clearer7:
      int 10h
      inc cx
      dec si
      jnz clearer7
    dec bx
    jz finish
    jmp wait_for_key
    
finish:
  mov ah,4Ch
  int 21h
    
