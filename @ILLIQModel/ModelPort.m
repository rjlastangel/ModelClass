function [out_1, out_2]=ModelPort(md, pltfm, date)
  %  disp('run in ILLIQModel ModelPort');
    if pltfm.GetDataReady(date) == false
        disp('Platform Data is NOT Ready!Please Initialize Platform or Update Data!\n');
    else
        stockData = pltfm.ch_stk_data;

        Tickers = stockData.TickersCell;
        stock = stockData.Tickers;
        Mkt_tradedays = stockData.Mkt_tradedays;
        isST = stockData.status;
        STK_close = stockData.close;
        ret = stockData.Return;
        yuan_vol = stockData.yuan_volume;
        istradeday = stockData.istradeday;
        totaltradedays = stockData.totaltradedays;
        nd = find(Mkt_tradedays <= date);
        nd = nd(end);

        %策略核心
        Pos=zeros(1, length(stock));
         %日数据计算
        illiqpre = abs(ret*100000000 ./yuan_vol);
        %日期参数
        nday = 10;



        index = nd;
        illiq0 = illiqpre((index-nday+0) : (index-1), :);
        illiq = nanmean(illiq0);

        %添加一个月反转因子
        tmpret = prod(ret((index-nday*2+0) : (index-1), :) + 1, 1);
        [temp,i2]=sort(illiq,'descend');                %因子排序        

        temp(i2) = 1:length(temp);
        fa = temp;              %只用illiq因子    

        idx=find((yuan_vol(index,:)>1) & (STK_close(index,:)./STK_close(index-1,:)-1<.095) & (istradeday(index,:)>0) & ((isST(index,:)<1|isnan(isST(index,:)))) ...
            & (sum(istradeday(index-10:index-1,:)>0,1)==10) & (totaltradedays(index, :) >250));      
        [temp,idy]=sort(fa,'ascend');               %排序 fa为因子得分  
 
        ix=ismember(idy,idx);   %停牌股票 涨跌停 ST股票筛选
        idy=idy(ix);
        index_y = idy;
        %前100股票筛选
        if length(idy)>100            
            idy=idy(1:100);
        end
        %long
        if any(idy)            
            Pos(idy)=1/length(idy);                       
        end

        %输出数据拼接
        out_1 = cell(length(idy), 3);
        out_1( :, 1) = {(date)};
        out_1( :, 2) = Tickers(idy);
        out_1( :, 3) = num2cell(Pos(idy));

        out_2.table_1 = {'date', 'stock_code', 'factor_1'};
        out_2.table_2 = cell(length(index_y), 3);
        out_2.table_2( :, 1) = {(date)};
        out_2.table_2( :, 2) = Tickers(index_y);
        out_2.table_2( :, 3) = num2cell(illiq(index_y));
    end
end