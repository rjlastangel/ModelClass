function profits = SYS_BackTest(pltfm, back_handle, model, begin_date, end_date);
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    profits = back_handle.BackTest(model, pltfm, begin_date, end_date);

end

