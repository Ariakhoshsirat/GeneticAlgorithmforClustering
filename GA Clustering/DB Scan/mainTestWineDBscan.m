
clear;
load('Wine.data');
data = Wine(:,2:14);
labels = Wine(:,1);


epsilon=0.5;
MinPts=10;
IDX=DBSCAN(data,epsilon,MinPts);


[~,RI] = RandIndex(IDX+1,labels);
RI