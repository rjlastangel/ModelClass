classdef QuantPlatform < handle
    properties
        ch_stk_data
        ch_idx_data
        last_update_date
        back_test_handle
        is_data_ready
        is_back_test_ready
    end
    
    methods
        function pltfm = QuantPlatform()
            pltfm.is_data_ready = false;
            pltfm.is_back_test_ready = false;
        end
        
        function InstallBackTest(pltfm, bk)
            pltfm.back_test_handle = bk;
            pltfm.is_back_test_ready = true;
        end
        
        function [holding_daily, rtn_daily] = BackTest(pltfm, model, beg_date, end_date)
            if pltfm.is_back_test_ready
                [holding_daily, rtn_daily] = pltfm.PerformBackTest(model, beg_date, end_date);
            else
                disp('ERROR!No Back Test Handle Exist!')
                holding_daily = 0;
                rtn_daily = 0;
            end
        end
        
        function [holding_daily, rtn_daily] = PerformBackTest(pltfm, model, beg_date, end_date)
            [holding_daily, rtn_daily] = pltfm.back_test_handle.BackTest(model, pltfm, beg_date, end_date);
        end
        %�����ݲ������µ�ʱ����µ����µ�����
        UpdateData(pltfm, date);
        
        %ÿ�ճ�ʼ����ƽ̨���ݣ�filePath��mat���������ļ���
        InitializePlatform(pltfm, filePath, today);
        
        %ȷ�������Ƿ�׼����
        res = GetDataReady(pltfm, date);
        
        [DPosWeight,rtnArr] = SYS_Pos2DPosWeight(pltfm, Mkt_tradedays, Pos,ret,TradeFlag, stockcostfee);
        
        %�ز⺯��
        %����SYS_GetPortReturnDaily���������ÿ�վ�ֵ��������
        [rtn_Daily,Holding_Daily] = SYS_GetPortReturnDaily(pltfm, NAV_struct, TradeFlag, stockcostfee);
        
        %����SYS_GetIndexDailyRtn���������ÿ�����棬������
        index_rtn = SYS_GetIndexDailyRtn(pltfm, Mkt_tradedays, IDXcellTicker);
        
        %����SYS_GetDailyHolding���������ÿ�ճֲ֣�������
        dayHolding = SYS_GetDailyHolding(pltfm, Holding_struct, int_dt);
        
        %����SYS_GetOutputData��ͨ���������н������ÿ�ճֲֺ�ÿ�����棬������
        [holdings, profits] = SYS_GetOutputData(pltfm, NAV_struct, TradeFlag, cost, Mkt_tradedays, nstart);
        
        %����SYS_GetProfit��ͨ���ֲ���Ϻ���ֹʱ�䣬���������ʣ�������
        profits = SYS_GetProfit(pltfm, hold, start_date, end_date);
        
        %�ز⺯��SYS_BackTest
        profits = SYS_BackTest(pltfm, back_handle, model, begin_date, end_date);
        
        %����SYS_ModelDataMapToMat����Model�ļ������ӳ�䵽�������й�Ʊ�ľ�����
        pos = SYS_ModelDataMapToMat(pltfm, model_output, tickers);
    end

end