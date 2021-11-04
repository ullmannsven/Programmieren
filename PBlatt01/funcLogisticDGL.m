function x = funcLogisticDGL(~,y)
    %parameter
    alpha = 10;
    beta = 1;
    
    %logistische DGL
    x = alpha*y - beta*(y^2);
end

