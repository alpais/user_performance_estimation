function [tactilePressure ] = putGloveDataInRavinFormat(tactile_front, tactile_side)
%PUTGLOVEDATAINRAVINFORMAT Summary of this function goes here
%   Detailed explanation goes here

tactilePressure = zeros(6,6,2,size(tactile_front,1));

thumb = 1; index = 2; middle = 3; ring = 4; pinky = 5; palm = 6;

k = 1;
for i = 1:size(tactile_front, 1)
    tactilePressure(thumb,1,k,i) = tactile_front(i, 1);
    tactilePressure(thumb,2,k,i) = tactile_front(i, 2);
    
    tactilePressure(index,1,k,i) = tactile_front(i, 3);
    tactilePressure(index,2,k,i) = tactile_front(i, 4);
    tactilePressure(index,3,k,i) = tactile_front(i, 5);
    
    tactilePressure(middle,1,k,i) = tactile_front(i, 6);
    tactilePressure(middle,2,k,i) = tactile_front(i, 7);
    tactilePressure(middle,3,k,i) = tactile_front(i, 8);
    
    tactilePressure(ring,1,k,i) = tactile_front(i, 9);
    tactilePressure(ring,2,k,i) = tactile_front(i,10);
    tactilePressure(ring,3,k,i) = tactile_front(i,11);
    
    tactilePressure(pinky,1,k,i) = tactile_front(i,12);
    tactilePressure(pinky,2,k,i) = tactile_front(i,13);
    tactilePressure(pinky,3,k,i) = tactile_front(i,14);
    
    tactilePressure(palm,1,k,i) = tactile_front(i,15);
    tactilePressure(palm,2,k,i) = tactile_front(i,16);
    tactilePressure(palm,3,k,i) = tactile_front(i,17);
    
end

k = 2;
for i = 1:size(tactile_front, 1)
    tactilePressure(thumb,1,k,i) = tactile_side(i, 1);
    tactilePressure(thumb,2,k,i) = tactile_side(i, 2);
    
    tactilePressure(index,1,k,i) = tactile_side(i, 3);
    tactilePressure(index,2,k,i) = tactile_side(i, 4);
    tactilePressure(index,3,k,i) = tactile_side(i, 5);
    
    tactilePressure(middle,1,k,i) = tactile_side(i, 6);
    tactilePressure(middle,2,k,i) = tactile_side(i, 7);
    tactilePressure(middle,3,k,i) = tactile_side(i, 8);
    
    tactilePressure(ring,1,k,i) = tactile_side(i, 9);
    tactilePressure(ring,2,k,i) = tactile_side(i,10);
    tactilePressure(ring,3,k,i) = tactile_side(i,11);
    
    tactilePressure(pinky,1,k,i) = tactile_side(i,12);
    tactilePressure(pinky,2,k,i) = tactile_side(i,13);
    tactilePressure(pinky,3,k,i) = tactile_side(i,14);
    
    tactilePressure(palm,1,k,i) = tactile_side(i,15);
    tactilePressure(palm,2,k,i) = tactile_side(i,16);
    tactilePressure(palm,3,k,i) = tactile_side(i,17);
    
end
end

