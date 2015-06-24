function [Holding_Daily, rtn_daily] = SYS_GetOutputData(pltfm, NAV_struct, TradeFlag, cost, Mkt_tradedays, nstart)
    [rtn_daily,Holding_Daily] = pltfm.SYS_GetPortReturnDaily(NAV_struct, TradeFlag, cost);

    rtn_hs300 = pltfm.SYS_GetIndexDailyRtn(Mkt_tradedays, {'S12425'});
    rtn_zz500 = pltfm.SYS_GetIndexDailyRtn(Mkt_tradedays, {'S24125'});
    rtn_zz1000 = pltfm.SYS_GetIndexDailyRtn(Mkt_tradedays, {'S5096626'});

    rtn_daily = [rtn_daily rtn_hs300(:,2) rtn_zz500(:,2) rtn_zz1000(:,2)];
    rtn_daily = rtn_daily(nstart+1:length(rtn_daily), :);
    
    lastday_port=COM_GetDailyHolding(Holding_Daily, Mkt_tradedays(length(Mkt_tradedays)));
end