
clear;
load('Wine.data');
data = Wine(:,2:14);
labels = Wine(:,1);


IDX = kmeans(data,3);


[~,RI] = RandIndex(IDX,labels);
RI