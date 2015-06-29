classdef BackTestByDay < BackTestBaseHandle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        
        function back_handle = BackTestByDay(d)
            back_handle = back_handle@BackTestBaseHandle(d);
        end
        
        function DispInfo(bk)
            fprintf('Back Testing By %d Day\n', bk.day);
        end
        
    end
    
end

