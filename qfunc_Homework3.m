function [f grad] = qfunc_ps3(data_X,data_y,beta)

f = -sum(-exp(data_X*beta) + data_y.*(data_X*beta));
grad = -(data_X'*(data_y-exp(data_X*beta)));

end