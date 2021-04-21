in   r1, 7    ; llegim port input KEY a r1
out  5, r1   ; escribim r1 a port output LEDG
in   r1, 8    ; llegim port input SW7..0 a r1
out  6, r1   ; escribim r1 a port output LEDR
halt
