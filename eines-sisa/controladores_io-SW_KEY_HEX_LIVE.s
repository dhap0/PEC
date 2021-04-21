movi r0, 0
movi r1, 0x55
movhi r1, 0xaa
out 10, r1     ; escribim r1 a port output HEX
in r2, 10      ; llegim port HEX a r2
out 5, r2      ; posem r2 a LEDG
halt
;a: in   r1, 7    ; llegim port input KEY a r1
;  out  5, r1   ; escribim r1 a port output LEDG
;  in   r1, 8    ; llegim port input SW7..0 a r1
;  out  6, r1   ; escribim r1 a port output LEDR
;  bz r0, a
;halt
