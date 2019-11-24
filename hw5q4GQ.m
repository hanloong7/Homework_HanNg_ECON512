function returnVal = hw5q4GQ(beta,sigmaB,mu,sigmaU,sigmaUB,gamma,data,node);
           
    sigma = [sigmaB.^2,sigmaUB;sigmaUB,sigmaU.^2];
    posd = sum(eig(sigma)>0);
        
    if posd == 2    
        %Gaussian Quadrature;
        [x,w] = qnwnorm([20,20],[beta,mu],...
                sigma);
        
        %Logistic Distribution
        F = @(eps) 1./(1+exp(-eps));
    
        %Stretch matrix;
        stretch_dataX = node.^2;
        data.X = repmat(data.X,[1,1,stretch_dataX]);
        data.Y = repmat(data.Y,[1,1,stretch_dataX]);
        data.Z = repmat(data.Z,[1,1,stretch_dataX]);
    
       
        B = reshape(x(:,1),1,1,stretch_dataX);
        U = reshape(x(:,2),1,1,stretch_dataX);
        w = reshape(w,1,1,stretch_dataX);
        
        %Individual Likelihood
        Fval = F(B.*data.X + gamma.*data.Z + U);
        first_part = Fval.^data.Y;
        second_part = (1-Fval).^(1-data.Y);
        likeli_indiv = prod(first_part.*second_part).*w;
        
        returnVal = sum(likeli_indiv,3);
        returnVal = sum(log(returnVal));
        
    else
        returnVal = -Inf;
    end
    
end