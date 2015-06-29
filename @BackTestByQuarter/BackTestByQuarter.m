classdef BackTestByQuarter < BackTestBaseHandle
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        
        function back_handle = BackTestByQuarter(d)
            back_handle = back_handle@BackTestBaseHandle(d);
            if d < -1 || d > 1
                fprintf('Quarter Parameter Error!\n');
            end
        end
        
        function DispInfo(bk)
            switch bk.day
                case -1
                    fprintf('Back Testing Every Last Day Of Quarter\n');
                case 0
                    fprintf('Back Testing Every Middle Day Of Quarter\n');
                case 1
                    fprintf('Back Testing Every First Day Of Quarter\n');
            end
        end
    end
    
end

