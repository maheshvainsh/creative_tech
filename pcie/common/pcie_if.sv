interface pcie_if #(NUMBER_OF_LANE);


//tx link diff pair 
logic tx_p[NUMBER_OF_LANE];
logic tx_n[NUMBER_OF_LANE];

//rx link with diff pair
logic tx_p[NUMBER_OF_LANE];
logic tx_n[NUMBER_OF_LANE];


endinterface : pcie_if
