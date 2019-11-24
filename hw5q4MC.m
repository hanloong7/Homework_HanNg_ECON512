function returnVal = hw5q4MC(beta,sigmaB,mu,sigmaU,sigmaUB,gamma,data,node)
        rng(1);

    %Another way of Cholesky Decomposition
    sigma = [sigmaB.^2,sigmaUB;sigmaUB,sigmaU.^2];
    
    %Check if positive definite;
    posd = sum(eig(sigma)>0);
   
    if posd == 2
        cho = chol(sigma);
        z = randn(node,2);;
        
        
        simul_draws = repmat([beta mu],node,1) ...
            + z*cho;
    
        B = simul_draws(:,1);
        U = simul_draws(:,2);
   
        %Logistic Distribution
        F = @(eps) 1./(1+exp(-eps));
    
        %Stretch matrix;
        stretch_dataX = node.^2;
        data.X = repmat(data.X,[1,1,stretch_dataX]);
        data.Y = repmat(data.Y,[1,1,stretch_dataX]);
        data.Z = repmat(data.Z,[1,1,stretch_dataX]);
    
        B = repelem(B,node);
        B = reshape(B,1,1,stretch_dataX);
        U = repmat(U,node,1);
        U = reshape(U,1,1,stretch_dataX);
    
        %Individual Likelihood
        Fval = F(B.*data.X + gamma.*data.Z + U);
        first_part = Fval.^data.Y;
        second_part = (1-Fval).^(1-data.Y);
        likeli_indiv = prod(first_part.*second_part);
    
        returnVal = mean(likeli_indiv,3);
        returnVal = sum(log(returnVal));
    
    
    else
        returnVal = -Inf;
    end
    
end