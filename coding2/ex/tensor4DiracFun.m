%-----------------------------------------------------------------%
%this Code is to prove the tensor calculataion with Dirac's funcrion
%reconstrcut: \delta_{m,-n}\delta_{u,v}=[I] for easy our model
%provided by Jiaqi, email:Jiaqi_Wang@sjtu.edu.cn
%2020-03-06
%-----------------------------------------------------------------%

clc
clear
close all
subfunction_path1='.\tensor_toolbox-master'
addpath(genpath(subfunction_path1));
subfunction_path2='.\chebfun-master'
addpath(genpath(subfunction_path2));

%Geometry
s = 0:0.01:4;
h=0.1*exp(linspace(0,1.5,length(s)));
kappa=(2/3)./h;tau=0.2./h;
a=kappa./(kappa.^2+tau.^2);
b=tau./(kappa.^2+tau.^2);
sw=sqrt(kappa.^2+tau.^2).*s;


n=1;
for k=1:n
x(k,:) = a.*sin(sw+2*pi*k/n);
y(k,:) = a.*cos(sw+2*pi*k/n);
z(k,:) = b.*sw;
end
% figure(1)
%  
% xlabel('x'); ylabel('y'); title('Circula helix');
% axis equal

figure
for k=1:n
tubeplot(x(k,:),y(k,:),z(k,:),h,s,50);hold on;
end
plot3(x, y, z);
daspect([1,1,1]); camlight;


% %kron_fliplr the second line in order to form I matrix
% delta_mn_u0v=kron_fliplr(delta_mn,delta_u0v);
% delta_m0n_uv=kron_fliplr(delta_m0n,delta_uv); 



%we began to consrtruct 4D tensor
m=5;n=4;

m0=0:m;
for k=1:length(m0)
temp1=roots(diff(chebfun(@(t) besselj(m0(k),t),[0,300]))+0.00001);
temp2= besselj(m0(k),temp1);
jmn(:,k)=temp1(1:n);
BesselValue(:,k)=temp2(1:n);
end
jmn_pm=[fliplr(jmn) jmn(:,2:end)];
BesselValue_pm=[fliplr(repmat((-1).^m0,n,1).*BesselValue) BesselValue(:,2:end)];
h=1;
m1=-m:m;
Cmn1=(i).^m1./(sqrt(pi)*h*BesselValue_pm.*sqrt(1-m1.^2./jmn_pm.^2));
% m2=fliplr(m1);
% Cmn2=fliplr(Cmn1);

% we have fliplr the y-axis in oder to form the I matrix, which is better
% for model calculatation
for km1=1:length(m1)
for km2=1:length(m1)
for kn1=1:n
    for kn2=1:n
        delta_X_r(kn1+n*(km1-1),kn2+n*(km2-1))=...
            sum(chebfun(@(r) besselj(m1(end-km1+1),jmn_pm(kn1,end-km1+1)*r)...
            *besselj(m1(km2),jmn_pm(kn2,km2)*r)*r*Cmn1(kn1,end-km1+1)*Cmn1(kn2,km2),[0,1]));
    end
end
end
end
for km1=1:length(m1)
for km2=1:length(m1)
for kn1=1:n
    for kn2=1:n
        delta_X_r2(kn1+n*(km1-1),kn2+n*(km2-1))=...
            sum(chebfun(@(r) besselj(m1(end-km1+1),jmn_pm(kn1,end-km1+1)*r^2)...
            *besselj(m1(km2),jmn_pm(kn2,km2)*r)*r*Cmn1(kn1,end-km1+1)*Cmn1(kn2,km2),[0,1]));
    end
end
end
end
delta_Theta=2*pi*kron(eye(length(m1)),ones(n));
delta_Theta_cos_phi=pi*(kron(diag(ones(length(m1)-1,1),-1),ones(n))+kron(diag(ones(length(m1)-1,1),+1),ones(n)));
delta_Theta_sin_phi=-sqrt(-1)*pi*(kron(diag(ones(length(m1)-1,1),-1),ones(n))-kron(diag(ones(length(m1)-1,1),+1),ones(n)));
delta_Theta_pt=2*pi*sqrt(-1)*m*kron(eye(length(m1)),ones(n));


psi_alpha_beta_r=delta_X_r.*delta_Theta;
psi_alpha_beta_rcos_phi=delta_X_r.*delta_Theta_cos_phi;
psi_alpha_beta_r2cos_phi=delta_X_r2.*delta_Theta_cos_phi;
psi_alpha_beta_r2sin_phi=delta_X_r2.*delta_Theta_sin_phi;
psi_pt_alpha_beta_r=delta_X_r.*delta_Theta_pt;


figure(1);%psi_alpha_beta_r
subplot(2,3,3);image(real(delta_X_r),'CDataMapping','scaled');grid on;axis equal;axis off;title('X_{\alpha\beta}[r]')
subplot(2,3,2);image(real(delta_Theta),'CDataMapping','scaled');grid on;axis equal;axis off;title('\Theta_{\alpha\beta}')
subplot(2,3,1);image(real(psi_alpha_beta_r),'CDataMapping','scaled');grid on;axis equal;axis off;title('real(\Psi_{\alpha\beta}[r])=')
subplot(2,3,6);image(imag(delta_X_r),'CDataMapping','scaled');grid on;axis equal;axis off;title('X_{\alpha\beta}[r]')
subplot(2,3,5);image(imag(delta_Theta),'CDataMapping','scaled');grid on;axis equal;axis off;title('\Theta_{\alpha\beta}')
subplot(2,3,4);image(imag(psi_alpha_beta_r),'CDataMapping','scaled');grid on;axis equal;axis off;title('imag(\Psi_{\alpha\beta}[r])=')

figure(2);
subplot(2,3,3);image(real(delta_X_r),'CDataMapping','scaled');grid on;axis equal;axis off;title('X_{\alpha\beta}[r]')
subplot(2,3,2);image(real(delta_Theta_cos_phi),'CDataMapping','scaled');grid on;axis equal;axis off;title('\Theta_{\alpha\beta}[cos\phi]')
subplot(2,3,1);image(real(psi_alpha_beta_rcos_phi),'CDataMapping','scaled');grid on;axis equal;axis off;title('real(\Psi_{\alpha\beta}[rcos\phi])=')
subplot(2,3,6);image(imag(delta_X_r),'CDataMapping','scaled');grid on;axis equal;axis off;title('X_{\alpha\beta}[r]')
subplot(2,3,5);image(imag(delta_Theta_cos_phi),'CDataMapping','scaled');grid on;axis equal;axis off;title('\Theta_{\alpha\beta}[cos\phi]')
subplot(2,3,4);image(imag(psi_alpha_beta_rcos_phi),'CDataMapping','scaled');grid on;axis equal;axis off;title('imag(\Psi_{\alpha\beta}[rcos\phi])=')

figure(3);
subplot(2,3,3);image(real(delta_X_r2),'CDataMapping','scaled');grid on;axis equal;axis off;title('X_{\alpha\beta}[r^2]')
subplot(2,3,2);image(real(delta_Theta_cos_phi),'CDataMapping','scaled');grid on;axis equal;axis off;title('\Theta_{\alpha\beta}[cos\phi]')
subplot(2,3,1);image(real(psi_alpha_beta_r2cos_phi),'CDataMapping','scaled');grid on;axis equal;axis off;title('real(\Psi_{\alpha\beta}[r^2cos\phi])=')
subplot(2,3,6);image(imag(delta_X_r2),'CDataMapping','scaled');grid on;axis equal;axis off;title('X_{\alpha\beta}[r^2]')
subplot(2,3,5);image(imag(delta_Theta_cos_phi),'CDataMapping','scaled');grid on;axis equal;axis off;title('\Theta_{\alpha\beta}[cos\phi]')
subplot(2,3,4);image(imag(psi_alpha_beta_r2cos_phi),'CDataMapping','scaled');grid on;axis equal;axis off;title('imag(\Psi_{\alpha\beta}[r^2cos\phi])=')

figure(4);
subplot(2,3,3);image(real(delta_X_r2),'CDataMapping','scaled');grid on;axis equal;axis off;title('X_{\alpha\beta}[r^2]')
subplot(2,3,2);image(real(delta_Theta_sin_phi),'CDataMapping','scaled');grid on;axis equal;axis off;title('\Theta_{\alpha\beta}[sin\phi]')
subplot(2,3,1);image(real(psi_alpha_beta_r2cos_phi),'CDataMapping','scaled');grid on;axis equal;axis off;title('real(\Psi_{\alpha\beta}[r^2sin\phi])=')
subplot(2,3,6);image(imag(delta_X_r2),'CDataMapping','scaled');grid on;axis equal;axis off;title('X_{\alpha\beta}[r^2]')
subplot(2,3,5);image(imag(delta_Theta_sin_phi),'CDataMapping','scaled');grid on;axis equal;axis off;title('\Theta_{\alpha\beta}[sin\phi]')
subplot(2,3,4);image(imag(psi_alpha_beta_r2cos_phi),'CDataMapping','scaled');grid on;axis equal;axis off;title('imag(\Psi_{\alpha\beta}[r^2sin\phi])=')

figure(5);
subplot(2,3,3);image(real(delta_X_r),'CDataMapping','scaled');grid on;axis equal;axis off;title('X_{\alpha\beta}[r]')
subplot(2,3,2);image(real(delta_Theta_pt),'CDataMapping','scaled');grid on;axis equal;axis off;title('\Theta_{(\alpha)\beta}')
subplot(2,3,1);image(real(psi_pt_alpha_beta_r),'CDataMapping','scaled');grid on;axis equal;axis off;title('real(\Psi_{(\alpha)\beta}[r])=')
subplot(2,3,6);image(imag(delta_X_r),'CDataMapping','scaled');grid on;axis equal;axis off;title('X_{\alpha\beta}[r]')
subplot(2,3,5);image(imag(delta_Theta_pt),'CDataMapping','scaled');grid on;axis equal;axis off;title('\Theta_{(\alpha)\beta}')
subplot(2,3,4);image(imag(psi_pt_alpha_beta_r),'CDataMapping','scaled');grid on;axis equal;axis off;title('imag(\Psi_{(\alpha)\beta}[r])=')


%continue to construct other psi-fun
