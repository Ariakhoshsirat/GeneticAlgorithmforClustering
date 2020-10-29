function [ newMember ] = MutateMerg( oldMember  )

%% Mutation by cluster merging
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
%{
[valuemax,indexmax]=max(cntCluster);
cntCluster = abs(cntCluster -(valuemax+1));
[valuemax,indexmax]=max(cntCluster);

%}

[valuemin1,indexmin1]=min(cntCluster);
index1 = indexmin1;
cntCluster(indexmin1) = inf;
[valuemin2,indexmin2]=min(cntCluster);
index2 = indexmin2;
%select one cluster randon to spliting
%{
while true
    n1 = randi(valuemax);
    counter = 0 ;
    index1 = 0 ;
    while counter<n1
        index1 = index1+1;
        counter = counter + cntCluster(index1);
    end
    % % % 
    % % % n2 = randi(size(oldMember.group,2));
    % % % 
    % % % while n1==n2
    % % %     n2 = randi(size(oldMember.group,2));
    % % % end
    n2 = randi(valuemax);
    counter = 0 ;
    index2 = 0 ;
    while counter<n2
        index2 = index2+1;
        if index2 > nofcluster
            break
        end
        counter = counter + cntCluster(index2);
    end

    if index1 ~= index2
        break;
    end

end%end of while true
%}
if index1 > index2
    temp = index2;
    index2 = index1;
    index1 = temp;
end

%merge member of selected clusters to one cluster :

oldMember.clusters(oldMember.clusters==index2) = index1;

oldMember.groups(index2) = [];

for i = 1:size(oldMember.groups,2)
    for j = 1:size(oldMember.clusters,2)
        if oldMember.clusters(j) == oldMember.groups(i)
            oldMember.clusters(j) = i;
        end
        
    end

end

%oldMember.clusters(oldMember.clusters==nofcluster) = index2;

oldMember.groups = unique(oldMember.clusters) ;
newMember = oldMember ;

end

