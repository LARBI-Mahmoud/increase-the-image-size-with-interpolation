clear; clc;
k = imread("lena.png");

function c = calculate (y)
    for i=1:length(y)
        t(i) = i;
    end



    N = length(t);
    n = N-1 ;

    h= (t(N) - t(1))/n ;
    
    trid = diag(4*ones(1,n-1))+diag(ones(1,n-2),1)+diag(ones(1,n-2),-1);
    
    for i=1:n-1
        z(i)=6/h^2*(y(i+2)-2*y(i+1)+y(i));
    end
    z = double(z');
    w = inv(trid)*z ;
    sigma = [0;w;0] ;

    for i=1:n
        d(i) = y(i);
        b(i) = sigma(i);
        a(i) = (sigma(i+1)-sigma(i))/(6*h);
        c(i) = (y(i+1)-y(i))/h-h/6*(2*sigma(i)+sigma(i+1));
    end
    r = 4;
    hh = h/r;

    x = 1:hh:2*n ;
    for i=1:n
        for j=r*(i-1)+1:r*i
            s(j) = a(i)*(x(j)-t(i))^3+b(i)*(x(j)-t(i))^2+c(i)*(x(j)-t(i))+d(i);
        end
    end
    s(r*n+1) = y(N);
    c= s ;
endfunction

for a=1:length(k(:,1))
    y=k(a,:);
    u(a,:)=calculate(y);
end
imshow (u);
imwrite(u,"rezult.jpg");