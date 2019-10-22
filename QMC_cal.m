function [returnVal] = QMC_cal(f, lb, ub,haltonseq)

diff = ub - lb;
h = lb + diff.*haltonseq;
fh = f(h);

%Area;
returnVal = diff*mean(fh);

end