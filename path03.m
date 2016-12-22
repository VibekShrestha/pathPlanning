clear;
worldFrame=[-2 22 -2 22];
% clf(1);
clf(2);
randNodes= randi([0 20],2,200); %get randon nodes. We get a 2x50 matrix with random nodes between number 0 20

% define start and destination point for path
startPoint=[0;1]; destinationPoint=[20;20];

%filter repeated coordinate values. erase duplicate nodes
randNodesNew=filterRepeatedNodes(randNodes,startPoint);

%add destination node at the end of random nodes
randNodesNew=[randNodesNew,destinationPoint];

% % plot rectangles with new random points in figure 1
% figure(1);
% drawObstacles();
% hold on;
% plot(randNodesNew(1,:),randNodesNew(2,:),'*') 
% plotManage();   %set parameters for plot

% plot rectangles (obstacles) and random points. Points inside rectangle
% are marked by red and added to removedNodes because it is not valid for
% path. path nodes is chosen only from nodes added to requiredNodes matrix
% indicated by blue color.
    [requiredNodes,removedNodes]=filterNodes(randNodesNew);
    figure(2);
    drawObstacles();
    hold on
    plot(requiredNodes(1,:),requiredNodes(2,:),'*','color','blue')
    plot(removedNodes(1,:),removedNodes(2,:),'*','color','r')
    plotManage();   %set parameters for plot
    
    %Plot start and destination point in different color
    plot(startPoint(1,1),startPoint(2,1),'o','color','g')
    plot(destinationPoint(1,1),destinationPoint(2,1),'o','color','g')


%call createNetworkOfNodes function to find valid state nodes, distance
%from nodes to the destination and nodes to the neghbor nodes
[distToNeighborTable,stateNodes,distToDestinationTable]=createNetworkOfNodes(requiredNodes,destinationPoint);

temp=stateNodes(:,1,:);



%find path
% [myPath]=findOptimumPath04(stateNodes,distToNeighborTable,distToDestinationTable);
% end


%  disp('a');

% clear all;      