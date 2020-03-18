%Main-Function
%   ref:https://github.com/Jiaqi-knight/NonlinearWaveguideCoding
%   Email:Jiaqi_Wang@sjtu.edu.cn
%   Copyright 2020, SJTU.
%-----------------------------------------------------------------%
clc
%clear
close all
%opengl('save','software')

load('X2.mat');load('X3.mat');
subfunction_path1='.\subfunction1'
addpath(genpath(subfunction_path1));
subfunction_path2='.\chebfun-master'
addpath(genpath(subfunction_path2));
m=-5:5;
n=4;
%tau=1;
a=[1:5];

%% #######Geometry########%
s =logspace(0,1,50);
h=0.1*exp(linspace(0,1.5,length(s)));
kappa=(2/3)./h;tau=0.2./h;
sw=sqrt(kappa.^2+tau.^2).*s;
x = kappa./(kappa.^2+tau.^2).*sin(sw+0);y = kappa./(kappa.^2+tau.^2).*cos(sw+0);z = tau./(kappa.^2+tau.^2).*sw;
theta_0=cumsum(tau.*[0 diff(s)]);

%tubeplot(x,y,z,h,s,50);hold on;plot3(x, y, z);daspect([1,1,1]); camlight;


%% X-2D-3D
op={'ab','pr_ab','ps_ab'};op_m={'1','r','r2'};
op_name2={'X_{\alpha\beta}','X_{[\alpha]\beta}','X_{\{\alpha\}\beta}'};
op_name3={'X_{\alpha\beta\gamma}','X_{[\alpha]\beta\gamma}','X_{\{\alpha\}\beta\gamma}'};

Op={'ab','pt_ab','ps_ab','ab_cos','ab_sin','pt_ab_cos','pt_ab_sin','ps_ab_cos','ps_ab_sin'};
Op2_name={'\Theta_{\alpha\beta}','\Theta_{(\alpha)\beta}','\Theta_{\{\alpha\}\beta}','\Theta_{\alpha\beta}[cos\phi]',...
    '\Theta_{\alpha\beta}[sin\phi]','\Theta_{(\alpha)\beta}[cos\phi]','\Theta_{(\alpha)\beta}[sin\phi]','\Theta_{\{\alpha\}\beta}[cos\phi]','\Theta_{\{\alpha\}\beta}[sin\phi]'};
Op3_name={'\Theta_{\alpha\beta\gamma}','\Theta_{(\alpha)\beta\gamma}','\Theta_{\{\alpha\}\beta\gamma}','\Theta_{\alpha\beta\gamma}[cos\phi]',...
    '\Theta_{\alpha\beta\gamma}[sin\phi]','\Theta_{(\alpha)\beta\gamma}[cos\phi]','\Theta_{(\alpha)\beta\gamma}[sin\phi]','\Theta_{\{\alpha\}\beta\gamma}[cos\phi]','\Theta_{\{\alpha\}\beta\gamma}[sin\phi]'};

%%


C=[1 2 3; 4 5 6; 7 8 9];
out = bsxfun(@times,C,reshape(a,1,1,[]));%permute(a,[3,1,2])


V=bsxfun(@times,X2{2,2}.',reshape(1./(sqrt(-1)*a*kappa(1)),1,1,[])); %(3.26)  --��չ��ά-s&a

% W
% M
% G
% H
% A
% B
% C
% D
% E