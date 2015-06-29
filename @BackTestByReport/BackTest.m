function [holding_daily, rtn_daily] = BackTest(back_handle, model, pltfm, begin_date, end_date)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
    back_handle.DispInfo();
    
    stock_data = pltfm.ch_stk_data;
    Mkt_tradedays = stock_data.Mkt_tradedays;
    tickers = stock_data.TickersCell;
    ret = stock_data.Return;
    ret(isnan(ret)) = 0;
    day = back_handle.day;
    cost = model.GetCost();
    
    begin_index = find(Mkt_tradedays >= begin_date);
    begin_index = begin_index(1);
    end_index = find(Mkt_tradedays <= end_date);
    end_index = end_index(end);
        
    %计算每一天的单独持仓
    pos = zeros(end_index, length(stock_data.TickersCell));
    trade_flag = zeros(end_index, 1);
    date = mod(begin_date, 10000);
    last_status = mod((date > 400) + (date > 900) + (date > 1100), 3);
    for index = (begin_index+1) : (end_index-1)
        date = mod(Mkt_tradedays(index), 10000);
        status = mod((date > 400) + (date > 900) + (date > 1100), 3);
        if (day == 1 && last_status ~= status && last_status*status == 0) || (day == 2 && last_status ~= status)
            trade_flag(index) = 1;
            [out_1, out_2] = model.ModelPort(pltfm, Mkt_tradedays(index));
            pos(index, :) = (pltfm.SYS_ModelDataMapToMat(out_1, tickers))';            
        else
            if index == 1
                pos(index, :) = 0;
            else
                pos(index, :) = pos(index-1, :);
            end
        end
        last_status = status;
    end
    pos(end_index, :) = pos(end_index-1, :);
    
    %从每天的模型持仓计算出真实持仓和每日收益率
    [holding_daily, rtn_daily] = pltfm.SYS_Pos2DPosWeight(Mkt_tradedays, pos, ret, trade_flag, cost);
    
end

