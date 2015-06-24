function merge_arr = SYS_MergeArrays(pltfm, dstarr, array2merge)
    if length(dstarr) > length(array2merge) || length(dstarr) < length(array2merge)
        merge_arr = 0;
    else
        merge_arr = [dstarr mat2cell(array2merge, ones(1, length(array2merge)), 1)];
    end
end