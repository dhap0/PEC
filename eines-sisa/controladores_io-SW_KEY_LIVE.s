movi r0, 0
movi r1, 1
movi r2, 15
a:  in   r1, 7    ; llegim port input KEY a r1
    out  5, r1   ; escribim r1 a port output LEDG
    out  9, r1   ; escribim r1 a port output mostra HEX's
    out 8, r2    ; escrivim r2 a port input SW
    in   r1, 8    ; llegim port input SW7..0 a r1
    out  10, r1  ;  escrivim r1 a port output HEX's
    out  6, r1   ; escribim r1 a port output LEDR
    bz r0, a
halt
