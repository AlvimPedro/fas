function [Po] = Pout(gth,gb,alpha,mu,W,N)

    omega = gamma(mu+2/alpha(1)) / (mu^(2/alpha(1))*gamma(mu)); 
    
    rho = linspace(1e-5,500,1e4);
    % k = 2:1:N;
    
    % Correlation Model, Jakes
    % delta = besselj(0,2*pi*W*(k-1)/(N-1)).^2;
    
    % New Correlation Model, Tabelado
    switch W
    case 0.5
        delta = 0.822599623583^2;
    case 1
        delta = 0.556107207025^2;
    case 1.5
        delta = 0.464519898111^2;
    case 2
        delta = 0.396664784074^2;
    case 3
        delta = 0.324684221336^2;
    otherwise
        delta = 0;
    end
    
    
    % mq =@(k) marcumq(sqrt(2*mu*delta*rho.^alpha(1)/(1-delta)),...
    %                  sqrt(2*mu*(gth/gb)^(alpha(k)/2)/(1-delta)),mu);
    % f = ones(1,length(rho));
    % for k = 1:N
    %     f = f .*(ones(1,length(rho))-mq(k));
    % end
    
    % f = f .* rho.^(alpha(1)*mu-1).*exp(-mu*rho.^alpha(1));
    
    % Po = alpha(1)*mu^mu*trapz(rho,f)/gamma(mu);
    
    
    % //////////////////////////////////////////////////////
    mq =@(k) marcumq(sqrt(2*delta*rho/(1-delta)),...
                     sqrt(2*mu*(omega*gth/gb)^(alpha(k)/2)/(1-delta)),mu);
    f = ones(1,length(rho));
    for k = 1:N
        f = f .*(ones(1,length(rho))-mq(k));
    end
    
    f = f .* rho.^(mu-1).*exp(-rho);
    
    Po = trapz(rho,f)/gamma(mu);
    
    % //////////////////////////////////////////////////////////
    
    
    
    
    end