//apb slave with no wait state

module apb_slave 
#(parameter DATASIZE = 32,
	    ADDRSIZE = 32,
            DEPTH    = 1 << ADDRSIZE           
)
(input PCLK,
 input      PRESETn,
 input      [ADDRSIZE-1 : 0] PADDR,
 input      [DATASIZE-1 : 0] PWDATA,
 input      PSEL,
 input      PWRITE,
 input      PENABLE,
 output reg [DATASIZE-1 : 0] PRDATA,
 output reg PREADY
);

reg [DATASIZE-1 : 0] register [0:255]; // REGISTER FILE FOR TESTING THE READ AND WRITE TRANSFERS 



always @(posedge PCLK)
if(!PRESETn) begin
  PREADY <= 0;
end
else if (PSEL && !PENABLE) begin // Device selection only
  PREADY <= 1'bx;
end

else if(PSEL && PENABLE && !PWRITE) begin // READ OPERATION
 PRDATA <= register[PADDR];
 PREADY <= 1;
end

else if (PSEL && PENABLE && PWRITE) begin //WRITE OPERATION
 register[PADDR] <= PWDATA;
 PREADY <= 1;
end

else PREADY <= 1'bx;


endmodule
