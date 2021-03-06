close all
clear all

%========================
% FSELIB
%
% Code: elm_line1_dr
%
% Element discretization
%=======================
                                                                                
%-----------
% input data
%-----------

x1 = 0.0;
x2 = 1.0;
n  = 10;

ratio = 0.1;

%-----------
% discretize
%-----------

xe = elm_line1 (x1,x2,n,ratio);

%-----
% plot
%-----

figure(1)
ye= zeros(n+1,1);
plot(xe, ye,'-ok');
set(gca,'fontsize',12)
axis equal
axis([x1-0.10,x2+0.10,-0.1,0.1])
axis off

%-----
% done
%-----
