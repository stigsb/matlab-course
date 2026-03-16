function filtered = filter_data(data, threshold)
    % FILTER_DATA  Return elements of data above threshold
    %   filtered = FILTER_DATA(data, threshold) returns data(data > threshold)
    filtered = data(data > threshold);
end
