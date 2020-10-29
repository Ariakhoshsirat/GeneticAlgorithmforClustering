

load('iris2.data');
data = iris2(:,1:4);
labels = iris2(:,5);


epsilon=0.5;
MinPts=10;
IDX=DBSCAN(data,epsilon,MinPts);


[~,RI] = RandIndex(IDX+1,labels);
RI