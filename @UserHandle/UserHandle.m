classdef UserHandle < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        bytes;
        server_ip
        server_port
        connect_handle
    end
    
    methods
        %构造函数
        function user_handle = UserHandle()
        end
        
        %服务器连接配置
        res = ConfigureServer(user, ip, port, buffer_size);
        
        %上传新模型，如果不输入参数就用ui让用户选择model文件，或者将model文件的绝对路径当做参数传入函数
        res = UploadNewModel(user, varargin);
    end
    
end

