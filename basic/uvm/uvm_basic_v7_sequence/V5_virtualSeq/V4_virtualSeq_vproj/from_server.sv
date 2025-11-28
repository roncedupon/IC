virtual task·body();
apb_seg=seq2_first_send::type id::create("apb seq");
spi_seq=spi slave seq::type id::create("spi seq");
spi_seq.nums=apb_seq.nums;
spi_seq.DFS=apb_seq.DFS;spi seq.SCPoL=apb seq.SCPOL;
spi_seq.SCPH=apb_seq.SCPH;
fork
uvm do on(apb seq,p sequencer.apb seqr);
uvm do on(spi seq,p sequencer.spi seqr);
join
endtask