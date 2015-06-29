classdef BackTestByReport < BackTestBaseHandle
    %UNTITLED7 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        
        function back_handle = BackTestByReport(d)
            %d=1代表在每年度4.1和11.1换仓，d=2代表每年度4.1，9.1和11.1换仓
            back_handle = back_handle@BackTestBaseHandle(d);
            if d < 1 || d > 2
                fprintf('Report Parameter Error!\n');
            end
        end
        
        function DispInfo(bk)
            switch bk.day
                case 1
                    disp('Back Testing On First Day of April And November Every Year');
                case 2
                    disp('Back Testing On First Day of April, September And November Every Year');
            end
        end
        
    end
    
end

