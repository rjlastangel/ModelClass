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
        %���캯��
        function user_handle = UserHandle()
        end
        
        %��������������
        res = ConfigureServer(user, ip, port, buffer_size);
        
        %�ϴ���ģ�ͣ�����������������ui���û�ѡ��model�ļ������߽�model�ļ��ľ���·�������������뺯��
        res = UploadNewModel(user, varargin);
    end
    
end

