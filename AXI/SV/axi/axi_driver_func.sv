// 1. byte-aligned checker

function void byte_aligned_checker(`AXI_SEQ_ITEM it);
	///////////////////////////////////////////////////////
	// Declare variables below
	///////////////////////////////////////////////////////
	`AXI_SEQ_ITEM it_2;
	bit [addr_bits-1:0] start_addr ;
	bit [addr_bits-1:0] end_addr   ;
	///////////////////////////////////////////////////////
	// check byte size
	///////////////////////////////////////////////////////
	case (it.size)
		`AXI_1_BYTE   : begin end
		`AXI_2_BYTE   : begin
			if (it.addr[0] != 1'b0) begin
				bit [    data_bits-1:0] dbuf [17];
				bit [(data_bits/8)-1:0] dstrb[17];

				dbuf  = '{default:{data_bits{1'b0}}}    ;
				dstrb = '{default:{(data_bits/8){1'b0}}};

				dbuf[0] = it.data[0] << (8*it.addr[0]);
				for (int i=1;i<(data_bits/8);i++) begin
					dstrb[i] = (it.strb[i-1] >> ((data_bits/8)-it.addr[0]))
					          |(it.strb[i  ] << (              it.addr[0]));
				end

				for (int i=1;i<16;i++) begin
					bit [data_bits-1:0] buf_tmp;
					buf_tmp = (it.data[i-1] >> (data_bits - 8*it.addr[0]))
					         |(it.data[i  ] << (            8*it.addr[0]));
					dbuf[i] = buf_tmp;
				end
				dbuf[16] = it.data[15] >> (data_bits-8*it.addr[0]); // --> next transaction
				for (int i=0;i<16;i++) 
					it.data[i] = dbuf[i];
				// TODO: from here

				start_addr = {it.addr[addr_bits-1:1], 1'b0};
				end_addr   = start_addr + 2 * (it.len+1);
				if (it.len == 4'hf) begin // more than max. trans.
					it_2 = `AXI_SEQ_ITEM::type_id::create("sec_item");
					it_2.deep_copy(it);
					it_2.addr    = end_addr         ;
					it_2.len     = 0                ;
					it_2.data    = '{default:0}     ;
					it_2.data[0] = dbuf[16]         ;
				end
			end
		end
		`AXI_4_BYTE   : begin
			if (it.addr[1:0] != 2'b0) begin
				bit [    data_bits-1:0] dbuf [17];
				bit [(data_bits/8)-1:0] dstrb[17];

				dbuf  = '{default:{data_bits{1'b0}}}    ;
				dstrb = '{default:{(data_bits/8){1'b0}}};

				dbuf[0] = it.data[0] << (8*it.addr[0]);
				for (int i=1;i<(data_bits/8);i++) begin
					dstrb[i] = (it.strb[i-1] >> ((data_bits/8)-it.addr[1:0]))
					          |(it.strb[i  ] << (              it.addr[1:0]));
				end

				for (int i=1;i<16;i++) begin
					bit [data_bits-1:0] buf_tmp;
					buf_tmp = (it.data[i-1] >> (data_bits - 8*it.addr[1:0]))
					         |(it.data[i  ] << (            8*it.addr[1:0]));
					dbuf[i] = buf_tmp;
				end
				dbuf[16] = it.data[15] >> (data_bits-8*it.addr[1:0]); // --> next transaction
				for (int i=0;i<16;i++) 
					it.data[i] = dbuf[i];
				// TODO: from here

				start_addr = {it.addr[addr_bits-1:1], 1'b0};
				end_addr   = start_addr + 2 * (it.len+1);
				if (it.len == 4'hf) begin // more than max. trans.
					it_2 = `AXI_SEQ_ITEM::type_id::create("sec_item");
					it_2.deep_copy(it);
					it_2.addr    = end_addr         ;
					it_2.len     = 0                ;
					it_2.data    = '{default:0}     ;
					it_2.data[0] = dbuf[16]         ;
				end
			end

		end
		`AXI_8_BYTE   : if (it.addr[2:0] != 3'b0) ;
		`AXI_16_BYTE  : if (it.addr[3:0] != 4'b0) ;
	endcase

endfunction
