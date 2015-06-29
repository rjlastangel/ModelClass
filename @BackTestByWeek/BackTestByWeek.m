classdef BackTestByWeek < BackTestBaseHandle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        
        function back_handle = BackTestByWeek(d)
            back_handle = back_handle@BackTestBaseHandle(d);
            if d < 1 || d > 7 
                fprintf('Week Parameter Error!\n');
            end
        end
        
        function DispInfo(bk)
            fprintf('Back Testing Every %s\n', bk.Int2Week(bk.day));
        end
        
        function str = Int2Week(bk, n)
            switch n
                case 1
                    str = 'Monday';
                case 2
                    str = 'Tuesday';
                case 3
                    str = 'Wednesday';
                case 4
                    str = 'Thursday';
                case 5
                    str = 'Friday';
                case 6
                    str = 'Saturday';
                case 7
                    str = 'Sunday';
                otherwise
                    str = 'Error Parameter';
            end
        end
        
    end
    
end

