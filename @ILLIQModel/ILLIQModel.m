classdef ILLIQModel < BaseModel
    properties
    end
    
    methods
        function illiqModel = ILLIQModel()
             disp('run in ILLIQModel constructor');
%             illiqModel.model_starttime = md_starttime;
%             illiqModel.model_universe = md_universe;
%             illiqModel.model_cost = md_cost;
            illiqModel = illiqModel@BaseModel(20080101, 'HS300', 0.0015);
        end
        
        [out_1, out_2] = ModelPort(obj, pltfm, date)
    end
end