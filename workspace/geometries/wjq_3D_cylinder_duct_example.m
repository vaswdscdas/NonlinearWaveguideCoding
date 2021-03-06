%%
%        Project: Duct Acoustic in curvilinear coordination by LBM
%         Author: Jiaqi Wang
%    Institution: Shanghai Jiaotong University
%                 Sound and Vibration insitition
% Research group:
%        Version: 0.1
%  Creation date: June 30th, 2020
%    Last update: J
%
%    Description: 圆柱-》Vertification code for g_ij, & christoffel symbol
%    R(u,n)=[sin(u)*cos(n), sin(u)*sin(n),cos(u)]
%    g=[dR/du*dR/du dR/du*dR/dn;
%       dR/dn*dR/du dR/dn*dR/dn;]
%    gamma_bc^a=1/2*g^ad*(g_bd,c+g_cd,c-g_bc,d)
%
%          Input:
%         Output:

%%


clear all
close all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subfunction_path1=genpath('C:\Users\Jiaqi-knight\Documents\GitHub\NonlinearWaveguideCoding\workspace\mesh_generation-master\matlab\Structured');
subfunction_path2=genpath('C:\Users\Jiaqi-knight\Documents\GitHub\NonlinearWaveguideCoding\workspace\interpolation-master\matlab');
subfunction_path3=genpath('C:\Users\Jiaqi-knight\Documents\GitHub\NonlinearWaveguideCoding\workspace\differential_geometry-master\matlab');
addpath(subfunction_path1);
addpath(subfunction_path2);
addpath(subfunction_path3);
formatOut = 'mm-dd-yy-HH-MM-SS';
logfullfile=[datestr(now,formatOut),'.log'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% DUCT MESHES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

eta1min = 0;
Neta1 = 20;
deltaeta1 = 1;
eta1max = eta1min + (Neta1-1)*deltaeta1;

eta2min = 0;
Neta2 = 40;
deltaeta2 = 1;
eta2max = eta2min + (Neta2-1)*deltaeta2;

eta3min = 0;
Neta3 = 10;
deltaeta3 = 1;
eta3max = eta3min + (Neta3-1)*deltaeta3;


Nr = Neta1;
rmin = 10;
rmax = 25;
deltar = (rmax-rmin)/(Nr-1);

Nt = Neta2;
tmin = 0;
tmax = 2*pi;%0和2pi重复包含
deltat = (tmax-tmin)/(Nt);
tmax=tmax-deltat;
tmin:deltat:tmax;

Nz = Neta3;
zmin = 0;
zmax = 2;
deltaz = (zmax-zmin)/(Nz-1);
deltaq = [deltar deltat deltaz];

N = Nr*Nt*Nz;

lattice = generatelattice3D(eta1min,Neta1,deltaeta1,eta2min,Neta2,deltaeta2,eta3min,Neta3,deltaeta3,rmin,rmax,Nr,tmin,tmax,Nt,zmin,zmax,Nz);

%lattice第5，6,7列为transform后的坐标点
% Apply the parameterization to obtain R^3 coordinates
lattice(:,7) = lattice(:,4).*cos(lattice(:,5)); %x
lattice(:,8) = lattice(:,4).*sin(lattice(:,5)); %y
lattice(:,9) = lattice(:,6); %z

[indicesbulk,indicesinternalbulk,indicesF1,indicesF2,indicesF3,indicesF4,indicesF5,indicesF6,indicesinternalF1,indicesinternalF2,indicesinternalF3,indicesinternalF4,indicesinternalF5,indicesinternalF6,indicesE1,indicesE2,indicesE3,indicesE4,indicesE5,indicesE6,indicesE7,indicesE8,indicesE9,indicesE10,indicesE11,indicesE12,indicesinternalE1,indicesinternalE2,indicesinternalE3,indicesinternalE4,indicesinternalE5,indicesinternalE6,indicesinternalE7,indicesinternalE8,indicesinternalE9,indicesinternalE10,indicesinternalE11,indicesinternalE12,indicesC1,indicesC2,indicesC3,indicesC4,indicesC5,indicesC6,indicesC7,indicesC8,indicesinternalC1,indicesinternalC2,indicesinternalC3,indicesinternalC4,indicesinternalC5,indicesinternalC6,indicesinternalC7,indicesinternalC8]=getindices3D(Nr,Nt,Nz);
%% visualization
f1 = figure();
title('Computational and physical domains')
hold on
subplot(1,2,1);
subplot(1,2,2);
hsubfigs = get(f1,'Children');
fcomp = hsubfigs(2);
fphys = hsubfigs(1);
subplot(fcomp);%view(fcomp,[-42.3 -6.8]);
plot3(lattice(:,1),lattice(:,2),lattice(:,3),'b.')
hold on
plot3(lattice(indicesC1,1),lattice(indicesC1,2),lattice(indicesC1,3),'Marker','pentagram')
plot3(lattice(indicesC2,1),lattice(indicesC2,2),lattice(indicesC2,3),'Marker','pentagram')
plot3(lattice(indicesC3,1),lattice(indicesC3,2),lattice(indicesC3,3),'Marker','pentagram')
plot3(lattice(indicesC4,1),lattice(indicesC4,2),lattice(indicesC4,3),'Marker','pentagram')
plot3(lattice(indicesC5,1),lattice(indicesC5,2),lattice(indicesC5,3),'Marker','pentagram')
plot3(lattice(indicesC6,1),lattice(indicesC6,2),lattice(indicesC6,3),'Marker','pentagram')
plot3(lattice(indicesC7,1),lattice(indicesC7,2),lattice(indicesC7,3),'Marker','pentagram')
plot3(lattice(indicesC8,1),lattice(indicesC8,2),lattice(indicesC8,3),'Marker','pentagram')
text(Nr/2,-2,0,'E1');text(Nr+2,Nt/2,0,'E2');text(Nr/2,Nt+1,0,'E3');text(-4,Nt/2,0,'E4');
text(-2,-2,Nz/2,'E5');text(Nr,-1,Nz/2,'E6');text(Nr+1,Nt+1,Nz/2,'E7');text(-6,Nt,Nz/2,'E8');
text(Nr/2,-2,Nz,'E9');text(Nr+2,Nt/2,Nz,'E10');text(Nr/2,Nt+1,Nz,'E11');text(-4,Nt/2,Nz,'E12');
text(Nr/2,Nt/2,-1,'F1下','Color','red');text(Nr/2,-1,Nz/2,'F2前','Color','red');text(Nr+1,Nt/2,Nz/2,'F3右','Color','red');
text(Nr/2,Nt+1,Nz/2,'F4后','Color','red');text(-1,Nt/2,Nz/2,'F5左','Color','red');text(Nr/2,Nt/2,Nz+1,'F6上','Color','red');
text(lattice(indicesC1,1),lattice(indicesC1,2),lattice(indicesC1,3),'C1')
text(lattice(indicesC2,1),lattice(indicesC2,2),lattice(indicesC2,3),'C2')
text(lattice(indicesC3,1),lattice(indicesC3,2),lattice(indicesC3,3),'C3')
text(lattice(indicesC4,1),lattice(indicesC4,2),lattice(indicesC4,3),'C4')
text(lattice(indicesC5,1),lattice(indicesC5,2),lattice(indicesC5,3),'C5')
text(lattice(indicesC6,1),lattice(indicesC6,2),lattice(indicesC6,3),'C6')
text(lattice(indicesC7,1),lattice(indicesC7,2),lattice(indicesC7,3),'C7')
text(lattice(indicesC8,1),lattice(indicesC8,2),lattice(indicesC8,3),'C8')

for i=1:length(indicesE1)
    plot3(lattice(indicesE1(i),1),lattice(indicesE1(i),2),lattice(indicesE1(i),3),'or')
    hold on
end
for i=1:length(indicesF1)
    plot3(lattice(indicesF1(i),1),lattice(indicesF1(i),2),lattice(indicesF1(i),3),'*r')
    hold on
end
for i=1:length(indicesF2)
    plot3(lattice(indicesF2(i),1),lattice(indicesF2(i),2),lattice(indicesF2(i),3),'*k')
    hold on
end
for i=1:length(indicesF3)
    plot3(lattice(indicesF3(i),1),lattice(indicesF3(i),2),lattice(indicesF3(i),3),'*g')
    hold on
end
for i=1:length(indicesF4)
    plot3(lattice(indicesF4(i),1),lattice(indicesF4(i),2),lattice(indicesF4(i),3),'*y')
    hold on
end
grid on
xlabel('$\xi_{1}$','Interpreter','LaTex')
ylabel('$\xi_{2}$','Interpreter','LaTex')
zlabel('$\xi_{3}$','Interpreter','LaTex')
title('Mesh in lattice domain (computational space)')
subplot(fphys);%view(fphys,[-42.3 -6.8]);
plot3(lattice(:,7),lattice(:,8),lattice(:,9),'b.')
hold on
plot3(lattice(indicesC1,7),lattice(indicesC1,8),lattice(indicesC1,9),'Marker','pentagram')
plot3(lattice(indicesC2,7),lattice(indicesC2,8),lattice(indicesC2,9),'Marker','pentagram')
plot3(lattice(indicesC3,7),lattice(indicesC3,8),lattice(indicesC3,9),'Marker','pentagram')
plot3(lattice(indicesC4,7),lattice(indicesC4,8),lattice(indicesC4,9),'Marker','pentagram')
plot3(lattice(indicesC5,7),lattice(indicesC5,8),lattice(indicesC5,9),'Marker','pentagram')
plot3(lattice(indicesC6,7),lattice(indicesC6,8),lattice(indicesC6,9),'Marker','pentagram')
plot3(lattice(indicesC7,7),lattice(indicesC7,8),lattice(indicesC7,9),'Marker','pentagram')
plot3(lattice(indicesC8,7),lattice(indicesC8,8),lattice(indicesC8,9),'Marker','pentagram')
for i=1:length(indicesE1)
    plot3(lattice(indicesE1(i),7),lattice(indicesE1(i),8),lattice(indicesE1(i),9),'or')
    hold on
end
for i=1:length(indicesE2)
    plot3(lattice(indicesE2(i),7),lattice(indicesE2(i),8),lattice(indicesE2(i),9),'ok')
    hold on
end
for i=1:length(indicesE3)
    plot3(lattice(indicesE3(i),7),lattice(indicesE3(i),8),lattice(indicesE3(i),9),'xr')
    hold on
end
for i=1:length(indicesE4)
    plot3(lattice(indicesE4(i),7),lattice(indicesE4(i),8),lattice(indicesE4(i),9),'xk')
    hold on
end
for i=1:length(indicesE5)
    plot3(lattice(indicesE5(i),7),lattice(indicesE5(i),8),lattice(indicesE5(i),9),'xk')
    hold on
end
for i=1:length(indicesF1)
    plot3(lattice(indicesF1(i),7),lattice(indicesF1(i),8),lattice(indicesF1(i),9),'*r')
    hold on
end
for i=1:length(indicesF2)
    plot3(lattice(indicesF2(i),7),lattice(indicesF2(i),8),lattice(indicesF2(i),9),'*k')
    hold on
end
for i=1:length(indicesF3)
    plot3(lattice(indicesF3(i),7),lattice(indicesF3(i),8),lattice(indicesF3(i),9),'*g')
    hold on
end
for i=1:length(indicesF4)
    plot3(lattice(indicesF4(i),7),lattice(indicesF4(i),8),lattice(indicesF4(i),9),'oy')
    hold on
end
grid on
xlabel('x')
ylabel('y')
zlabel('z')
title('Mesh in fluid domain (physical space)')

%% tensor calculation
%flagperiodicity = 1; 
periodicity = 2;% 2  --> neighbour of F2 - F4 
flagintbounds = 0;
indicesintbounds = 0;
typeintbounds = 0;
[structuralneighbours,shearneighbours,bendneighbours,firstdevneighbours]=build_neighbourhoods3D(N,Nr,Nt,Nz,periodicity,flagintbounds,indicesintbounds,typeintbounds,indicesbulk,indicesinternalbulk,indicesF1,indicesF2,indicesF3,indicesF4,indicesF5,indicesF6,indicesinternalF1,indicesinternalF2,indicesinternalF3,indicesinternalF4,indicesinternalF5,indicesinternalF6,indicesE1,indicesE2,indicesE3,indicesE4,indicesE5,indicesE6,indicesE7,indicesE8,indicesE9,indicesE10,indicesE11,indicesE12,indicesinternalE1,indicesinternalE2,indicesinternalE3,indicesinternalE4,indicesinternalE5,indicesinternalE6,indicesinternalE7,indicesinternalE8,indicesinternalE9,indicesinternalE10,indicesinternalE11,indicesinternalE12,indicesC1,indicesC2,indicesC3,indicesC4,indicesC5,indicesC6,indicesC7,indicesC8,indicesinternalC1,indicesinternalC2,indicesinternalC3,indicesinternalC4,indicesinternalC5,indicesinternalC6,indicesinternalC7,indicesinternalC8);

%% example
%id=1(3,indicesC1),2(4,edge),1200(5,face),1206(6,internalPoint),indicesF2(802,periodic)
xx=11,yy=0,zz=0
id=xx+1+(yy)*Nr+(zz)*Nr*Nt
figure;hold on;grid on;axis equal
plot3(lattice(id,1),lattice(id,2),lattice(id,3),'Marker','pentagram');text(lattice(id,1),lattice(id,2),lattice(id,3),'0')
for k=1:6
    if structuralneighbours(id,k+1)==-1
        continue
    end
plot3(lattice(structuralneighbours(id,k+1),1),lattice(structuralneighbours(id,k+1),2),lattice(structuralneighbours(id,k+1),3),'Marker','diamond');
text(lattice(structuralneighbours(id,k+1),1),lattice(structuralneighbours(id,k+1),2),lattice(structuralneighbours(id,k+1),3),num2str(k))
end
%shearneighbours:lattice3D 相邻(no period include)
for k=1:20
    if shearneighbours(id,k+1)==-1
        continue
    end
plot3(lattice(shearneighbours(id,k+1),1),lattice(shearneighbours(id,k+1),2),lattice(shearneighbours(id,k+1),3),'Marker','square');
text(lattice(shearneighbours(id,k+1),1),lattice(shearneighbours(id,k+1),2),lattice(shearneighbours(id,k+1),3),['s',num2str(k)])
end
xlabel('$\xi_{1}$','Interpreter','LaTex')
ylabel('$\xi_{2}$','Interpreter','LaTex')
zlabel('$\xi_{3}$','Interpreter','LaTex')
title('Lattice (D3Q27)')
view([-16 40]);
%bendneighbours;更外面一层的正对点
for k=1:6
    if bendneighbours(id,k+1)==-1
        continue
    end
plot3(lattice(bendneighbours(id,k+1),1),lattice(bendneighbours(id,k+1),2),lattice(bendneighbours(id,k+1),3),'Marker','o');
text(lattice(bendneighbours(id,k+1),1),lattice(bendneighbours(id,k+1),2),lattice(bendneighbours(id,k+1),3),['b',num2str(k)])
end
%firstdevneighbours为计算covariantbase设置



xx=0,yy=0,zz=6
id=xx+1+(yy)*Nr+(zz)*Nr*Nt
lattice(4801,1:3)
figure;hold on;
xlabel('$\xi_{1}$','Interpreter','LaTex')
ylabel('$\xi_{2}$','Interpreter','LaTex')
zlabel('$\xi_{3}$','Interpreter','LaTex')
view([-16 40]);
for i=id
    plot3(lattice(id,1),lattice(id,2),lattice(id,3),'Marker','pentagram');
    for j=1:3
        switch firstdevneighbours(i,4*(j-1)+1)
            case 1%内点
                plot3(lattice(firstdevneighbours(i,4*(j-1)+2),1),lattice(firstdevneighbours(i,4*(j-1)+2),2),lattice(firstdevneighbours(i,4*(j-1)+2),3),'Marker','x');
                plot3(lattice(firstdevneighbours(i,4*(j-1)+3),1),lattice(firstdevneighbours(i,4*(j-1)+3),2),lattice(firstdevneighbours(i,4*(j-1)+3),3),'Marker','.');
            case 2%？
                plot3(lattice(firstdevneighbours(i,4*(j-1)+2),1),lattice(firstdevneighbours(i,4*(j-1)+2),2),lattice(firstdevneighbours(i,4*(j-1)+2),3),'Marker','diamond');
                plot3(lattice(firstdevneighbours(i,4*(j-1)+3),1),lattice(firstdevneighbours(i,4*(j-1)+3),2),lattice(firstdevneighbours(i,4*(j-1)+3),3),'Marker','diamond');
                plot3(lattice(firstdevneighbours(i,4*(j-1)+4),1),lattice(firstdevneighbours(i,4*(j-1)+4),2),lattice(firstdevneighbours(i,4*(j-1)+4),3),'Marker','diamond');
            case 3%？
                plot3(lattice(firstdevneighbours(i,4*(j-1)+2),1),lattice(firstdevneighbours(i,4*(j-1)+2),2),lattice(firstdevneighbours(i,4*(j-1)+2),3),'Marker','pentagram');
                plot3(lattice(firstdevneighbours(i,4*(j-1)+3),1),lattice(firstdevneighbours(i,4*(j-1)+3),2),lattice(firstdevneighbours(i,4*(j-1)+3),3),'Marker','pentagram');
                plot3(lattice(firstdevneighbours(i,4*(j-1)+4),1),lattice(firstdevneighbours(i,4*(j-1)+4),2),lattice(firstdevneighbours(i,4*(j-1)+4),3),'Marker','pentagram');        
        end
    end
end



%% covariantbase
xyz=reshape(lattice,[Nr,Nt,Nz,9]);

mxds=1;
covariantbase = computecovariantbase3D(N,deltaq,lattice,firstdevneighbours);
cobase=reshape(covariantbase,[Nr,Nt,Nz,9]);
figure;
for k=1:Nz
surf(xyz(:,:,k,7),xyz(:,:,k,8),xyz(:,:,k,9),zeros(Nr,Nt)); shading faceted; hold on;
quiver3(...
	downsample(xyz(:,:,k,7),mxds),...
	downsample(xyz(:,:,k,8),mxds),...
	downsample(xyz(:,:,k,9),mxds),...
	downsample(cobase(:,:,k,1), mxds),...
	downsample(cobase(:,:,k,2), mxds),...
	downsample(cobase(:,:,k,3), mxds));
end
title 'N_ds';
% Create Nhat.eps
set(gcf, 'PaperPositionMode', 'Manual');
set(gcf, 'PaperPosition', [0 0 3.0 3.0])
%print -depsc figures/Nd_s.eps
figure;
for k=1:Nz
surf(xyz(:,:,k,7),xyz(:,:,k,8),xyz(:,:,k,9),zeros(Nr,Nt)); shading faceted; hold on;
quiver3(...
	downsample(xyz(:,:,k,7),mxds),...
	downsample(xyz(:,:,k,8),mxds),...
	downsample(xyz(:,:,k,9),mxds),...
	downsample(cobase(:,:,k,4), mxds),...
	downsample(cobase(:,:,k,5), mxds),...
	downsample(cobase(:,:,k,6), mxds));
end
title 'N_t';
% Create N_t.eps
set(gcf, 'PaperPositionMode', 'Manual');
set(gcf, 'PaperPosition', [0 0 3.0 3.0])
%print -depsc figures/N_t.eps
figure;
for k=1:Nz
surf(xyz(:,:,k,7),xyz(:,:,k,8),xyz(:,:,k,9),zeros(Nr,Nt)); shading faceted; hold on;
quiver3(...
	downsample(xyz(:,:,k,7),mxds),...
	downsample(xyz(:,:,k,8),mxds),...
	downsample(xyz(:,:,k,9),mxds),...
	downsample(cobase(:,:,k,7), mxds),...
	downsample(cobase(:,:,k,8), mxds),...
	downsample(cobase(:,:,k,9), mxds));
end
title 'Nhat';
% Create Nhat.eps
set(gcf, 'PaperPositionMode', 'Manual');
set(gcf, 'PaperPosition', [0 0 3.0 3.0])
%print -depsc figures/Nhat.eps


%% metriccoefficients 
[metriccoefficients,g,sqrtg] = computemetriccoefficients3D(covariantbase);
metric=reshape(metriccoefficients,[Nr,Nt,Nz,6]);
g_name={'g_{11}','g_{22}','g_{33}','g_{12}g_{21}','g_{13}g_{31}','g_{23}g_{32}'}
% save_name={'g11','g22','g33','g12g21','g13g31','g23g32'}

for kk=1:6
h=figure;
axes1 = axes('Parent',h);
for k=1:Nz
surf(xyz(:,:,k,7),xyz(:,:,k,8),xyz(:,:,k,9),metric(:,:,k,kk));hold on;
end
colorbar('peer',axes1);
title(g_name{kk})
end

%%
contravariantbase = computecontravariantbase3D(covariantbase,sqrtg);

[reciprocalmetriccoefficients,g,sqrtg] = computereciprocalmetriccoefficients3D(contravariantbase);

firstChristoffelsymbol = computefirstChristoffelsymbol3D(N,deltaq,covariantbase,firstdevneighbours);

secondChristoffelsymbol = computesecondChristoffelsymbol3D(N,deltaq,covariantbase,contravariantbase,firstdevneighbours);
Christoffelsymbol=reshape(secondChristoffelsymbol,[Nr,Nt,Nz,27]);
Gamma_name={'\Gamma_{rr}^r',            '\Gamma_{r\theta}^r',           '\Gamma_{rz}^r',...
            '\Gamma_{\theta r}^r',      '\Gamma_{\theta \theta}^r',     '\Gamma_{\theta z}^r',...
            '\Gamma_{zr}^r',            '\Gamma_{z\theta}^r',           '\Gamma_{zz}^r',...
            '\Gamma_{rr}^\theta',       '\Gamma_{r\theta}^\theta',      '\Gamma_{rz}^\theta',...
            '\Gamma_{\theta r}^\theta', '\Gamma_{\theta \theta}^\theta', '\Gamma_{\theta z}^\theta',...
            '\Gamma_{zr}^\theta',       '\Gamma_{z\theta}^\theta',       '\Gamma_{zz}^\theta',...
            '\Gamma_{rr}^z',            '\Gamma_{r\theta}^z',            '\Gamma_{rz}^z',...
            '\Gamma_{\theta r}^z',      '\Gamma_{\theta \theta}^z',      '\Gamma_{\theta z}^z',...
            '\Gamma_{zr}^z',            '\Gamma_{z\theta}^z',            '\Gamma_{zz}^z',...
            }
for kk=1:27
h=figure;
axes1 = axes('Parent',h);
for k=1:Nz
surf(xyz(:,:,k,7),xyz(:,:,k,8),xyz(:,:,k,9),Christoffelsymbol(:,:,k,kk));hold on;
end
colorbar('peer',axes1);
title(Gamma_name{kk})
end

Riemanntensor = computeRiemanntensor3D(N,deltaq,secondChristoffelsymbol,metriccoefficients,firstdevneighbours);
max(Riemanntensor)
Riccitensor = computeRiccitensor3D(Riemanntensor,reciprocalmetriccoefficients);

R = computeRiccicurvature3D(Riccitensor,reciprocalmetriccoefficients);
R=reshape(R,[Nr,Nt,Nz])

h=figure;
axes1 = axes('Parent',h);
for k=1:Nz
surf(xyz(:,:,k,7),xyz(:,:,k,8),xyz(:,:,k,9),R(:,:,k));hold on;
end
colorbar('peer',axes1);
title(Gamma_name{kk})

