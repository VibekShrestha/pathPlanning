function [myPath]=findOptimumPath04(stateNodes,distToNeighborTable,distToDestinationTable)

% while destination point is not reached

    %get start point from supplied matrix which is the first coordinate of
    %the stateNodes matrix here. pathNode=startPoint because we start
    %searching path from the given start point
        startPoint=stateNodes(:,1);pathNode=startPoint;

        %     b=100; %arbitrary high value for distance from start to destination point
    
    %closedNodes hold coordinates that are already reached, while openNodes
    %hold coordinates that are unexplored
        closedNodes=[;]; openNodes=[;];
    
    
    catchNode=1;catchClosestNode=1;
    goalPosition=size(stateNodes,2); %position of destination coordinate
    
    nodeStep=2;    %to find number of nodes in append node matrix
    deadNode=false;  %to find if reached is stuck
    movePossible=true;  %to find if reached node has no children node
    
    accumulativeDist=[;];accumulativeDist(1,1,1)=0;
    costMatrix=[;];   costMatrix(1,1,1)=distToDestinationTable(1,1);  tempMatrix=startPoint;
    
    while (catchNode<goalPosition && movePossible==true)    %loop until goal is reached and moves are still possible
        nodeCount=1;% to keep track of possible children nodes
        for i=1:size(distToNeighborTable,2) %scan all possible nodes from pages of matrix
            repeat=false;%if here indicate node is not repeated
            
            distToChildren=(distToNeighborTable(1,catchNode,i));   %get dist to children node
            if(distToChildren>0)    %get into finding node only if the children node is valid (i.e has dist greated than 0).

                %   check if a node is repeated             
                [dummy,repeat]=checkIfNodeIsRepeated(stateNodes,catchNode,tempMatrix,i);
                
                % only if node is not repeated
                if(repeat==false)
                    tempMatrix(:,nodeCount,nodeStep)=dummy;
                    accumulativeDist(1,nodeCount,nodeStep)=accumulativeDist(:,1,nodeStep-1)+distToChildren;    
                    
                    totalDist=distToChildren+distToDestinationTable(1,i);
                    costMatrix(1,nodeCount,nodeStep)=accumulativeDist(:,1,nodeStep-1)+totalDist;
                    
                    lastVal=size(costMatrix,2);
                    for j=1:(lastVal-1)
                        if (costMatrix(1,lastVal,nodeStep)==0)
                            lastVal=lastVal-1;
                        elseif(costMatrix(1,lastVal,nodeStep)<costMatrix(1,j,nodeStep))
%                         b=totalDist;
                        catchClosestNode=i;
                        tempMatrix(:,[lastVal,j],nodeStep)=tempMatrix(:,[j,lastVal],nodeStep);
                        costMatrix(:,[lastVal,j],nodeStep)=costMatrix(:,[j,lastVal],nodeStep);
                        end
                    end
                    nodeCount=nodeCount+1;
                end
                          
            end
        end
        
        % a node is selected by now.
        nodeCount=nodeCount-1;  %reduce number of nodes

        catchNode=catchClosestNode;
        
        if(nodeStep==size(tempMatrix,3))
            newNode=tempMatrix(:,1,nodeStep);
        end
        
        if(newNode(1,1)==pathNode(1,nodeStep-1) && newNode(2,1)==pathNode(2,nodeStep-1))
            deadNode=true;
            %check if reached a dead end
            if(nodeCount<=0 && nodeStep>2)
%                 movePossible=false;
                nodeStep=nodeStep-1;
                closedNodes=[closedNodes;newNode];
                stateNodes(:,:,catchNode)=[];   %collapse the page linked to the closed node
                stateNodes(:,catchNode,:)=[];   %collapse the column linked to the close node
                distToDestinationTable(:,catchNode)=[];
                distToNeighborTable(:,:,catchNode)=[];
                distToNeighborTable(:,catchNode,:)=[];
                
                tempMatrix(:,1,nodeStep)=0;
                tempMatrix=circshift(tempMatrix(:,1,nodeStep),[0 -1]);
%                 tempMatrix(:,1,nodeStep-1)=[];
            elseif(nodeCount<=0 && nodeStep<=1)
                movePossible=false;
                
                myPath=0; 
                return;
            end
        end
        
        pathNode=[pathNode,newNode];
        disp(pathNode);
        nodeStep=nodeStep+1;
        plot(newNode(1),newNode(2),'o','color','r');
    end
    myPath=1;

end


function [dummy,repeat]=checkIfNodeIsRepeated(stateNodes,catchNode,tempMatrix,i)

%     disp(1);
    dummy=stateNodes(:,catchNode,i);
    repeat=false;
                for k=1:size(tempMatrix,2)  %check colums of temporary matrix
                    for l=1:size(tempMatrix,3)  %check pages of temporary matrix
                        if(dummy(1)==tempMatrix(1,k,l))
                            if(dummy(2)==tempMatrix(2,k,l))
                                repeat=true;
                                break;
                            end
                        end 
                    end
                    if(repeat==true)
                        break;
                    end
                end
    
end