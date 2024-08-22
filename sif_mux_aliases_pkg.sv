
package sif_mux_aliases_pkg;

    `ifndef SIVREV
        parameter SIFREV = 2;
    
`endif
      
    typedef logic [31:0] MAX_mux_reg_t;  //internal register for the MAX14661ETI multiplexer chip
    // First Byte: Switch 16B -> Switch 9B
    // Second Byte: Switch 8B -> Switch 1B
    // Third Byte: Switch 16A -> Switch 9A
    // Fourth Byte: Switch 8A -> Switch 1A    see page 19 of datasheet
    
    //for SIF Rev 2, COMB is grounded, COMA is signals
    //for SIF Rev 3, COMA is grounded, COMB is signals, this is different for routing congestion reasons
    
    //TX1 bit aliases
    function MAX_mux_reg_t resolveTX1(input logic[3:0] addr);  //addr is 0-15
        if(SIFREV == 2)
            case(addr)       ///   B                      A
                0:      return 32'b1111_1111_1111_1110____0000_0000_0000_0001;
                1:      return 32'b1111_1111_1111_1101____0000_0000_0000_0010;
                2:      return 32'b1111_1111_1111_1011____0000_0000_0000_0100;
                3:      return 32'b1111_1111_1111_0111____0000_0000_0000_1000;
                4:      return 32'b1111_1111_1110_1111____0000_0000_0001_0000;
                5:      return 32'b1111_1111_1101_1111____0000_0000_0010_0000;
                6:      return 32'b1111_1111_1011_1111____0000_0000_0100_0000;
                7:      return 32'b1111_1111_0111_1111____0000_0000_1000_0000;
                8:      return 32'b1111_1110_1111_1111____0000_0001_0000_0000;
                9:      return 32'b1111_1101_1111_1111____0000_0010_0000_0000;
                10:     return 32'b1111_1011_1111_1111____0000_0100_0000_0000;
                11:     return 32'b1111_0111_1111_1111____0000_1000_0000_0000;
                12:     return 32'b1110_1111_1111_1111____0001_0000_0000_0000;
                13:     return 32'b1101_1111_1111_1111____0010_0000_0000_0000;
                14:     return 32'b1011_1111_1111_1111____0100_0000_0000_0000;
                15:     return 32'b0111_1111_1111_1111____1000_0000_0000_0000;
            endcase
        else if(SIFREV == 3)
            case(addr)
                0:      return 32'b0;
                1:      return 32'b0;
                2:      return 32'b0;
                3:      return 32'b0;
                4:      return 32'b0;
                5:      return 32'b0;
                6:      return 32'b0;
                7:      return 32'b0;
                8:      return 32'b0;
                9:      return 32'b0;
                10:     return 32'b0;
                11:     return 32'b0;
                12:     return 32'b0;
                13:     return 32'b0;
                14:     return 32'b0;
                15:     return 32'b0;
            endcase
    endfunction
    

    //TX2 bit aliases
    function MAX_mux_reg_t resolveTX2(input logic[3:0] addr);  //addr is 0-15
        if(SIFREV == 2)
            case(addr)       ///   B                      A
                0:      return 32'b1111_1111_1111_1110____0000_0000_0000_0001;
                1:      return 32'b1111_1111_1111_1101____0000_0000_0000_0010;
                2:      return 32'b1111_1111_1111_1011____0000_0000_0000_0100;
                3:      return 32'b1111_1111_1111_0111____0000_0000_0000_1000;
                4:      return 32'b1111_1111_1110_1111____0000_0000_0001_0000;
                5:      return 32'b1111_1111_1101_1111____0000_0000_0010_0000;
                6:      return 32'b1111_1111_1011_1111____0000_0000_0100_0000;
                7:      return 32'b1111_1111_0111_1111____0000_0000_1000_0000;
                8:      return 32'b1111_1110_1111_1111____0000_0001_0000_0000;
                9:      return 32'b1111_1101_1111_1111____0000_0010_0000_0000;
                10:     return 32'b1111_1011_1111_1111____0000_0100_0000_0000;
                11:     return 32'b1111_0111_1111_1111____0000_1000_0000_0000;
                12:     return 32'b1110_1111_1111_1111____0001_0000_0000_0000;
                13:     return 32'b1101_1111_1111_1111____0010_0000_0000_0000;
                14:     return 32'b1011_1111_1111_1111____0100_0000_0000_0000;
                15:     return 32'b0111_1111_1111_1111____1000_0000_0000_0000;
            endcase
        else if(SIFREV == 3)
            case(addr)
                0:      return 32'b0;
                1:      return 32'b0;
                2:      return 32'b0;
                3:      return 32'b0;
                4:      return 32'b0;
                5:      return 32'b0;
                6:      return 32'b0;
                7:      return 32'b0;
                8:      return 32'b0;
                9:      return 32'b0;
                10:     return 32'b0;
                11:     return 32'b0;
                12:     return 32'b0;
                13:     return 32'b0;
                14:     return 32'b0;
                15:     return 32'b0;
            endcase
    endfunction
    
    //RX1 bit aliases
    function MAX_mux_reg_t resolveRX1(input logic[3:0] addr);  //addr is 0-15
        if(SIFREV == 2)
            case(addr)       ///   B                      A
                0:      return 32'b1111_1111_1111_1110____0000_0000_0000_0001;
                1:      return 32'b1111_1111_1111_1101____0000_0000_0000_0010;
                2:      return 32'b1111_1111_1111_1011____0000_0000_0000_0100;
                3:      return 32'b1111_1111_1111_0111____0000_0000_0000_1000;
                4:      return 32'b1111_1111_1110_1111____0000_0000_0001_0000;
                5:      return 32'b1111_1111_1101_1111____0000_0000_0010_0000;
                6:      return 32'b1111_1111_1011_1111____0000_0000_0100_0000;
                7:      return 32'b1111_1111_0111_1111____0000_0000_1000_0000;
                8:      return 32'b1111_1110_1111_1111____0000_0001_0000_0000;
                9:      return 32'b1111_1101_1111_1111____0000_0010_0000_0000;
                10:     return 32'b1111_1011_1111_1111____0000_0100_0000_0000;
                11:     return 32'b1111_0111_1111_1111____0000_1000_0000_0000;
                12:     return 32'b1110_1111_1111_1111____0001_0000_0000_0000;
                13:     return 32'b1101_1111_1111_1111____0010_0000_0000_0000;
                14:     return 32'b1011_1111_1111_1111____0100_0000_0000_0000;
                15:     return 32'b0111_1111_1111_1111____1000_0000_0000_0000;
            endcase
        else if(SIFREV == 3)
            case(addr)
                0:      return 32'b0;
                1:      return 32'b0;
                2:      return 32'b0;
                3:      return 32'b0;
                4:      return 32'b0;
                5:      return 32'b0;
                6:      return 32'b0;
                7:      return 32'b0;
                8:      return 32'b0;
                9:      return 32'b0;
                10:     return 32'b0;
                11:     return 32'b0;
                12:     return 32'b0;
                13:     return 32'b0;
                14:     return 32'b0;
                15:     return 32'b0;
            endcase
    endfunction
    
    //RX2 bit aliases
    function MAX_mux_reg_t resolveRX2(input logic[3:0] addr);  //addr is 0-15
        if(SIFREV == 2)
            case(addr)       ///   B                      A
                0:      return 32'b1111_1111_1111_1110____0000_0000_0000_0001;
                1:      return 32'b1111_1111_1111_1101____0000_0000_0000_0010;
                2:      return 32'b1111_1111_1111_1011____0000_0000_0000_0100;
                3:      return 32'b1111_1111_1111_0111____0000_0000_0000_1000;
                4:      return 32'b1111_1111_1110_1111____0000_0000_0001_0000;
                5:      return 32'b1111_1111_1101_1111____0000_0000_0010_0000;
                6:      return 32'b1111_1111_1011_1111____0000_0000_0100_0000;
                7:      return 32'b1111_1111_0111_1111____0000_0000_1000_0000;
                8:      return 32'b1111_1110_1111_1111____0000_0001_0000_0000;
                9:      return 32'b1111_1101_1111_1111____0000_0010_0000_0000;
                10:     return 32'b1111_1011_1111_1111____0000_0100_0000_0000;
                11:     return 32'b1111_0111_1111_1111____0000_1000_0000_0000;
                12:     return 32'b1110_1111_1111_1111____0001_0000_0000_0000;
                13:     return 32'b1101_1111_1111_1111____0010_0000_0000_0000;
                14:     return 32'b1011_1111_1111_1111____0100_0000_0000_0000;
                15:     return 32'b0111_1111_1111_1111____1000_0000_0000_0000;
            endcase
        else if(SIFREV == 3)
            case(addr)
                0:      return 32'b0;
                1:      return 32'b0;
                2:      return 32'b0;
                3:      return 32'b0;
                4:      return 32'b0;
                5:      return 32'b0;
                6:      return 32'b0;
                7:      return 32'b0;
                8:      return 32'b0;
                9:      return 32'b0;
                10:     return 32'b0;
                11:     return 32'b0;
                12:     return 32'b0;
                13:     return 32'b0;
                14:     return 32'b0;
                15:     return 32'b0;
            endcase
    endfunction
    
endpackage