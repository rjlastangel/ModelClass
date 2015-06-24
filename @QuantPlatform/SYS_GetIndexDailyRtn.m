function index_rtn = SYS_GetIndexDailyRtn(pltfm, Mkt_tradedays, IDXcellTicker)


    data = pltfm.ch_idx_data;
    rtn = data.Return;   
    [nd, ns] = size(rtn);
    idx = data.Mkt_tradedays >= Mkt_tradedays(1) & data.Mkt_tradedays <= Mkt_tradedays(end);
    idy = ismember(IDXcellTicker, data.TickersCell);
    if nd > 1 && ns == 1
        rtn = rtn(idx, :);
    end
    if nd == 1 && ns > 1
        rtn = rtn(:, idy);
    end
    if nd > 1 && ns > 1
        rtn = rtn(idx, idy);
    end
    
    
    mktcell=mat2cell(Mkt_tradedays, ones(1, length(Mkt_tradedays)), 1);
    index_rtn = [mktcell mat2cell(rtn, ones(1, length(rtn)), 1)];
end