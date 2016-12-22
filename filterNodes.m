%filter coordinates that touch or stay inside obstacle rectangle
function [requiredNodes,remainingNodes]=filterNodes(randNodes)
    requiredNodes=[;];  %empty matrix to collect points out of rectangle
    remainingNodes=[;]; %empty matrix to collect points inside rectangles
    for i=1:size(randNodes,2)
    
    if(((randNodes(1,i)>=2) && (randNodes(1,i)<=5) && (randNodes(2,i)>=2) && (randNodes(2,i)<=6)) || ((randNodes(1,i)>=9) && (randNodes(1,i)<=12) && (randNodes(2,i)>=3) && (randNodes(2,i)<=11)) || ((randNodes(1,i)>=10) && (randNodes(1,i)<=16) && (randNodes(2,i)>=15) && (randNodes(2,i)<=17)))
        requiredNodes=[requiredNodes,[]];
        remainingNodes=[remainingNodes,randNodes(:,i)];
    else
        requiredNodes=[requiredNodes,randNodes(:,i)];
        remainingNodes=[remainingNodes,[]];
    end
    end

end