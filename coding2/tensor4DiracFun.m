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

m=-2:2;u=1:3;
delta_mn=eye(length(m));
delta_m0n=fliplr(delta_mn);
delta_uv=eye(length(u));
delta_u0v=fliplr(delta_uv);

%kron_fliplr the second line in order to form I matrix
delta_mn_u0v=kron_fliplr(delta_mn,delta_u0v)
delta_m0n_uv=kron_fliplr(delta_m0n,delta_uv); 


