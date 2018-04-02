clc;
clear all;
close all;

load mnist_data
X=train;
Y=test;

kval=[1; 5; 9; 13];

rng(10);
x=X;
index = randsample(1:10000, 100);
y = Y(index,:);

labels_test=y(:,1);
labels_train=x(:,1);
A=x(:,[2:785]);
B=y(:,[2:785]);


labels=zeros(100,4);


for m=1:4
    k=kval(m,1);
    nearest_neighbor=zeros(k,1);
    class_of_nearest_neighbors=zeros(k,1);
    count=zeros(10,1);
for i=1:100
    b=B(i,:);
    foo=repmat(b, 60000, 1);
    calculate_norm_of=abs(A-foo);
    norms=(sum((calculate_norm_of),2));
    vec = zeros(60000,2);
    vec(:,1) = norms;
    vec(:,2) = labels_train;
    sorted = sortrows(vec);
    
    for j=1:k
        digit = sorted(j,2);
        count(digit+1) = count(digit+1) + 1;
    end
    
    [p in]=max(count);
    labels(i,m)=in-1;
    count=zeros(10,1);
end

end

disp('Accuracy for k=1');
disp(100-nnz(labels(:,1)-labels_test));
disp('Accuracy for k=5');
disp(100-nnz(labels(:,2)-labels_test));
disp('Accuracy for k=9');
disp(100-nnz(labels(:,3)-labels_test));
disp('Accuracy for k=13');
disp(100-nnz(labels(:,4)-labels_test));
    

