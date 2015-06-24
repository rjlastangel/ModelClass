classdef BaseModel < handle
    properties
        %ģ��Ĭ�ϳ�ʼ�������ڣ���configure�ļ���ȡ
        model_default_startdate
        
        %ģ��Ĭ�Ϲ�Ʊ�أ���configure�ļ���ȡ
        model_default_universe
        
        %ģ��Ĭ�Ͻ��׳��ģ���configure�ļ���ȡ        
        model_default_cost%���׳ɱ�
        
        %ģ��ָ����Ʊ��
        sys_universe;
        %ʹ�ù�Ʊ��flag
        use_default_universe;
        
        %ģ��ָ�����׳ɱ�
        sys_cost;
        %ʹ�ý��׳ɱ�flag
        use_default_cost;
    end
   
    methods
            function BM=BaseModel(md_starttime, md_universe, md_cost)
                disp('run in BaseModel constructor');
                disp(num2str(nargin));
                BM.model_default_startdate = md_starttime;
                BM.model_default_universe = md_universe;
                BM.model_default_cost = md_cost;
                BM.sys_universe = '';
                BM.sys_cost = -1;
                BM.use_default_universe = true;
                BM.use_default_cost = true;
            end
            
            function SetSystemUniverse(BM, sys_universe)
                BM.sys_universe = sys_universe;
                BM.use_default_universe = false;                
            end
            
            function SetSystemCost(BM, sys_cost)
                BM.sys_cost = sys_cost;
                BM.use_default_cost = false;              
            end
                
            function ResetSystemUniverse(BM)
                BM.sys_universe = '';
                BM.use_default_universe = true;    
            end
            
            function ResetSystemCost(BM)
                BM.sys_cost = -1;
                BM.use_default_cost = true;     
            end
            
            function universe = GetUniverse(BM)
                if BM.use_default_universe
                    universe = BM.model_default_universe;
                else
                    universe = BM.sys_universe;
                end
            end
            
            function cost = GetCost(BM)
                if BM.use_default_cost
                    cost = BM.model_default_cost;
                else
                    cost = BM.sys_cost;
                end
            end
                 
                
            
            function [out1 out2]=ModelPort(BM, date)
                disp('run in basemodel modelport');
            end
    end
end