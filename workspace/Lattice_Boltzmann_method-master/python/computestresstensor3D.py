# Autogenerated with SMOP 
from smop.core import *
# 

    
@function
def computestresstensor3D(N=None,Q=None,feq=None,f=None,tau=None,scheme=None,*args,**kwargs):
    varargin = computestresstensor3D.varargin
    nargin = computestresstensor3D.nargin

    ##
#        Project: Fluid - structure interaction on deformable surfaces
#         Author: Luca Di Stasio
#    Institution: ETH Zrich
#                 Institute for Building Materials
# Research group: Computational Physics for Engineering Materials
#        Version: 0.1
#  Creation date: May 30th, 2014
#    Last update: June 24th, 2014
    
    #    Description: 
#          Input: 
#         Output:
    
    ##
    
    sigma=zeros(N,6)
    for i in arange(1,Q).reshape(-1):
        sigma[:,1]=sigma[:,1] + dot(dot((f[:,i] - feq[:,i]),scheme[i,1]),scheme[i,1])
        sigma[:,2]=sigma[:,2] + dot(dot((f[:,i] - feq[:,i]),scheme[i,2]),scheme[i,2])
        sigma[:,3]=sigma[:,3] + dot(dot((f[:,i] - feq[:,i]),scheme[i,3]),scheme[i,3])
        sigma[:,4]=sigma[:,4] + dot(dot((f[:,i] - feq[:,i]),scheme[i,1]),scheme[i,2])
        sigma[:,5]=sigma[:,5] + dot(dot((f[:,i] - feq[:,i]),scheme[i,1]),scheme[i,3])
        sigma[:,6]=sigma[:,6] + dot(dot((f[:,i] - feq[:,i]),scheme[i,2]),scheme[i,3])
    
    sigma[:,1]=multiply(- (1 - 0.5 / tau[:,1]),sigma[:,1])
    sigma[:,2]=multiply(- (1 - 0.5 / tau[:,1]),sigma[:,2])
    sigma[:,3]=multiply(- (1 - 0.5 / tau[:,1]),sigma[:,3])
    sigma[:,4]=multiply(- (1 - 0.5 / tau[:,1]),sigma[:,4])
    sigma[:,5]=multiply(- (1 - 0.5 / tau[:,1]),sigma[:,5])
    sigma[:,6]=multiply(- (1 - 0.5 / tau[:,1]),sigma[:,6])
    return sigma