onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider TEST-SISA
add wave -noupdate -radix hexadecimal /test_sisa/clk
add wave -noupdate -radix hexadecimal /test_sisa/reset_proc
add wave -noupdate -radix hexadecimal /test_sisa/reset_ram
add wave -noupdate -radix hexadecimal /test_sisa/addr_mem
add wave -noupdate -radix hexadecimal /test_sisa/data_mem
add wave -noupdate -radix hexadecimal /test_sisa/addr_SoC
add wave -noupdate -radix hexadecimal /test_sisa/botones(9)
add wave -noupdate -divider SOC
add wave -noupdate -divider proc
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/c0/m0/state
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/clk
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/boot
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/datard_m
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/word_byte
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/wr_m
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/data_wr
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/addr_m
add wave -noupdate -divider mem0
add wave -noupdate -radix hexadecimal /test_sisa/SoC/mem0/CLOCK_50
add wave -noupdate -radix hexadecimal /test_sisa/SoC/mem0/addr
add wave -noupdate -radix hexadecimal /test_sisa/SoC/mem0/wr_data
add wave -noupdate -radix hexadecimal /test_sisa/SoC/mem0/we
add wave -noupdate -radix hexadecimal /test_sisa/SoC/mem0/byte_m
add wave -noupdate -radix hexadecimal /test_sisa/SoC/mem0/rd_data
add wave -noupdate -radix hexadecimal /test_sisa/SoC/mem0/SRAM_ADDR
add wave -noupdate -radix hexadecimal /test_sisa/SoC/mem0/SRAM_DQ
add wave -noupdate -radix hexadecimal /test_sisa/SoC/mem0/SRAM_UB_N
add wave -noupdate -radix hexadecimal /test_sisa/SoC/mem0/SRAM_LB_N
add wave -noupdate -radix hexadecimal /test_sisa/SoC/mem0/SRAM_CE_N
add wave -noupdate -radix hexadecimal /test_sisa/SoC/mem0/SRAM_OE_N
add wave -noupdate -radix hexadecimal /test_sisa/SoC/mem0/SRAM_WE_N
add wave -noupdate -divider <NULL>
add wave -noupdate -divider BR
add wave -noupdate -radix hexadecimal -childformat {{/test_sisa/SoC/proc0/e0/BR/BR(0) -radix hexadecimal} {/test_sisa/SoC/proc0/e0/BR/BR(1) -radix hexadecimal} {/test_sisa/SoC/proc0/e0/BR/BR(2) -radix hexadecimal} {/test_sisa/SoC/proc0/e0/BR/BR(3) -radix hexadecimal} {/test_sisa/SoC/proc0/e0/BR/BR(4) -radix hexadecimal} {/test_sisa/SoC/proc0/e0/BR/BR(5) -radix hexadecimal} {/test_sisa/SoC/proc0/e0/BR/BR(6) -radix hexadecimal} {/test_sisa/SoC/proc0/e0/BR/BR(7) -radix hexadecimal}} -subitemconfig {/test_sisa/SoC/proc0/e0/BR/BR(0) {-height 15 -radix hexadecimal} /test_sisa/SoC/proc0/e0/BR/BR(1) {-height 15 -radix hexadecimal} /test_sisa/SoC/proc0/e0/BR/BR(2) {-height 15 -radix hexadecimal} /test_sisa/SoC/proc0/e0/BR/BR(3) {-height 15 -radix hexadecimal} /test_sisa/SoC/proc0/e0/BR/BR(4) {-height 15 -radix hexadecimal} /test_sisa/SoC/proc0/e0/BR/BR(5) {-height 15 -radix hexadecimal} /test_sisa/SoC/proc0/e0/BR/BR(6) {-height 15 -radix hexadecimal} /test_sisa/SoC/proc0/e0/BR/BR(7) {-height 15 -radix hexadecimal}} /test_sisa/SoC/proc0/e0/BR/BR
add wave -noupdate -divider DATAPATH
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/e0/wrd
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/e0/addr_a
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/e0/addr_b
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/e0/addr_d
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/e0/immed
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/e0/immed_x2
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/e0/datard_m
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/e0/ins_dad
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/e0/pc
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/e0/in_d
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/e0/addr_m
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/e0/data_wr
add wave -noupdate -divider Alu
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/e0/ALUop/x
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/e0/ALUop/y
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/e0/ALUop/op
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/e0/ALUop/w
add wave -noupdate -radix hexadecimal /test_sisa/SoC/proc0/e0/ALUop/z
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0} {{Cursor 2} {38 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 270
configure wave -valuecolwidth 50
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1000
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {633478 ps}
