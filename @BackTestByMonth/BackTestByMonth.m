classdef BackTestByMonth < BackTestBaseHandle
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        
        function back_handle = BackTestByMonth(d)
            back_handle = back_handle@BackTestBaseHandle(d);
            if d < -1 || d > 1
                fprintf('Month Parameter Error!\n');
            end
        end
        
        function DispInfo(bk)
            switch bk.day
                case -1
                    fprintf('Back Testing Every Last Day Of Month\n');
                case 0
                    fprintf('Back Testing Every Middle Day Of Month\n');
                case 1
                    fprintf('Back Testing Every First Day Of Month\n');
            end
            
        end
        
    end
    
end

