function [holding_daily, rtn_daily] = BackTest(back_handle, model, pltfm, begin_date, end_date)
%UNTITLED4 Summary of this function goes here
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
    last_month = mod(fix(begin_date / 100), 100);
    last_is_first_half = mod(begin_date, 100) <= 15;
    for index = (begin_index+1) : (end_index-1)
        this_month = mod(fix(Mkt_tradedays(index) / 100), 100);
        next_month = mod(fix(Mkt_tradedays(index+1) / 100), 100);
        this_day = mod(Mkt_tradedays(index), 100);
        if (day == -1 && this_month ~= next_month) || (day == 0 && last_is_first_half && (this_day > 15)) || (day == 1 && last_month ~= this_month)
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
        last_month = this_month;
        last_is_first_half = this_day <= 15;
    end
    pos(end_index, :) = pos(end_index-1, :);

    %从每天的模型持仓计算出真实持仓和每日收益率
    [holding_daily, rtn_daily] = pltfm.SYS_Pos2DPosWeight(Mkt_tradedays, pos, ret, trade_flag, cost);
end

