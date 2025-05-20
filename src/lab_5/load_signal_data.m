function data = load_signal_data(filename)
    % Open the file
    fid = fopen(filename, 'r');
    
    % Skip the first 7 lines (header)
    for i = 1:7
        fgetl(fid);
    end
    
    % Read the remaining data
    dataArray = textscan(fid, '%f %f', 'Delimiter', ' ', 'MultipleDelimsAsOne', true);
    
    % Close the file
    fclose(fid);
    
    % Store the data in a structure
    data.time = dataArray{1};
    data.signal = dataArray{2};
end
