onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /test_sisa/proc0/clk
add wave -noupdate -radix hexadecimal /test_sisa/proc0/boot
add wave -noupdate -radix hexadecimal /test_sisa/proc0/c0/m0/state
add wave -noupdate -radix hexadecimal /test_sisa/proc0/addr_m
add wave -noupdate -radix hexadecimal /test_sisa/proc0/datard_m
add wave -noupdate -radix hexadecimal /test_sisa/proc0/data_wr
add wave -noupdate -radix hexadecimal /test_sisa/proc0/wr_m
add wave -noupdate -radix hexadecimal /test_sisa/proc0/word_byte
add wave -noupdate -divider {Unidad de Control}
add wave -noupdate -radix hexadecimal /test_sisa/proc0/c0/pc
add wave -noupdate -radix hexadecimal /test_sisa/proc0/c0/ir
add wave -noupdate -radix hexadecimal /test_sisa/proc0/c0/m0/state
add wave -noupdate -radix hexadecimal /test_sisa/proc0/c0/ldpc_t
add wave -noupdate -radix hexadecimal /test_sisa/proc0/c0/ldir_o
add wave -noupdate -radix hexadecimal /test_sisa/proc0/c0/new_pc
add wave -noupdate -radix hexadecimal /test_sisa/proc0/c0/in_d
add wave -noupdate -radix hexadecimal /test_sisa/proc0/c0/ins_dad
add wave -noupdate -radix hexadecimal /test_sisa/proc0/c0/immed_x2
add wave -noupdate /test_sisa/proc0/c0/deco/wrd
add wave -noupdate /test_sisa/proc0/c0/wrd
add wave -noupdate -divider Control_l
add wave -noupdate -radix hexadecimal /test_sisa/proc0/c0/deco/coop
add wave -noupdate -radix hexadecimal /test_sisa/proc0/c0/deco/immed
add wave -noupdate -radix hexadecimal /test_sisa/proc0/c0/deco/immed_6
add wave -noupdate -radix hexadecimal /test_sisa/proc0/c0/deco/immed_8
add wave -noupdate -divider Datapath
add wave -noupdate -radix hexadecimal /test_sisa/proc0/e0/ins_dad
add wave -noupdate -radix hexadecimal /test_sisa/proc0/e0/in_d
add wave -noupdate -radix hexadecimal /test_sisa/proc0/e0/immed_x2
add wave -noupdate -radix hexadecimal /test_sisa/proc0/e0/immed
add wave -noupdate -radix hexadecimal /test_sisa/proc0/e0/datard_m
add wave -noupdate -divider Alu
add wave -noupdate -radix hexadecimal /test_sisa/proc0/e0/ALUop/x
add wave -noupdate -radix hexadecimal /test_sisa/proc0/e0/ALUop/y
add wave -noupdate -radix hexadecimal /test_sisa/proc0/e0/ALUop/op
add wave -noupdate -radix hexadecimal /test_sisa/proc0/e0/ALUop/w
add wave -noupdate -divider {Banco de Registros}
add wave -noupdate -radix hexadecimal /test_sisa/proc0/clk
add wave -noupdate -radix hexadecimal /test_sisa/proc0/e0/BR/addr_a
add wave -noupdate -radix hexadecimal /test_sisa/proc0/e0/BR/a
add wave -noupdate -radix hexadecimal /test_sisa/proc0/e0/BR/addr_b
add wave -noupdate -radix hexadecimal /test_sisa/proc0/e0/BR/b
add wave -noupdate -radix hexadecimal /test_sisa/proc0/e0/BR/addr_d
add wave -noupdate -radix hexadecimal /test_sisa/proc0/e0/BR/wrd
add wave -noupdate -radix hexadecimal /test_sisa/proc0/e0/BR/d
add wave -noupdate -radix hexadecimal -childformat {{/test_sisa/proc0/e0/BR/BR(0) -radix hexadecimal} {/test_sisa/proc0/e0/BR/BR(1) -radix hexadecimal} {/test_sisa/proc0/e0/BR/BR(2) -radix hexadecimal} {/test_sisa/proc0/e0/BR/BR(3) -radix hexadecimal} {/test_sisa/proc0/e0/BR/BR(4) -radix hexadecimal} {/test_sisa/proc0/e0/BR/BR(5) -radix hexadecimal} {/test_sisa/proc0/e0/BR/BR(6) -radix hexadecimal} {/test_sisa/proc0/e0/BR/BR(7) -radix hexadecimal}} -expand -subitemconfig {/test_sisa/proc0/e0/BR/BR(0) {-height 15 -radix hexadecimal} /test_sisa/proc0/e0/BR/BR(1) {-height 15 -radix hexadecimal} /test_sisa/proc0/e0/BR/BR(2) {-height 15 -radix hexadecimal} /test_sisa/proc0/e0/BR/BR(3) {-height 15 -radix hexadecimal} /test_sisa/proc0/e0/BR/BR(4) {-height 15 -radix hexadecimal} /test_sisa/proc0/e0/BR/BR(5) {-height 15 -radix hexadecimal} /test_sisa/proc0/e0/BR/BR(6) {-height 15 -radix hexadecimal} /test_sisa/proc0/e0/BR/BR(7) {-height 15 -radix hexadecimal}} /test_sisa/proc0/e0/BR/BR
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {297025 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 243
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1000
configure wave -griddelta 40
configure wave -timeline 1
configure wave -timelineunits ns
update
WaveRestoreZoom {88550 ps} {321655 ps}
