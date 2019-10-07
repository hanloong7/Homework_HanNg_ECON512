function [x] = secant(f,init)
    g = @(x) f(x);
    x = init(1);
    xOld = 0;
    gOld = g(xOld);

    % Secant iterations:
    tol = 1e-8;
    maxit = 100;
    for iter =1:maxit
        gVal = g(x);
        %fprintf('iter %d: x = %.8f, g(x) = %.8f\n', iter, x, gVal);
        if abs(gVal) < tol
            break
        else
              xNew = x - ( (x - xOld) / (gVal - gOld) )* gVal;
              xOld = x;
              x = xNew;
              gOld = gVal;
        end
    end
end

