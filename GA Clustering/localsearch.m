function [ finalind , finalfitness ] = localsearch( data, ind ,labels, type )
%LOCALSEARCH Summary of this function goes here
%   Detailed explanation goes here


    minfitness = Fitness(data,ind.clusters',labels,type);
    
    for i = 1 : size(ind.clusters,2)
        
        currentind = ind.clusters;
        for j = 1 : size(ind.groups,2)
            
            if ind.groups(j) ~= currentind(i)
                currentind(i) = ind.groups(j);
                tempfit = Fitness(data,currentind',labels,type);

                if tempfit < minfitness %  change this for type 2
                    ind.clusters = currentind;
                    minfitness = tempfit;
                end
            
            end
              
        end  

    end
    finalind = ind;
    finalind.groups = 1:size(unique(ind.clusters),2);
    finalfitness = minfitness;

end

