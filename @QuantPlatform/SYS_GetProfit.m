function profits = SYS_GetProfit(pltfm, hold, start_date, end_date)
%SYS_GETPROFIT Summary of this function goes here
%   Detailed explanation goes here

    stk_data = pltfm.ch_stk_data;
    Mkt_tradedays = stk_data.Mkt_tradedays;
    start_index = find(Mkt_tradedays >= start_date);
    start_index = start_index(1)
    end_index = find(Mkt_tradedays <= end_date);
    end_index = end_index(end)
    price = stk_data.close;
    price(isnan(price)) = 0;
    
    profits = sum(hold .* ((price(end_index, :) - price(start_index, :)) / price(start_index, :)));
end

