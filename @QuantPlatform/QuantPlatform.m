classdef QuantPlatform < handle
    properties
        ch_stk_data
        ch_idx_data
        last_update_date
        back_test_handle
        get_data_ready
    end
    
    methods
        function QP = QuantPlatform()
            QP.get_data_ready = false;
        end
        %在数据不是最新的时候更新到最新的数据
        UpdateData(pltfm, date);
        
        %每日初始更新平台数据，filePath是mat数据所在文件夹
        InitializePlatform(pltfm, filePath, today);
        
        %确认数据是否准备好
        res = GetDataReady(pltfm, date);
        
        [DPosWeight,rtnArr] = SYS_Pos2DPosWeight(pltfm, Mkt_tradedays, Pos,ret,TradeFlag, stockcostfee);
        
        %回测函数
        %函数SYS_GetPortReturnDaily，计算组合每日净值，并返回
        [rtn_Daily,Holding_Daily] = SYS_GetPortReturnDaily(pltfm, NAV_struct, TradeFlag, stockcostfee);
        
        %函数SYS_GetIndexDailyRtn，计算组合每日收益，并返回
        index_rtn = SYS_GetIndexDailyRtn(pltfm, Mkt_tradedays, IDXcellTicker);
        
        %函数SYS_GetDailyHolding，计算组合每日持仓，并返回
        dayHolding = SYS_GetDailyHolding(pltfm, Holding_struct, int_dt);
        
        %函数SYS_GetOutputData，通过策略运行结果计算每日持仓和每日收益，并返回
        [holdings, profits] = SYS_GetOutputData(pltfm, NAV_struct, TradeFlag, cost, Mkt_tradedays, nstart);
        
        %函数SYS_GetProfit，通过持仓组合和起止时间，计算收益率，并返回
        profits = SYS_GetProfit(pltfm, hold, start_date, end_date);
        
        %回测函数SYS_BackTest
        profits = SYS_BackTest(pltfm, back_handle, model, begin_date, end_date);
        
        %函数SYS_ModelDataMapToMat，将Model的计算输出映射到包含所有股票的矩阵中
        pos = SYS_ModelDataMapToMat(pltfm, model_output, tickers);
    end

end