function dayHolding = SYS_GetDailyHolding(pltfm, Holding_struct, int_dt)
    Mkt_tradedays = Holding_struct.row;
    cellTickers = Holding_struct.column;
    DPosWeight = Holding_struct.matrix;
    
    iy = Mkt_tradedays==int_dt;
    if sum(iy) <= 0 
        dayHolding = -1;
    else
        
        holding = DPosWeight(Mkt_tradedays==int_dt,:);
        tickHolding = cellTickers(holding>0.0001);
        wghtholding = holding(holding>0.0001);
        
        [sortholding, ix] = sort(wghtholding, 2, 'descend'); 
         sortTick = tickHolding(ix);
        dayHolding = pltfm.SYS_MergeArrays(sortTick', sortholding');
    end
end