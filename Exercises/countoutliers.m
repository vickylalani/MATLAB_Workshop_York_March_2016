function nOutliers = countoutliers(v)

nOutliers = sum(abs(v - nanmean(v)) > 2*nanstd(v));

end