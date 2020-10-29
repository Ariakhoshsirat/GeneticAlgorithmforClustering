

clear;

mu1 = [0 2];
sigma1 = [1 0 ; 0 0.8^2];
%traindata1 =  [mvnrnd(mu1,sigma1,50) ones(50,1)];
data1 = mvnrnd(mu1,sigma1,100);
clear mu1 ;

mu2 = [-1 -1];
sigma2 = [0.6^2 0 ; 0 0.4^2];
%sigma2 = [2 0 ; 0 2];
%traindata2 =  [mvnrnd(mu2,sigma2,50) ones(50,1)*2];
data2 = mvnrnd(mu2,sigma2,100);
clear mu2;

mu3 = [2 -1];
sigma3 = [0.3^2 0 ; 0 0.5^2];
%sigma3 = [2 0 ; 0 2];
%traindata1 =  [mvnrnd(mu1,sigma1,50) ones(50,1)];
data3 = mvnrnd(mu3,sigma3,100);
clear mu3;
%{
mu4 = [3 -1];
data4 = mvnrnd(mu4,sigma,40);
clear mu4;

mu5 = [-1 1];
data5 = mvnrnd(mu5,sigma,40);
clear mu5;

mu6 = [2 -2];
data6 = mvnrnd(mu6,sigma,40);
clear mu6;

mu7 = [1 2];
data7 = mvnrnd(mu7,sigma,40);
clear mu7;

mu8 = [3 1];
data8 = mvnrnd(mu8,sigma,40);
clear mu8;
%}
data = [data1;data2;data3];%;data4;data5;data6;data7;data8];
clear data1 data2 data3 ; %data4 data5 data6 data7 data8 sigma;


labels1 = ones(100,1);
labels2 = ones(100,1)*2;
labels3 = ones(100,1)*3;
labels4 = ones(40,1)*4;
labels5 = ones(40,1)*5;
labels6 = ones(40,1)*6;
labels7 = ones(40,1)*7;
labels8 = ones(40,1)*8;

labels = [labels1 ; labels2 ; labels3];% ;labels4 ; labels5 ; labels6; labels7 ; labels8];
clear labels1 labels2 labels3 labels4 labels5 labels6 labels7 labels8;
%}
%{
load('iris2.data');
data = iris2(:,1:4);
labels = iris2(:,5);

global eva2;
%}
eva2 = evalclusters(data,labels,'Silhouette');

%Fitness(data,labels,'DaviesBouldin');



% ------------------- initialization ---------------
k = 3;
N = size(data,1);
type = 3;
popsize = 100;

%y = randsample(1:k,5,true);

for i = 1 : popsize
    population(i).clusters = randsample(1:k,N,true);
    population(i).groups = unique(population(i).clusters);
end

%----------------- Fitness of Population -------------
fitnessofpop = zeros(1,popsize);

for i = 1 : popsize
    fitnessofpop(i) = Fitness(data,population(i).clusters',labels , type );
    
end


[sortedfitness,indices] = sort(fitnessofpop);
sortedpop = population(indices);


iterationnum = 50;
Pxinitial = 1;
Pxfinal = 0.1;
Pminitial = 0.1;
Pmfinal = 0.9;

for iter = 1 : iterationnum
    
    
    
    Pmutation = Pminitial - (( iter/iterationnum ) *(Pminitial - Pmfinal));
    Pxover = Pxinitial - (( iter/iterationnum ) *(Pxinitial - Pxfinal));
    
    
    fitnessofchildren = zeros(1,popsize-1);
    
    for childnum = 1 : popsize-1
        
        %------------Ranks-------------
        ranks = zeros(popsize,1);
        for i = 1 : popsize
            ranks(i) = (2*i)/(popsize*(popsize+1));
        end
        ranks = flipud(ranks);
        %---------Roulette Wheel------
        R = randp(ranks,1,2);

        %------------Cross Over--------
        
        
        randnum1 = rand;
        randnum2 = rand;
        randnum3 = rand;
        
        if randnum1 < Pxover 
            child = Crossover(sortedpop(R(1)),sortedpop(R(2)));
         %   childfitness = Fitness(data,child.clusters',labels,type);
        end
        if randnum2 < Pmutation
            if size(child.groups,2) < k 
               child = MutateSplit(child);
            end
        end
        if randnum3 < Pmutation
            if size(child.groups,2) > k 
               child = MutateMerg(child);
            end
        end
            
        childfitness = Fitness(data,child.clusters',labels,type);
            %{
            sortedpop = [sortedpop  child];
            sortedfitness = [sortedfitness  childfitness];

            [sortedfitness,indices] = sort(sortedfitness);
            sortedpop = sortedpop(indices);

            sortedfitness = sortedfitness(1:popsize);
            sortedpop = sortedpop(1:popsize);
            %}
        
        children(childnum) = child;
        fitnessofchildren(childnum) = childfitness;
    end
        

    
    randnum2 = rand;
    randnum3 = rand;
    
    if randnum2 < Pmutation
        if size(sortedpop(1).groups,2) < k 
            sortedpop(1) = MutateSplit(sortedpop(1));
        end
    end
    if randnum3 < Pmutation
        if size(sortedpop(1).groups,2) > k 
            sortedpop(1) = MutateMerg(sortedpop(1));
        end
    end
    sortedfitness(1) = Fitness(data,sortedpop(1).clusters',labels,type);
    
    
    %------------selection------------
    sortedpop = [sortedpop(1) children];
    sortedfitness = [sortedfitness(1)  fitnessofchildren];
    [sortedfitness,indices] = sort(sortedfitness);
    sortedpop = sortedpop(indices);
    
    
    
    bestfitness = sortedfitness(1)
    [~,RI] = RandIndex(sortedpop(1).clusters',labels);
    RI
    %------------ Local Search ------------
    randnum4 = rand;
    
    if randnum4 < Pxover/7
        for p = 1 : popsize/10
            individual = sortedpop(p);
            [individual , newfitness] = localsearch(data,individual,labels,type);
            sortedpop(p) = individual;
            sortedfitness(p) =  newfitness;
        end
    end
    bestfitness = sortedfitness(1)
    [~,RI] = RandIndex(sortedpop(1).clusters',labels);
    RI
    
    if(RI == 1)
        break;
    end
    iter
    
end
fig = figure;
scatter(data(:,1),data(:,2),[],sortedpop(1).clusters);


title('Syntetic Data #2');

%}
