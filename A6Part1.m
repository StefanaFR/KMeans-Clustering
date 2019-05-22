% Stefana Rusu - Assignment 6 - part 1
tic % start timer

load fisheriris;
data = meas; 
k = 3; % 3 clusters
numberOfIterations = 100; % number of iterations for the k-means to run on

randomIndices = randperm(size(data,1)); % randomly reorders the indices of the data set
centroids = data(randomIndices(1:k), :); % the centroids are the reordered indices

% loop for as many iterations as given above
for i=1:numberOfIterations
  indices = nearestCentroid(data, centroids);
  centroids = clusterCentroids(data, indices, k); %returns the re-calculated centroids
end 

% display the centroid matrix
centroids
toc  % end timer

% Function that takes in the data and the centroids and returns the indices
% (it computes the euclidean distance for every data point in each cluster)
function indices = nearestCentroid(data, centroids)
 % find the number of centroids 
  numCentroids = size(centroids, 1);
  indices = zeros(size(data,1), 1);
 % find the number of data points
  numDataPoints = size(data,1);
  
 % for every data point
  for i=1:numDataPoints
    % initialize index
    index = 1;
    
    % find the smallest distance
    smallestDistance = sum((data(i,:) - centroids(1,:)).^2);
    
    % for every centroid
    for j=2:numCentroids
        % compute Euclidean distance
        distance = sum((data(i,:) - centroids(j,:)).^2);
        % check if distances are smaller than the smallest distance
        if(distance < smallestDistance)
          smallestDistance = distance; % if so, they become the new smallest distance
          index = j; % j is the index of the nearest centroid
        end
    end
    indices(i) = index;
  end
end

% Function that re-calculates the clustered centroids
% computes the mean of all data points in each cluster and returns a new 
% centroid of the cluster
function newCentroids = clusterCentroids(data, indices, k)
  [rows, columns] = size(data); % get the rows and columns of matrix data
  newCentroids = zeros(k, columns); % 3x4 matrix
  
    % This loop takes all the data points that identify with cluster 1, 
    % uses those to get the mean (the centroid/center point) for the 
    % cluster, then moves on and does the same for clusters 2 and 3
  for i=1:k
    % get all the data points where the assigned cluster = i 
    dataPoints = data((indices==i),:);
    totalPoints = size(dataPoints,1);
    % compute average of centroids and return them as new centroids
    newCentroids(i, :) = (1/totalPoints) * sum(dataPoints); 
  end
end
