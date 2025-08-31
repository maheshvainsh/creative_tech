`ifndef PCIE_MEM_MODEL_SV
`define PCIE_MEM_MODEL_SV

// ----------------------------------------------------
// Simple PCIe Memory Model (Write + Read only)
// ----------------------------------------------------
class pcie_mem_model #(parameter MEM_SIZE_BYTES = 1024) ;  // default 1 KB

  // internal memory
  bit [7:0] mem [0:MEM_SIZE_BYTES-1];

  // -------------------------------
  // Write task
  // -------------------------------
  task automatic write_mem(input int unsigned addr,
                           input bit[7:0] data[]);
    if (addr + data.size() > MEM_SIZE_BYTES) begin
      $display("[%0t] ERROR: Write out of bounds! addr=0x%0h len=%0d",
                $time, addr, data.size());
      return;
    end
    for (int i = 0; i < data.size(); i++) begin
      mem[addr + i] = data[i];
    end
    $display("[%0t] WRITE: addr=0x%0h len=%0d", $time, addr, data.size());
  endtask

  // -------------------------------
  // Read task
  // -------------------------------
  task automatic read_mem(input int unsigned addr,
                          input int unsigned length,
                          output [7:0] data[]);
    if (addr + length > MEM_SIZE_BYTES) begin
      $display("[%0t] ERROR: Read out of bounds! addr=0x%0h len=%0d",
                $time, addr, length);
      data = {};
      return;
    end
    data = new[length];
    for (int i = 0; i < length; i++) begin
      data[i] = mem[addr + i];
    end
    $display("[%0t] READ : addr=0x%0h len=%0d", $time, addr, length);
  endtask

endclass : pcie_mem_model 
`endif //PCIE_MEM_MODEL_SV
