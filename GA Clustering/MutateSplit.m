function [ newMember ] = MutateSplit( oldMember  )

%% Mutation by cluster spliting

nofcluster = size(oldMember.groups,2);

% compute size of each cluster
cntCluster = zeros(1,nofcluster);

for i=1:nofcluster
    for j=1:size(oldMember.clusters,2)
        if oldMember.clusters(j) == i
            cntCluster(i) = cntCluster(i) + 1 ;
        end
    end
end
%fing bigger cluster

[valuemax,indexmax]=max(cntCluster);
index = indexmax;
%select one cluster randon to spliting
%{
n = randi(size(oldMember.clusters,2));
counter = 0 ;
index = 0 ;
%disp(n);
while counter<n
    index = index+1;
    counter = counter + cntCluster(index);
end

%}
%split member of selected cluster to new cluster :

counter1 = 1;
for j=1:size(oldMember.clusters,2)
    if oldMember.clusters(j) == index
        R = rand;
        
        if counter1 < valuemax/2 
            if R > 0.001
              oldMember.clusters(j) = nofcluster + 1;
              counter1 = counter1 + 1;
            end
        end
    end
end




oldMember.groups(end+1)= nofcluster + 1 ;
newMember = oldMember ;
end
