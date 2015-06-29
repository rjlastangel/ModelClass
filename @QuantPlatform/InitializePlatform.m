function InitializePlatform(pltfm, filePath, today)
    pltfm.ch_stk_data = load(fullfile(filePath, 'CHSTK_A.mat'), 'open', 'close', 'status', 'istradeday', 'Tickers', 'TickersCell', 'Mkt_tradedays', 'Return', 'yuan_volume', ...
        'totaltradedays');
    pltfm.ch_idx_data = load(fullfile(filePath, 'CHIDX.mat'), 'Mkt_tradedays', 'open', 'close', 'istradeday', 'TickersCell');
    pltfm.last_update_date = today;
    pltfm.is_data_ready = true;
end