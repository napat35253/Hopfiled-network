patternArray = [12,24,48,70,100,120];
patternArray = [12];
N = 120;
nTrials = 10 ^ 5;

for p = patternArray

    nError = 0;

    for nTrials = 1:nTrials

        x = GenerateStorePattern(p,N);

        % Hebb's rule
        W = zeros(N,N);
        for i = 1:p
            W = x(:,i)*x(:,i)'+W;
        end

        for j = 1:N
            W(j,j) = 0;
        end
        W = (1/N)*W;
        
        %randomly choose neuron
        pRan = randi([1 p],1,1);
        nRan = randi([1 N],1,1);
        
        %feed one
        b = 0;
        for j = 1:N
            b = b + W(nRan,j) * x(j,pRan);
        end
        
        output = 0;
        %async update
        if(b>=0)
            output = 1;
        else 
            output = -1;
        end

        %check error
        if(output ~= x(nRan,pRan))
            nError = nError +1;
        end

    end

    pError = nError/nTrials;

end

function storePattern = GenerateStorePattern(p,N)
    storePattern = zeros(N,p);
    for i = 1:N
        for j = 1:p
            ran = rand;
            if(ran>0.5)
                storePattern(i,j) = 1;
            else 
                storePattern(i,j) = -1;
            end
        end
    end
end