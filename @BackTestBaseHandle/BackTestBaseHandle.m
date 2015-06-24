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
        daily_return = BackTest(back_handle, model, pltfm, begin_date, end_date);
    end
    
end

