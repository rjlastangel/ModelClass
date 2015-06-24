function res = GetDataReady(pltfm, date)
    if pltfm.get_data_ready && date <= pltfm.last_update_date
        res = true;
    else
        res = false;
    end
end