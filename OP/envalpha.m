function g = envalpha(al,m,N)
% Fun��o para gera��o das vari�veis aleat�rias da envolt�ria
% no modelo de desvanecimento Alpha-Mu

C =@(al,m) (al.*m.^(m))./gamma(m);

fdp =@(x,al,m) C(al,m)*(x.^(al*m-1)).*exp(-m*x.^al);

% Identifica��o do M�ximo da FDP para Utiliza��o
% no Limite Superior do M�todo de Monte Carlo
y = fdp(0:0.001:10,al,m);
mx = real(max(y));
if mx > 10
    mx = pi;
end

g = [];
% Gera��o das Vari�veis Aleat�rias da Envolt�ria
% no Modelo Kappa-Mu
while length(g) <= N
    x1 = random('unif',0,2*pi,[1 N]);
    y = random('unif',0,mx,[1 N]);
    [~,x] = find(y <= fdp(x1,al,m));
        g = cat(2,g,x1(x));
end

g = g(1:N);

end

