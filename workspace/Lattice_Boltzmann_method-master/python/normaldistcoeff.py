# Autogenerated with SMOP 
from smop.core import *
# 

    
@function
def normaldistcoeff(exp=None,*args,**kwargs):
    varargin = normaldistcoeff.varargin
    nargin = normaldistcoeff.nargin

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
    
    if 0 == exp:
        alpha=1
    else:
        if 2 == exp:
            alpha=1
        else:
            if 4 == exp:
                alpha=3
            else:
                if 6 == exp:
                    alpha=15
                else:
                    if 8 == exp:
                        alpha=105
                    else:
                        if 10 == exp:
                            alpha=945
                        else:
                            if 12 == exp:
                                alpha=10395
                            else:
                                if 14 == exp:
                                    alpha=135135
                                else:
                                    if 16 == exp:
                                        alpha=2027025
                                    else:
                                        if 18 == exp:
                                            alpha=34459425
                                        else:
                                            if 20 == exp:
                                                alpha=654729075
                                            else:
                                                if 22 == exp:
                                                    alpha=13749310575
                                                else:
                                                    if 24 == exp:
                                                        alpha=316234143225
                                                    else:
                                                        if 26 == exp:
                                                            alpha=7905853580625
    
    return alpha