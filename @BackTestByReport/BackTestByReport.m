classdef BackTestByReport < BackTestBaseHandle
    %UNTITLED7 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        
        function back_handle = BackTestByReport(d)
            %d=1������ÿ���4.1��11.1���֣�d=2����ÿ���4.1��9.1��11.1����
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

