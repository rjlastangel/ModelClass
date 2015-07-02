function res = UploadNewModel(user, varargin)
    tcp = user.connect_handle;
    %发送功能参数21：上传新模型
    fopen(tcp);
    status = uint32(21);
    fwrite(tcp. status, 'uint32');
    while tcp.BytesAvailable ~= user.bytes                  
        pause(0.1);
    end
    user.bytes = user.bytes + 2;
    disp('功能状态传输成功!');
    fclose(tcp);
    
    %发送模型文件夹下所有文件    
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
            disp('文件名传输成功！');
            fwrite(tcp, length(data), 'uint32');
            while tcp.BytesAvailable ~= user.bytes
                pause(0.1);
            end
            user.bytes = user.bytes + 2;
            disp('文件大小传送成功！');
            fwrite(tcp, data, 'uint8');
            while tcp.BytesAvailable ~= user.bytes
                pause(0.1);
            end
            user.bytes = user.bytes + 2;
            disp('文件传送成功');
            fclose(tcp);
            res = true;
        end        
    end
    
end