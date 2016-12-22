function [distToNeighborTable,stateNodes,distToDestinationTable]=createNetworkOfNodes(requiredNodes,destinationPoint)
    %calculate distance of all available points from current point and filter
    %if the distance is <=3 units
    %draw lines from requiredNodes to destinationPoint if distance between
    %points is less than 3 units
    for i=1:size(requiredNodes,2)
        for j=1:size(requiredNodes,2)
            distToNeighbor=pdist([requiredNodes(1,i) requiredNodes(2,i); requiredNodes(1,j) requiredNodes(2,j)]); %calculate distance form current node to neighbour
            if(distToNeighbor<=3 ) %check if distance to the node is less than 3 units
                distToNeighborTable(:,i,j)=distToNeighbor; %store distance from current node to valid node into this matrix
                line([requiredNodes(1,i) requiredNodes(1,j)],[requiredNodes(2,i) requiredNodes(2,j)]); %plots line from current node to valid node.
                stateNodes(:,i,j)=requiredNodes(:,j); %add valid nodes as neighbor to current node
                pause(0.0001);
            end

            %record distance from current node to destination node into a matrix    
            distToDestination=pdist([requiredNodes(1,i) requiredNodes(2,i); destinationPoint(1) destinationPoint(2)]); %calculate distance form each node to destination node
            distToDestinationTable(:,i)=distToDestination; %store distance from every node to the goal into this matrix
        end
    end
end