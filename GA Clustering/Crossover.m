function [ Offspring ] = Crossover( parent1 , parent2 )
%CROSSOVER Summary of this function goes here
%   Detailed explanation goes here
    

    Offspring.clusters = zeros(size(parent1.clusters));
  %  Offspring.groups = zeros(size(parent1.groups));
  
    clusternum = 1;
    %------------------ Parent 1 -------------------
    CrossPoint1 = randi(size(parent1.groups,2));
    CrossPoint2 = randi(size(parent1.groups,2));
    if(CrossPoint2 < CrossPoint1)
        tmp = CrossPoint1;
        CrossPoint1 = CrossPoint2;
        CrossPoint2 = tmp;
    end
    
    for i = CrossPoint1:CrossPoint2
      % Indices = find();
        Offspring.clusters(parent1.clusters==i) = clusternum;
        clusternum = clusternum + 1;
        
    end
    %------------------ Parent 2 -------------------
    
    CrossPoint1 = randi(size(parent2.groups,2));
    CrossPoint2 = randi(size(parent2.groups,2));
    if(CrossPoint2 < CrossPoint1)
        tmp = CrossPoint1;
        CrossPoint1 = CrossPoint2;
        CrossPoint2 = tmp;
    end
    
    for i = CrossPoint1:CrossPoint2
      % Indices = find();
        Offspring.clusters(parent2.clusters==i & Offspring.clusters ==0) = clusternum;
        if ismember(clusternum,Offspring.clusters)
            clusternum = clusternum + 1;
        end
    end
    
    zeross = find(Offspring.clusters == 0);
    for i = zeross
        Offspring.clusters(i) = parent1.clusters(i);
    end
    Offspring.groups = 1:size(unique(Offspring.clusters),2);
    
    

end

