
clear;
load('iris2.data');
data = iris2(:,1:4);
labels = iris2(:,5);


IDX = kmeans(data,3);


[~,RI] = RandIndex(IDX,labels);
RI