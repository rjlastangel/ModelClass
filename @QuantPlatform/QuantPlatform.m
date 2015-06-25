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