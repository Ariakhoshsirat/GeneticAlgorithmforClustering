function [ Value ] = Fitness( data, labels, truelabels , type )
%FITNESS Summary of this function goes here
%   Detailed explanation goes here
    global eva2;
    if type == 1
        eva = evalclusters(data,labels,'DaviesBouldin');
        Value = eva.CriterionValues * nthroot(length(unique(labels)),4); %abs(eva.CriterionValues-eva2.CriterionValues);
    elseif type == 2
        %{
        eva = evalclusters(data,labels,'Silhouette');
        Value = -eva.CriterionValues ;
        %}
        s = silhouette(data,labels);
        Value = -mean(s) ;
    elseif type == 3 
        [~,RI] = RandIndex(labels,truelabels);
         Value = 1/RI;
    end
end

