classdef BackTestBaseHandle < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        day
    end
    
    methods
        function back_handle = BackTestBaseHandle(d)
            back_handle.day = d;
        end
        
        [holding_daily, rtn_daily] = PerformBackTest(back_handle, model, pltfm, begin_date, end_date);

        
        
        DispInfo(bk);
        
        [holding_daily, rtn_daily] = BackTest(back_handle, model, pltfm, begin_date, end_date);

        
    end
    
end

