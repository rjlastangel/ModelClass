function pos = SYS_ModelDataMapToMat(pltfm, model_output, tickers)
    [row column] = size(model_output);
    pos = zeros(length(tickers), 1);
    for index = 1:row
        ticker_index = strmatch(char(model_output(index, 2)), tickers);
        if length(ticker_index) == 0
            disp('Input Ticker Not Found!');
        else
            pos(ticker_index) = cell2mat(model_output(index, 3));
        end
    end
end