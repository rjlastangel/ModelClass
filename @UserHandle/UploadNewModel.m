function res = UploadNewModel(user, varargin)
    tcp = user.connect_handle;
    %���͹��ܲ���21���ϴ���ģ��
    fopen(tcp);
    status = uint32(21);
    fwrite(tcp. status, 'uint32');
    while tcp.BytesAvailable ~= user.bytes                  
        pause(0.1);
    end
    user.bytes = user.bytes + 2;
    disp('����״̬����ɹ�!');
    fclose(tcp);
    
    %����ģ���ļ����������ļ�    
    path = uigetdir;
    files = dir(path);
    for index = 1 : length(files)
        file_name = strcat(path, files(index));
        fid = fopen(file_name);
        if fid < 0
            disp(errmsg);
            res = false;
            break;
        else
            data = fread(fid);
            fclose(fid);        
            fopen(tcp);
            fwrite(tcp, abs(file), 'uint32');
            while tcp.BytesAvailable ~= user.bytes
                pause(0.1);
            end
            user.bytes = user.bytes + 2;
            disp('�ļ�������ɹ���');
            fwrite(tcp, length(data), 'uint32');
            while tcp.BytesAvailable ~= user.bytes
                pause(0.1);
            end
            user.bytes = user.bytes + 2;
            disp('�ļ���С���ͳɹ���');
            fwrite(tcp, data, 'uint8');
            while tcp.BytesAvailable ~= user.bytes
                pause(0.1);
            end
            user.bytes = user.bytes + 2;
            disp('�ļ����ͳɹ�');
            fclose(tcp);
            res = true;
        end        
    end
    
end