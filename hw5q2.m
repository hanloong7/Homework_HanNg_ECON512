function returnVal = hw5q1(beta,sigma,gamma,data,node)
    
    %Logistic CDF
    F = @(eps) 1./(1+exp(-eps));
    
    %Gaussian Quadrature
    rng(1);
    x=beta + sigma*randn(node,1);
    
    %Stretch Matrix
    stretch_dataX = length(x);
    data.X = repmat(data.X,[1,1,stretch_dataX]);
    data.Y = repmat(data.Y,[1,1,stretch_dataX]);
    data.Z = repmat(data.Z,[1,1,stretch_dataX]);    
    
    x = reshape(x,1,1,stretch_dataX);    
    %w = reshape(w,1,1,stretch_dataX);
    
    %Individual Likelihood
    Fval = F(x.*data.X + gamma.*data.Z);
    first_part = Fval.^data.Y;
    second_part = (1-Fval).^(1-data.Y);
    likeli_indiv = prod(first_part.*second_part);
    %likeli_indiv = prod(first_part.*second_part).*w; %1x100x20
    
    %Whole Likelihoodw
    returnVal = mean(likeli_indiv,3); %Weighted sums
    returnVal = sum(log(returnVal));
end