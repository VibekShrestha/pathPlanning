%filter matrix with repeated coordinates, and return matrix with unique
%coordinates
% This function accepts matrix of unfiltered nodes and creates new matrix
% starting from given start point.
function [filteredNodes]=filterRepeatedNodes(inputNodes,startPoint)
    filteredNodes=startPoint; %make startPoint first element of new matrix
    
    for i=1:size(inputNodes,2)
        check=true; %boolean variable to check repitition
    
        for j=1:size(filteredNodes,2)
            
            %wait for repition
            if(inputNodes(1,i)==filteredNodes(1,j) && inputNodes(2,i)==filteredNodes(2,j))    
             check=false;  %indicate repition
             break;
            end
        end
        if(check ==true)
         %append new coordinate to the new matrix only with unique coordinates   
         filteredNodes=[filteredNodes,inputNodes(:,i)]; 
         
        end  
    end
end