clear;
worldFrame=[-2 22 -2 22];
% clf(1);
% clf(2);
randNodes= randi([0 20],2,450); %get randon nodes. We get a 2x50 matrix with random nodes between number 0 20

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

% plot rectangles with random points within circumference of rectangle removed
[requiredNodes,removedNodes]=filterNodes(randNodesNew);
figure(2);
drawObstacles();
hold on
plot(requiredNodes(1,:),requiredNodes(2,:),'*','color','blue')
plot(removedNodes(1,:),removedNodes(2,:),'*','color','r')
plotManage();   %set parameters for plot

plot(startPoint(1,1),startPoint(2,1),'o','color','g')
plot(destinationPoint(1,1),destinationPoint(2,1),'o','color','g')

% A* search to determine best path.
% straight line distance from current position to the goal.
% straight line distance form last position to current position.
% find cost so far to reach current position. g(n)
% find cost to reach goal from current position. h(n)
% estimated total cost of path through current position to the goal. f(n)
% f(n)=h(n)+g(n).

%draw lines from requiredNodes to destinationPoint if distance between
%points is less than 3 units
%calculate distance of all available points from current point and filter
%if the distance is <=3 units
for i=1:size(requiredNodes,2)
    for j=1:size(requiredNodes,2)
        distToNeighbor=pdist([requiredNodes(1,i) requiredNodes(2,i); requiredNodes(1,j) requiredNodes(2,j)]); %calculate distance form each node to neighbour node to find valid nodes
        if(distToNeighbor<=3 )
            distToNeighborTable(:,i,j)=distToNeighbor;
            line([requiredNodes(1,i) requiredNodes(1,j)],[requiredNodes(2,i) requiredNodes(2,j)]); %create mesh network
            stateNodes(:,i,j)=requiredNodes(:,j);
            pause(0.0001);
        end
        
        
        distToDestination=pdist([requiredNodes(1,i) requiredNodes(2,i); destinationPoint(1) destinationPoint(2)]); %calculate distance form each node to destination node to estimate distance
        distToDestinationTable(:,i)=distToDestination; %store distance from every node to the goal
    end
    
end

temp=stateNodes(:,1,:);



%find path
% [myPath]=findOptimumPath04(stateNodes,distToNeighborTable,distToDestinationTable);
% end


%  disp('a');

% clear all;      