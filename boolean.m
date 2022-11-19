% initialize variable
N = [2 3 4 5];
nTrials = 10^4;
nEpoch = 20;
eta = 0.05;

for e = 1:size(N,2)
    n = N(e);
    counter = 0;
    booleanInputs = GenerateBooleanInputs(n);
    usedBoolean = [];

    for trial = 1:nTrials
        % boolean function
        booleanOutputs = zeros(2^n,1);
        for i= 1:size(booleanOutputs,1)
            r = rand;
            if(r > 0.5)
                booleanOutputs(i) = 1;
            else
                booleanOutputs(i) = -1;
            end
        end

        if trial == 1 || ~ismember(booleanOutputs',usedBoolean,'rows') 

            w = randn(1,n)/sqrt(n); % generate weight
            theta = 0; %threshold
            for epoch = 1:nEpoch
                totalError = 0;
                for mut = 1:2^n %each pattern
                    y = 0;
                    for j = 1:n
                        y = y + w(j)*booleanInputs(j,mut);
                    end
                    y = y - theta;
                    % sgn
                    if(y >= 0)
                        y = 1;
                    else 
                        y = -1;
                    end

                    err = booleanOutputs(mut)-y;

                    w = w + eta*err*booleanInputs(:,mut)';
                    theta = theta - eta*err;

                    totalError = totalError + abs(err);        
                end
                if totalError == 0
                    counter = counter + 1;
                    break
                end
                
            end
            usedBoolean = cat(1,usedBoolean,booleanOutputs');
        end   
        

    end

    sprintf('n = %i: , count: %i , number of boolean generated: %i',n,counter,size(usedBoolean,1))

end


function booleanInputs = GenerateBooleanInputs(n)
     booleanInputs = zeros(n,2^n);
     for i = 1:n
         value = 1;
         count = 1;
         for j = 1:2^n
            booleanInputs(i,j) = value;
            if(count == 2^(i-1))
                count = 1;
                value = value * (-1);
            else
                count = count + 1;
            end
         end
     end
end
   
