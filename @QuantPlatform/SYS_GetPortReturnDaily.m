function [rtn_Daily,Holding_Daily]=SYS_GetPortReturnDaily(pltfm, NAV_struct, TradeFlag, stockcostfee)

Mkt_tradedays = NAV_struct.row;
cellTickers = NAV_struct.column;
Pos = NAV_struct.matrix;



fields={'Mkt_tradedays','Return','TickersCell'};
Startdate=min(Mkt_tradedays);
Enddate=max(Mkt_tradedays);
%CHSTK  = loadmatdata( fullfile(DataPath,'CHSTK.mat'),cellTickers,Startdate,Enddate,fields );

%ret=CHSTK.Return;
ret = pltfm.ch_stk_data.Return;
%tickers = CHSTK.TickersCell;
tickers = pltfm.ch_stk_data.TickersCell;
%clear CHSTK;

%calc DPosWeight NAV
[Holding_Daily,rtn_Daily] = pltfm.SYS_Pos2DPosWeight(Mkt_tradedays, Pos,ret,TradeFlag, stockcostfee);

Holding_Daily = struct('row',{Mkt_tradedays}, 'column', {cellTickers}, 'matrix', {Holding_Daily});
end