function res = ConfigureServer(user, ip, port, buffer_size)
    user.connect_handle = tcpip(ip, port, 'networkrole', 'server');
    user.bytes = 2;
    if strcmp(user.connect_handle.type, 'tcpip') == 1
        res = true;
        set(user.connect_handle, 'OutputBufferSize', buffer_size);
    else
        res = false;
    end
    
end