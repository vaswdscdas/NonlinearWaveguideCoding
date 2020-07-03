# Autogenerated with SMOP 
from smop.core import *
# 

    
@function
def normaldistmthmoment(m=None,*args,**kwargs):
    varargin = normaldistmthmoment.varargin
    nargin = normaldistmthmoment.nargin

    ##
#        Project: Fluid - structure interaction on deformable surfaces
#         Author: Luca Di Stasio
#    Institution: ETH Zrich
#                 Institute for Building Materials
# Research group: Computational Physics for Engineering Materials
#        Version: 0.1
#  Creation date: May 27th, 2014
#    Last update: May 27th, 2014
    
    #    Description: 
#          Input: 
#         Output:
    
    ##
    
    n=floor(m / 2)
    M=zeros(n + 1,3)
    if dot(2,n) == m:
        for i in arange(0,n).reshape(-1):
            M[i + 1,1]=dot(binomialfactor(dot(2,n),dot(2,i)),normaldistcoeff(dot(2,n) - dot(2,i)))
            M[i + 1,2]=dot(2,n) - dot(2,i)
            M[i + 1,3]=dot(2,i)
    else:
        for i in arange(0,n).reshape(-1):
            M[i + 1,1]=dot(binomialfactor(dot(2,n) + 1,dot(2,i) + 1),normaldistcoeff((dot(2,n) + 1) - (dot(2,i) + 1)))
            M[i + 1,2]=(dot(2,n) + 1) - (dot(2,i) + 1)
            M[i + 1,3]=dot(2,i) + 1
    
    return M