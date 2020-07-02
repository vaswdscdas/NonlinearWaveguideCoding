# Autogenerated with SMOP 
from smop.core import *
# 

    
@function
def export_abaqus(mesh=None,elementtype=None,filename=None,*args,**kwargs):
    varargin = export_abaqus.varargin
    nargin = export_abaqus.nargin

    ##
#        Project: Fluid - structure interaction on deformable surfaces
#         Author: Luca Di Stasio
#    Institution: ETH Zrich
#                 Institute for Building Materials
# Research group: Computational Physics for Engineering Materials
#        Version: 0.1
#  Creation date: April 1st, 2014
#    Last update: April 1st, 2014
    
    #    Description: 
#          Input: 
#         Output:
    
    ##
    
    c=copy(clock)
    #-------- write all nodes and elements
    
    nodesfilename=strcat(cat(num2str(c[1]),'_',num2str(c[2]),'_',num2str(c[3]),'_',filename,'_nodedata_completemesh','.inp'))
    nodesfid=fopen(nodesfilename,'w')
    fprintf(nodesfid,strcat(cat('**Mesh generated by Luca Di Stasio, Computational Physics of Engineering Materials, Institute for Building Materials, ETH Zuerich on ',num2str(c[3]),'-',num2str(c[2]),'-',num2str(c[1]),'\\n')))
    fprintf(nodesfid,'*NODE, NSET=allnodes\\n')
    for i in arange(1,mesh.totN).reshape(-1):
        fprintf(nodesfid,'%d, %12.8f, %12.8f, %12.8f\\n',mesh.nodes.id(i),mesh.nodes.meshcoordinates(1,i),mesh.nodes.meshcoordinates(2,i),mesh.nodes.meshcoordinates(3,i))
    
    fclose(nodesfid)
    elementsfilename=strcat(cat(num2str(c[1]),'_',num2str(c[2]),'_',num2str(c[3]),'_',filename,'_elementdata_completemesh','.inp'))
    elementsfid=fopen(elementsfilename,'w')
    fprintf(elementsfid,strcat(cat('**Mesh generated by Luca Di Stasio, Computational Physics of Engineering Materials, Institute for Building Materials, ETH Zuerich on ',num2str(c[3]),'-',num2str(c[2]),'-',num2str(c[1]),'\\n')))
    fprintf(elementsfid,strcat(cat('*ELEMENT, TYPE=',elementtype,', ELSET=allelements\\n')))
    if 1 == mesh.D:
        if mesh.edgeflag:
            for i in arange(1,mesh.totE).reshape(-1):
                fprintf(elementsfid,'%d, %d, %d\\n',mesh.edges.id(i),mesh.edges.nodes(1,i),mesh.edges.nodes(2,i))
        else:
            disp('Error: Abaqus is an element-based FEM solver: elements must be defined.')
    else:
        if 2 == mesh.D:
            if mesh.faceflag:
                for i in arange(1,mesh.totF).reshape(-1):
                    fprintf(elementsfid,'%d, %d, %d, %d, %d\\n',mesh.faces.id(i),mesh.faces.nodes(1,i),mesh.faces.nodes(2,i),mesh.faces.nodes(3,i),mesh.faces.nodes(4,i))
            else:
                disp('Error: Abaqus is an element-based FEM solver: elements must be defined.')
        else:
            if 3 == mesh.D:
                if mesh.cellflag:
                    for i in arange(1,mesh.totC).reshape(-1):
                        fprintf(elementsfid,'%d, %d, %d, %d, %d, %d, %d, %d, %d\\n',mesh.cells.id(i),mesh.cells.nodes(1,i),mesh.cells.nodes(2,i),mesh.cells.nodes(3,i),mesh.cells.nodes(4,i),mesh.cells.nodes(5,i),mesh.cells.nodes(6,i),mesh.cells.nodes(7,i),mesh.cells.nodes(8,i))
                else:
                    disp('Error: Abaqus is an element-based FEM solver: elements must be defined.')
    
    fclose(elementsfid)
    #-------- write nodes and elements belonging to boundaries
    
    #-------- write nodes and elements belonging to other sets