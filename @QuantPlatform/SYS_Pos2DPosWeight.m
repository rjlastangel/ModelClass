function [DPosWeight,rtnArr] = SYS_Pos2DPosWeight(pltfm, Mkt_tradedays, Pos,ret,TradeFlag, stockcostfee)

DPosWeight=zeros(size(Pos));
rtnArr=zeros(size(Pos,1),4);

nstart = 0;
for i=1:size(Pos,1)
    if sum(Pos(i, :))>0.0001 && nstart<=0
       DPosWeight(i, :) = Pos(i,:);
       rtnArr(i, 1) = 0-stockcostfee*sum(Pos(i, :));
       rtnArr(i, 2) = sum(Pos(i, :));
       rtnArr(i, 3) = stockcostfee*sum(Pos(i, :));
       rtnArr(i, 4) = 0;
       nstart=i;
    else
        if nstart> 0 
            DPosWeight(i,:)=DPosWeight(i-1,:).*(1+vif(isnan(ret(i,:)),0,ret(i,:)));
            rtnArr(i, 1)= sum(DPosWeight(i,:))-1;
            rtnArr(i, 2) = 0;
            rtnArr(i, 3) = 0;
            rtnArr(i, 4) = sum(DPosWeight(i,:))-1; 
%             NAV(i, 5) = Mkt_tradedays(i);
            
            if TradeFlag(i)==1
            %ÐÂ²ÖÎ»£­¾É²ÖÎ»
                tmp = Pos(i, :) - DPosWeight(i, :)/sum(DPosWeight(i,:));
                turnover = sum(abs(tmp));
                rtnArr(i, 2) = turnover;
                rtnArr(i, 3) = turnover * stockcostfee;
                rtnArr(i, 1) = (rtnArr(i,1)+1)*(1-turnover * stockcostfee)-1;
                if all(Pos(i,:)==0)
                    DPosWeight(i,:)=0;  
                else
                    DPosWeight(i,:)= Pos(i,:)./sum(Pos(i,:));
                end
            end
            DPosWeight(i, :) = DPosWeight(i, :)./sum(DPosWeight(i, :));
        else
            if i>1 
                rtnArr(i, :) = rtnArr(i-1, :);
%                 NAV(i, 5) = Mkt_tradedays(i);
            else
                rtnArr(i, 1) = 0;
                rtnArr(i, 2) = 0;
                rtnArr(i, 3) = 0;
                rtnArr(i, 4) = 0;
%                 NAV(i, 5) = Mkt_tradedays(i);
            end
        end
    end
end

rtnArr = [num2cell(Mkt_tradedays) num2cell(rtnArr)];

end