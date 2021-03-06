%Main-Boundary
%   ref:https://github.com/Jiaqi-knight/NonlinearWaveguideCoding
%   Email:Jiaqi_Wang@sjtu.edu.cn
%   Copyright 2020, SJTU.
%-----------------------------------------------------------------%

clc
clear
close all
subfunction_path1='.\subfunction1';
addpath(genpath(subfunction_path1));
load('Data_m3_n1_a2_b6.mat');


%% #######Boudnary########%
%Infinite Uniform Duct Outlet
%Case1: Torsion Free Outlet

Bdry_a.N=Fun2_a.N(:,:,end,:);
Bdry_a_b.N=Fun2_a_b.N(:,:,end,:,:);
Bdry_b.N=Fun2_b.N(:,:,end,:);

Bdry_a.N_inv=Fun2_a.N_inv(:,:,end,:);
Bdry_a_b.N_inv=Fun2_a_b.N_inv(:,:,end,:,:);
Bdry_b.N_inv=Fun2_b.N_inv(:,:,end,:);

Bdry_a.NM=multiprod(Fun2_a.N(:,:,end,:),Fun2_a.M(:,:,end,:),[1,2]);
Bdry_a_b.NM=multiprod(Fun2_a_b.N(:,:,end,:,:),Fun2_a_b.M(:,:,end,:,:),[1,2]);
Bdry_b.NM=multiprod(Fun2_b.N(:,:,end,:),Fun2_b.M(:,:,end,:),[1,2]);

Bdry3_ab.A=Fun3_ab.A(:,:,:,end,:,:);
Bdry3_ab.B=Fun3_ab.B(:,:,:,end,:,:);
Bdry3_ab.C=Fun3_ab.C(:,:,:,end,:,:);

Bdry3_a_b.I=Fun3_a_b.I(:,:,:,end,:,:);
Bdry3_b.I=Fun3_b.I(:,:,:,end,:,:);



for ka=1:length(a)
    Bdry_a.Y(:,:,1,ka) = sqrt(-1)*Bdry_a.N_inv(:,:,1,ka)*sqrtm(Bdry_a.NM(:,:,1,ka));
    [Bdry_a.V(:,:,1,ka),Bdry_a.Lambda(:,:,1,ka)]=eig(sqrt(-1)*sqrtm(Bdry_a.NM(:,:,1,ka)));
    [Bdry_a.W(:,:,1,ka),temp]=eig(Bdry_a.Y(:,:,1,ka)*Bdry_a.N(:,:,1,ka));
    Bdry_a.V_inv(:,:,1,ka)=inv(Bdry_a.V(:,:,1,ka));
    Bdry_a.W_inv(:,:,1,ka)=inv(Bdry_a.W(:,:,1,ka));
    
end
for kb=1:length(b)
    Bdry_b.Y(:,:,1,kb) = sqrt(-1)*Bdry_b.N_inv(:,:,1,kb)*sqrtm(Bdry_b.NM(:,:,1,kb));
    [Bdry_b.V(:,:,1,kb),Bdry_b.Lambda(:,:,1,kb)]=eig(sqrt(-1)*sqrtm(Bdry_b.NM(:,:,1,kb)));
    [Bdry_b.W(:,:,1,kb),temp]=eig(Bdry_b.Y(:,:,1,kb)*Bdry_b.N(:,:,1,kb));
    Bdry_b.V_inv(:,:,1,kb)=inv(Bdry_b.V(:,:,1,kb));
    Bdry_b.W_inv(:,:,1,kb)=inv(Bdry_b.W(:,:,1,kb));
end
temp1=(NaN+NaN*sqrt(-1))*ones(size(Bdry_a_b.N(:,:,1,1,1)));
for kb=1:length(a)
    for kb=1:length(b)
        if a(ka)-b(kb)==0
            Bdry_a_b.Y(:,:,1,kb,ka)=temp1;
            Bdry_a_b.V(:,:,1,kb,ka)=temp1;
            Bdry_a_b.Lambda(:,:,1,kb,ka)=temp1;
            Bdry_a_b.W(:,:,1,kb,ka)=temp1;
            Bdry_a_b.V_inv(:,:,1,kb,ka)=temp1;
            Bdry_a_b.W_inv(:,:,1,kb,ka)=temp1;
        else
            Bdry_a_b.Y(:,:,1,kb,ka) = sqrt(-1)*Bdry_a_b.N_inv(:,:,1,kb,ka)*sqrtm(Bdry_a_b.NM(:,:,1,kb,ka));
            [Bdry_a_b.V(:,:,1,kb,ka),Bdry_a_b.Lambda(:,:,1,kb,ka)]=eig(sqrt(-1)*sqrtm(Bdry_a_b.NM(:,:,1,kb,ka)));
            [Bdry_a_b.W(:,:,1,kb,ka),temp]=eig(Bdry_a_b.Y(:,:,1,kb,ka)*Bdry_a_b.N(:,:,1,kb,ka));
            Bdry_a_b.V_inv(:,:,1,kb,ka)=inv(Bdry_a_b.V(:,:,1,kb,ka));
            Bdry_a_b.W_inv(:,:,1,kb,ka)=inv(Bdry_a_b.W(:,:,1,kb,ka));
        end
    end
end

Bdry_a.Y_minus=-Bdry_a.Y;


Bdry3_a_b.V=permute(Bdry_a_b.V,[1,2,6,3,4,5]);
Bdry3_b.V=permute(bsxfun(@times,Bdry_b.V,reshape(ones(size(a)),1,1,1,1,length(a))),[6,1,2,3,4,5]);
Bdry3_a_b.V_inv=permute(Bdry_a_b.V_inv,[1,2,6,3,4,5]);
Bdry3_b.V_inv=permute(bsxfun(@times,Bdry_b.V_inv,reshape(ones(size(a)),1,1,1,1,length(a))),[6,1,2,3,4,5]);
Bdry3_a_b.YV=permute(multiprod(Bdry_a_b.Y,Bdry_a_b.V,[1,2]),[1,2,6,3,4,5]);
Bdry3_b.YV=permute(bsxfun(@times,multiprod(Bdry_b.Y,Bdry_b.V,[1,2]),reshape(ones(size(a)),1,1,1,1,length(a))),[6,1,2,3,4,5]);
Bdry3_a.W=permute(bsxfun(@times,Bdry_a.W,reshape(ones(size(b)),1,1,1,1,length(b))),[1,2,6,3,5,4]);
Bdry3_a.W_inv=permute(bsxfun(@times,Bdry_a.W_inv,reshape(ones(size(b)),1,1,1,1,length(b))),[1,2,6,3,5,4]);
Bdry3_a.Y=permute(bsxfun(@times,Bdry_a.Y,reshape(ones(size(b)),1,1,1,1,length(b))),[1,2,6,3,5,4]);


Bdry3_ab.II=ones(size(Bdry3_ab.A));

Bdry3_a.Lambda=permute(bsxfun(@times,Bdry_a.Lambda,reshape(ones(size(b)),1,1,1,1,length(b))),[1,2,6,3,5,4]);
Bdry3_a_b.Lambda=permute(Bdry_a_b.Lambda,[1,2,6,3,4,5]);
Bdry3_b.Lambda=permute(bsxfun(@times,Bdry_b.Lambda,reshape(ones(size(a)),1,1,1,1,length(a))),[6,1,2,3,4,5]);

Bdry3.Lambda_alpha_a=multiprod(Bdry3_a.Lambda,multiprod(multiprod(Bdry3_ab.II,Bdry3_a_b.I,[1,2]),Bdry3_b.I,[2,3]),[1,2]);
Bdry3.Lambda_beta_a_b=multiprod(multiprod(Bdry3_ab.II,Bdry3_a_b.Lambda,[1,2]),Bdry3_b.I,[2,3]);
Bdry3.Lambda_gamma_b=multiprod(multiprod(Bdry3_ab.II,Bdry3_a_b.I,[1,2]),Bdry3_b.Lambda,[2,3]);



Bdry3_ab.Yp=(multiprod(Bdry3_a.W_inv,multiprod(multiprod(Bdry3_ab.A,Bdry3_a_b.YV,[1,2]),Bdry3_b.YV,[2,3]),[1,2])...
    +multiprod(Bdry3_a.W_inv,multiprod(multiprod(Bdry3_ab.B,Bdry3_a_b.V,[1,2]),Bdry3_b.V,[2,3]),[1,2])...
    -multiprod(multiprod(Bdry3_a.W_inv,Bdry3_a.Y,[1,2]),multiprod(multiprod(Bdry3_ab.C,Bdry3_a_b.YV,[1,2]),Bdry3_b.V,[2,3]),[1,2]))...
    ./(Bdry3.Lambda_alpha_a+Bdry3.Lambda_beta_a_b+Bdry3.Lambda_gamma_b);

Bdry3_ab.YY=multiprod(Bdry3_a.W,multiprod(multiprod(Bdry3_ab.Yp,Bdry3_a_b.V_inv,[1,2]),Bdry3_b.V_inv,[2,3]),[1,2]);
Bdry3_ab.YY_minus=-Bdry3_ab.YY;

%Warning:a-b!=0, be NaN, need to be deleted.


