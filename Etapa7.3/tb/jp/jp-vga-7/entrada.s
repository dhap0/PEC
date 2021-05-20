.include "macros.s"

.set PILA_SISTEMA, 0x9000
.set PILA_USUARI, 0x1000               ;una posicion de memoria de una zona no ocupada para usarse como PILA
; entry.s de zeos para SISA por Zeus Gómez Marmolejo

.data


    .balign 2
    interrupts_vector:
        .word RSI_interrupt_timer    ; timer
        .word RSI_interrupt_key      ; pulsadors
        .word RSI_interrupt_switch   ; switches
        .word RSI_interrupt_keyboard ; Teclat

    exceptions_vector:
        .word RSE_illegal_ir     ; Inst ilegal - 0
        .word RSE_mem_align      ; acces no alineat - 1
        .word RSE_default_resume ; overflow FP - 2
        .word RSE_default_resume ; divisio 0 FP - 3
        .word RSE_div_zero       ; divisio 0 - 4
        .word RSE_default_resume ;  no definit - 5
        .word RSE_default_resume ; miss TLB instruccions - 6
        .word RSE_default_resume ; miss TLB dades - 7
        .word RSE_default_resume ; pag invalid TLB inst - 8
        .word RSE_default_resume ; pag invalid TLB dades - 9
        .word RSE_default_resume ; pag protegida TLB inst - 10
        .word RSE_mem_protegida  ; pag protegida TLB dades - 11
        .word RSE_default_resume ; pag readonly - 12
        .word RSE_inst_protegida ; Excepcio instruccio protegida - 13
        .word RSE_calls ; Excepcio instruccio protegida - 14


    call_sys_vector:
        .word syscall_default
        .word syscall_default
        .word syscall_default
        .word syscall_default
        .word syscall_default
        .word syscall_default
        .word syscall_default
        .word syscall_default


.text

; ---------------
; Inicialitzacio
; ---------------

 di ; inicialitzacio amb les interrupcions desactivades

 ;movi  r7, 0x00 ; Pila de sist: decreix en
 ;movhi r7, 0x82 ;  RAM: 0x81fe, 0x81fc, ...
; $movei r7, PILA_SISTEMA
;  wrs   s6, r7   ; a s6: la pila de sistema
; 
;  $movei r6, RSG
;  wrs s5, r6  ; Direccio de la RSG
; 
;  ; El retorn de la rutina principal
;  movi  r5, lo( __exit )
;  movhi r5, hi( __exit )

  $MOVEI r1, RSG
  wrs    s5, r1      ;inicializamos en S5 la direccion de la rutina de antencion a la interrupcion
  $MOVEI r7, PILA_USUARI    ;inicializamos R7 como puntero a la pila
  $MOVEI r6, inici   ;direccion de la rutina principal
  wrs s1, r6

 ; Posem paraula d'estat futura (amb mode usuari)
 ;movi r6, 0x01 ; mode usuari, interrupcions activades, overflow fp ens es igual
 movi r6, 0x02 ; mode usuari, interrupcions activades, overflow fp ens es igual
 wrs s0, r6
 
 reti ; Simulem una crida a sistema i retornem a codi d'usuari

; --------
; Rutines gestio
; --------


__exit:
 ; Parem la CPU
 halt


; RSG:
;     rds r7, s6
;     ;salvem nomes r2, r3 i r6 per utilitzarlos de forma segura
;     st (r7), r2
;     addi r7, r7, -2
;     st (r7), r3
;     addi r7, r7, -2
;     st (r7), r6
;     addi r7, r7, -2
; 
; 
;     ; Comencem rutina segons tipus 
;     rds r1, s2
;     movi r2, 14
;     cmpeq r3, r2, r1 ; comprovem si es syscall
;     bnz r3, __call_sistema
;     movi r2, 15
;     cmpeq r3, r2, r1
;     bnz r3, __interrupcion
; __excepcion:
;     $movei r2, exceptions_vector
;     add r1, r1, r1 ; utilitzarem el num dexcepcio com a index, per tant multipliquem per2
;     add r2, r2, r1
;     ld r2, (r2)
;     jal r6, r2 ; saltem a la gestio de la excepcio corresponent
;     bz  r3, __finrsg 
; __call_sistema:
;     rds r1, s3
;     rds r4, s3
;     movi r2, 7
;     and r1, r1, r2 ; mascara 3 bits (8 elements)
;     add r1, r1, r1 ; num com a index, mult per 2
;     $movei r2, call_sys_vector
;     add r2, r2, r1
;     ld r2, (r2)
;     jal r6, r2
;     bnz r3, __finrsg
; __interrupcion:
;     getiid r1
;     add r1, r1, r1
;     $movei r2, interrupts_vector
;     add r2, r2, r1
;     ld r2, (r2)
;     jal r6, r2
; 
; __finrsg:
;     ; Restaurem els 3 registres abans de tornar
;     $ppt r7, r6
;     $ppt r7, r3
;     $ppt r7, r2
;     wrs s6, r7
;     reti

RSG:    wrs   s6, r7
        $MOVEI r7, PILA_SISTEMA
        $PUSH r0, r1, r2, r3, r4, r5, r6 ;salvamos el estado en la pila
				$MOVEI r3, 15
        rds r1, s2           ; llegim codigo INT/EXCP
        $MOVEI r4, d_codigo
        st     0(r4), r1     ; guardem codigo INT/EXCP a mem
				cmpeq r3, r3, r1
        bz r3, __excepcions
__interrupcions:
        getiid r1          
        add r1, r1, r1
        $MOVEI r2, interrupts_vector
        add r2, r2, r1
        ld r2, (r2)
        jmp r2  ; saltant a la pos r1 de RSI_vector

__excepcions:
     $movei r2, exceptions_vector
     add r1, r1, r1 ; utilitzarem el num dexcepcio com a index, per tant multipliquem per2
     add r2, r2, r1
     ld r2, (r2)
     jmp r2 ; saltem a la gestio de la excepcio corresponent
;        movi   r3, 0                     ;comprueba si es una excepcio de illegal_ir
;        cmpeq  r2, r1, r3
;        bnz    r2, __excp_illegal_ir
;        ;$MOVEI r6, __excp_illegal_ir
;        ;jmp    r6
;        movi   r3, 1                     ;comprueba si es una excepcio de mem not align
;        cmpeq  r2, r1, r3 
;        bnz    r2, __excp_mem_align
;        ;$MOVEI r6, __excp_mem_align
;        ;jmp    r6
;        movi   r3, 4                     ;comprueba si es una excepcio de div zero
;        cmpeq  r2, r1, r3
;        bnz    r2, __excp_div_zero
        ;$MOVEI r6, __excp_div_zero
        ;jmp    r6
				
end_int:
        $POP r6, r5, r4, r3, r2, r1, r0  ;restauramos el estado desde la pila (ojo orden inverso)
        rds r7, s6
        reti


        ; *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
        ; Rutina interrupcion reloj
        ; *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
RSI_interrupt_timer:
        $MOVEI r4, d_ticks         ;carga la direccion de memoria donde esta el dato sobre el # de ticks de reloj que han llegado
        ld     r3, 0(r4)           ;carga el numero de ticks
        addi   r3, r3, 1           ;lo incrementa en una unidad
        st     0(r4), r3           ;actualiza la variable sobre el numero de ticks
        out    10, r3              ;muesta el numero de ticks por los visores

        ;reloj
        $MOVEI r4, d_ticks_seg
        ld     r3, 0(r4)
        addi   r3, r3, 1           ;d_ticks_seg++
        st     0(r4), r3
        movi   r1, 20
        cmpeq  r1, r3, r1
        bz     r1, __finreloj
        movi   r3, 0               ;d_ticks_seg=0
        st     0(r4), r3
        $MOVEI r4, d_segundos
        ld     r3, 0(r4)
        addi   r3, r3, 1           ;d_segundos++
        st     0(r4), r3
        movi   r1, 60
        cmpeq  r1, r3, r1
        bz     r1, __finreloj
        movi   r3, 0               ;d_segundos=0
        st     0(r4), r3
        $MOVEI r4, d_minutos
        ld     r3, 0(r4)
        addi   r3, r3, 1           ;d_minutos++
        st     0(r4), r3
        movi   r1, 60
        cmpeq  r1, r3, r1
        bz     r1, __finreloj
        movi   r3, 0               ;d_minutos=0
        st     0(r4), r3
        $MOVEI r4, d_horas
        ld     r3, 0(r4)
        addi   r3, r3, 1           ;d_horas++
        st     0(r4), r3
 __finreloj:
        $MOVEI r6, end_int         ;direccion del fin del servicio de interrupcion
        jmp    r6


        ; *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
        ; Rutina interrupcion pulsadores
        ; *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
RSI_interrupt_key:
        in     r3, 7               ;leemos el valor de los pulsadores
        not    r3,r3               ;los pulsadores son activos a '0'
        movi   r4,0x0F
        and    r3, r3, r4          ;mascara para apagar los leds que no corresponden a ningun pulsador
        out     5, r3              ;activa los leds verdes con el valor de los pulsadores
        $MOVEI r4, d_pulsadores    ;carga la direccion de memoria donde esta el dato sobre el estado de los pulsadores
        st     0(r4), r3           ;actualiza la variable sobre el estado de los pulsadores
        $MOVEI r6, end_int         ;direccion del fin del servicio de interrupcion
        jmp    r6
        ; *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
        ; Rutina interrupcion interruptores
        ; *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
RSI_interrupt_switch:
        in     r3, 8               ;leemos el valor de los interruptores
        out     6, r3              ;activa los leds rojos con el valor de los interruptores
        $MOVEI r4, d_interruptores ;carga la direccion de memoria donde esta el dato sobre el estado de los interruptores
        st     0(r4), r3           ;actualiza la variable sobre el estado de los interruptores
        $MOVEI r6, end_int         ;direccion del fin del servicio de interrupcion
        jmp    r6


        ; *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
        ; Rutina interrupcion teclado PS/2
        ; *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
RSI_interrupt_keyboard:
        in     r3, 15              ;leemos el valor correspondiente al caracter ASCII de la tecla pulsada
        $MOVEI r4, d_tecla         ;carga la direccion de memoria donde esta el dato sobre la ultima tecla pulsada
        ld     r5, 0(r4)           ;carga la ultima tecla pulsada
        st     0(r4), r3           ;actualiza la variable con la nueva tecla pulsada
        cmpeq  r3, r3, r5
        $MOVEI r4, d_clicks_tecla  ;carga la direccion de memoria donde esta el dato sobre el numero de veces que se ha pulsado la ultima tecla
        bz     r3, __distintas
        ; teclas iguales
        ld     r5, 0(r4)           ;carga el numero de veces consecutivas que se ha pulsado la tecla
        addi   r5, r5, 1           ;se incrementa en 1 el numero de repeticiones consecutivas
        bnz r3, __fin_keyboard
__distintas:
        ; teclas distintas 
        movi   r5, 1               ;es la primera vez que se pulsa
__fin_keyboard:
        st     0(r4), r5           ;actualiza la variable con el numero de repeticiones
        $MOVEI r6, end_int         ;direccion del fin del servicio de interrupcion
        jmp    r6


        ; *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
        ; Rutina excp illegal ir
        ; *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*

RSE_illegal_ir:
        $MOVEI r4, d_illegal_ir 
        ld     r3 ,0(r4)       
        addi   r3, r3, 1
        st     0(r4), r3      
        $MOVEI r6, __fin_binf         ;direccion del fin del servicio de interrupcion
        wrs s1, r6
        $MOVEI r6, end_int         ;direccion del fin del servicio de interrupcion
        jmp    r6
        ; *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
        ; Rutina excp mem align
        ; *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*

RSE_mem_align:
        $MOVEI r4, d_mem_align 
        ld     r3 ,0(r4)           
        addi   r3, r3, 1
        st     0(r4), r3          
        $MOVEI r4, d_mem_align_addr 
        rds r3, s3
        st     0(r4), r3          
        $MOVEI r6, end_int         ;direccion del fin del servicio de interrupcion
        jmp    r6

        ; *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
        ; Rutina excp division por zero
        ; *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
RSE_div_zero:
        $MOVEI r4, d_div_zero
        ld     r3 ,0(r4)       
        addi   r3, r3, 1
        st     0(r4), r3      
        $MOVEI r6, end_int     ;direccion del fin del servicio de interrupcion
        jmp    r6

RSE_default_resume:
    $MOVEI r6, end_int
    jmp r6

    
RSE_mem_protegida: ; posem el flag per comprovar
    $MOVEI r4, d_protected_mem
    ld     r3 ,0(r4)       
    addi   r3, r3, 1
    st     0(r4), r3      
    $MOVEI r6, end_int
    jmp r6

RSE_inst_protegida:
    $MOVEI r4, d_protected_ir
    ld     r3 ,0(r4)       
    addi   r3, r3, 1
    st     0(r4), r3      
    $MOVEI r6, end_int
    jmp r6
 
RSE_calls:
    $MOVEI r4, d_calls
    ld     r3 ,0(r4)           
    addi   r3, r3, 1
    st     0(r4), r3          
    $MOVEI r3, call_sys_vector
    rds r4, s3
    add r6, r4,r4
    add r6, r6, r3
    jmp r6

syscall_default:
    $MOVEI r1, d_syscall
    st (r1), r4 ; guardem el codi de la crida
    $MOVEI r6, end_int
    jmp r6
