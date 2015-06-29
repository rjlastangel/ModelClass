function [holding_daily, rtn_daily] = BackTest(back_handle, model, pltfm, begin_date, end_date)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    back_handle.DispInfo();
    stock_data = pltfm.ch_stk_data;
    Mkt_tradedays = stock_data.Mkt_tradedays;
    tickers = stock_data.TickersCell;
    ret = stock_data.Return;
    ret(isnan(ret)) = 0;
    gap = back_handle.day;
    cost = model.GetCost();
    universe = model.GetUniverse();
    
    begin_index = find(Mkt_tradedays >= begin_date);
    begin_index = begin_index(1);
    end_index = find(Mkt_tradedays <= end_date);
    end_index = end_index(end);
    
    %计算每一天的单独持仓
    pos = zeros(end_index, length(stock_data.TickersCell));
    trade_flag = pos;
    for index = begin_index:gap:end_index
        trade_flag(index) = 1;
        [out_1, out_2] = model.ModelPort(pltfm, Mkt_tradedays(index));
        pos(index, :) = (pltfm.SYS_ModelDataMapToMat(out_1, tickers))';     
        if index < end_index && gap > 1
            last_index = index+gap-1;
            if last_index > end_index
                last_index = end_index;
            end
            pos((index+1):last_index) = pos(index);
        end
    end
    
    %从每天的模型持仓计算出真实持仓和每日收益率
    [holding_daily, rtn_daily] = pltfm.SYS_Pos2DPosWeight(Mkt_tradedays, pos, ret, trade_flag, cost);
    
end

