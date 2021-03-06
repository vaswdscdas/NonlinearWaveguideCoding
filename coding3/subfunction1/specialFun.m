%DELAT Function for \delta bessel functions.
%   ref:https://github.com/Jiaqi-knight/NonlinearWaveguideCoding
%   Email:Jiaqi_Wang@sjtu.edu.cn
%Copyright 2020, SJTU.

%coding3 is updating h as array..
function [X1]= specialFun(s,h,kappa,m,n,Cmn1,jmn_pm,op) %k+ right

switch op
    case 'hh`^2/[1-\kappa*h*cos\psi]'
        h_diff=[(h(2)-h(1))/(s(2)-s(1)) diff(h)./diff(s)];
        X1=zeros(n*length(m)*n*length(m),length(h));
        [D,O]=deltaT(m,n,2,1);
        om1=O.M1(:)-m(1)+1;om2=O.M2(:)-m(1)+1;
        on1=O.N1(:);on2=O.N2(:);
        
        for hk=1:length(h)
            for k=1:length(om1)
                X1(k,hk)=...
                    quad(@(theta) h(hk)*h_diff(hk)^2./(1-kappa(hk)*h(hk).*cos(theta))...
                    *Cmn1(on1(k),om1(k),hk)*Cmn1(on2(k),om2(k),hk)...
                    *besselj(m(om1(k)),jmn_pm(on1(k),om1(k)))...
                    *besselj(m(om2(k)),jmn_pm(on2(k),om2(k)))...
                    .*exp(sqrt(-1)*m(om1(k))*theta)...
                    .*exp(sqrt(-1)*m(om2(k))*theta),0,2*pi,1e-4);
            end
        end
        X1=reshape(X1,n*length(m),n*length(m),length(h));
        
    case 'h(1-\kappa*h*cos\psi)'
        
        X1=zeros(n*length(m)*n*length(m),length(h));
        [D,O]=deltaT(m,n,2,1);
        om1=O.M1(:)-m(1)+1;om2=O.M2(:)-m(1)+1;
        on1=O.N1(:);on2=O.N2(:);
        
        for hk=1:length(h)
            for k=1:length(om1)
                X1(k,hk)=...
                    quad(@(theta) h(hk)*(1-kappa(hk)*h(hk).*cos(theta))...
                    *Cmn1(on1(k),om1(k),hk)*Cmn1(on2(k),om2(k),hk)...
                    *besselj(m(om1(k)),jmn_pm(on1(k),om1(k)))...
                    *besselj(m(om2(k)),jmn_pm(on2(k),om2(k)))...
                    .*exp(sqrt(-1)*m(om1(k))*theta)...
                    .*exp(sqrt(-1)*m(om2(k))*theta),0,2*pi,1e-4);
            end
        end
        X1=reshape(X1,n*length(m),n*length(m),length(h));
end

end
