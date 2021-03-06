clear all
%close all

%==============================================
% Code sds_any
%
% Steady 1D diffusion for arbitrary element
% node distribution
%==============================================

%---
% prepare
%---

figure(1)
hold on
xlabel('x','fontsize',15);
ylabel('f','fontsize',15);
set(gca,'fontsize',15)
box on

%-----------
% input data
%-----------

idistr = 2; % lobatto
idistr = 1; % uniform

%-----------
% input data
%-----------

L=1.0; k=1.0; fL=0; q0=-1.0;

ne=2; ratio=1.0;               % number of elements, stretch ratio
np(1)=2; np(2)=2; np(3)=4;

icase = 1;
icase = 2;
icase = 3;

if(icase==1)
 ne=2; ratio=1.0;
 np(1) = 4; np(2) = 4;
end

if(icase==2)
 q0 = -L;
 fL = exp(1.0);
 ne=1; ratio=2.0;
 np(1) = 3;
end

if(icase==3)
 q0 = -100/26^2;
 fL = 1/26.0;
 ne = 4; ratio = 1.0;
 np(1) = 6;
 np(2) = 6;
 np(3) = 4;
 np(4) = 4;
 np(5) = 4;
end

%-----
% trap
%-----

for i=1:ne

   if(np(i)>8)
   disp(' -->');
   disp(' max polynomial order is 8');
   error(' sds_any: Sorry this high order not yet implemented');
   end

end

%-----------
% element node generation 
%-----------

[xe,xen,xien,xg,c,ng] = discr_any (0,L,ne,ratio,np,idistr);

%-------------------
% specify the source
%-------------------

for i=1:ng
 if(icase==1)
  s(i) = 10.0*exp(-5.0*xg(i)^2/L^2);
 elseif(icase==2)
  s(i) = -exp(xg(i));
 elseif(icase==3)
  xhat = 2*xg(i)-1;
  s(i) = 200*(1-75*xhat^2)/(1+25*xhat^2)^3 ;
  nplot=64;
  for i=1:nplot
   xex(i) = (i-1)/nplot;
   xhat = 2*xex(i)-1;
   yex(i) = 1.0/(1+25*xhat^2);
  end
  plot(xex,yex,'-k','LineWidth',2)
 end
end

%-----------------
% element assembly
%-----------------

[gdm,b] = sds_any_sys (ne,xe,np,ng,c,xien,q0,fL,k,s);

%--------------
% linear solver
%--------------

gdm(:,ng) = [];  % remove the last (ng) column
gdm(ng,:) = [];  % remove the last (ng) row
b(:,ng) = [];    % remove the last (ng) element

f = b/gdm';       % solve the linear system

f = [f fL];      % add the value at the right end

%-----
% plot
%-----

plot(xg, f,'k-+')

%ye = zeros(ne+1,1);
%plot(xe,ye,'ko');
%for i=1:ne
% plot([xe(i),xe(i)],[0,2.5],'k:');
%end

%-----
% done
%-----
