function[section]=homogeneousSphericalDilation3D(section,f)
%%
%==============================================================================
% Copyright (c) 2016 Universit� de Lorraine & Lule� tekniska universitet
% Author: Luca Di Stasio <luca.distasio@gmail.com>
%                        <luca.distasio@ingpec.eu>
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
% 
% 
% Redistributions of source code must retain the above copyright
% notice, this list of conditions and the following disclaimer.
% Redistributions in binary form must reproduce the above copyright
% notice, this list of conditions and the following disclaimer in
% the documentation and/or other materials provided with the distribution
% Neither the name of the Universit� de Lorraine or Lule� tekniska universitet
% nor the names of its contributors may be used to endorse or promote products
% derived from this software without specific prior written permission.
% 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% POSSIBILITY OF SUCH DAMAGE.
%==============================================================================
%
%  DESCRIPTION
%  
%  A function to generate a homogeneous dilation of a section with a generic
%  curvilinear boundary (output is the new dilated boundary)
%
%  f is the multiplicative factor for the dilation
%
%%

if ~isfield(section,'boundingSphere')
    section = computeBoundingSphere(section);
end

xC = section.boundingSphere.center(1);
yC = section.boundingSphere.center(2);
zC = section.boundingSphere.center(2);

section.dilatedBoundary.c1 = [xC+f*cos(atan2(section.c1(2)-yC,section.c1(1)-xC))*cos(atan2(section.c1(3)-zC,sqrt((section.c1(2)-yC)^2+(section.c1(1)-xC)^2)))*computeDistance3D(section.c1,section.boundingCircle.center) ...
                              yC+f*sin(atan2(section.c1(2)-yC,section.c1(1)-xC))*cos(atan2(section.c1(3)-zC,sqrt((section.c1(2)-yC)^2+(section.c1(1)-xC)^2)))*computeDistance3D(section.c1,section.boundingCircle.center) ...
                              zC+f*sin(atan2(section.c1(3)-zC,sqrt((section.c1(2)-yC)^2+(section.c1(1)-xC)^2)))*computeDistance3D(section.c1,section.boundingCircle.center)];
section.dilatedBoundary.c2 = [xC+f*cos(atan2(section.c2(2)-yC,section.c2(1)-xC))*cos(atan2(section.c2(3)-zC,sqrt((section.c2(2)-yC)^2+(section.c2(1)-xC)^2)))*computeDistance3D(section.c2,section.boundingCircle.center) ...
                              yC+f*sin(atan2(section.c2(2)-yC,section.c2(1)-xC))*cos(atan2(section.c2(3)-zC,sqrt((section.c2(2)-yC)^2+(section.c2(1)-xC)^2)))*computeDistance3D(section.c2,section.boundingCircle.center) ...
                              zC+f*sin(atan2(section.c2(3)-zC,sqrt((section.c2(2)-yC)^2+(section.c2(1)-xC)^2)))*computeDistance3D(section.c2,section.boundingCircle.center)];
section.dilatedBoundary.c3 = [xC+f*cos(atan2(section.c3(2)-yC,section.c3(1)-xC))*cos(atan2(section.c3(3)-zC,sqrt((section.c3(2)-yC)^2+(section.c3(1)-xC)^2)))*computeDistance3D(section.c3,section.boundingCircle.center) ...
                              yC+f*sin(atan2(section.c3(2)-yC,section.c3(1)-xC))*cos(atan2(section.c3(3)-zC,sqrt((section.c3(2)-yC)^2+(section.c3(1)-xC)^2)))*computeDistance3D(section.c3,section.boundingCircle.center) ...
                              zC+f*sin(atan2(section.c3(3)-zC,sqrt((section.c3(2)-yC)^2+(section.c3(1)-xC)^2)))*computeDistance3D(section.c3,section.boundingCircle.center)];
section.dilatedBoundary.c4 = [xC+f*cos(atan2(section.c4(2)-yC,section.c4(1)-xC))*cos(atan2(section.c4(3)-zC,sqrt((section.c4(2)-yC)^2+(section.c4(1)-xC)^2)))*computeDistance3D(section.c4,section.boundingCircle.center) ...
                              yC+f*sin(atan2(section.c4(2)-yC,section.c4(1)-xC))*cos(atan2(section.c4(3)-zC,sqrt((section.c4(2)-yC)^2+(section.c4(1)-xC)^2)))*computeDistance3D(section.c4,section.boundingCircle.center) ...
                              zC+f*sin(atan2(section.c4(3)-zC,sqrt((section.c4(2)-yC)^2+(section.c4(1)-xC)^2)))*computeDistance3D(section.c4,section.boundingCircle.center)];
section.dilatedBoundary.c5 = [xC+f*cos(atan2(section.c5(2)-yC,section.c5(1)-xC))*cos(atan2(section.c5(3)-zC,sqrt((section.c5(2)-yC)^2+(section.c5(1)-xC)^2)))*computeDistance3D(section.c5,section.boundingCircle.center) ...
                              yC+f*sin(atan2(section.c5(2)-yC,section.c5(1)-xC))*cos(atan2(section.c5(3)-zC,sqrt((section.c5(2)-yC)^2+(section.c5(1)-xC)^2)))*computeDistance3D(section.c5,section.boundingCircle.center) ...
                              zC+f*sin(atan2(section.c5(3)-zC,sqrt((section.c5(2)-yC)^2+(section.c5(1)-xC)^2)))*computeDistance3D(section.c5,section.boundingCircle.center)];
section.dilatedBoundary.c6 = [xC+f*cos(atan2(section.c6(2)-yC,section.c6(1)-xC))*cos(atan2(section.c6(3)-zC,sqrt((section.c6(2)-yC)^2+(section.c6(1)-xC)^2)))*computeDistance3D(section.c6,section.boundingCircle.center) ...
                              yC+f*sin(atan2(section.c6(2)-yC,section.c6(1)-xC))*cos(atan2(section.c6(3)-zC,sqrt((section.c6(2)-yC)^2+(section.c6(1)-xC)^2)))*computeDistance3D(section.c6,section.boundingCircle.center) ...
                              zC+f*sin(atan2(section.c6(3)-zC,sqrt((section.c6(2)-yC)^2+(section.c6(1)-xC)^2)))*computeDistance3D(section.c6,section.boundingCircle.center)];
section.dilatedBoundary.c7 = [xC+f*cos(atan2(section.c7(2)-yC,section.c7(1)-xC))*cos(atan2(section.c7(3)-zC,sqrt((section.c7(2)-yC)^2+(section.c7(1)-xC)^2)))*computeDistance3D(section.c7,section.boundingCircle.center) ...
                              yC+f*sin(atan2(section.c7(2)-yC,section.c7(1)-xC))*cos(atan2(section.c7(3)-zC,sqrt((section.c7(2)-yC)^2+(section.c7(1)-xC)^2)))*computeDistance3D(section.c7,section.boundingCircle.center) ...
                              zC+f*sin(atan2(section.c7(3)-zC,sqrt((section.c7(2)-yC)^2+(section.c7(1)-xC)^2)))*computeDistance3D(section.c7,section.boundingCircle.center)];
section.dilatedBoundary.c8 = [xC+f*cos(atan2(section.c8(2)-yC,section.c8(1)-xC))*cos(atan2(section.c8(3)-zC,sqrt((section.c8(2)-yC)^2+(section.c8(1)-xC)^2)))*computeDistance3D(section.c8,section.boundingCircle.center) ...
                              yC+f*sin(atan2(section.c8(2)-yC,section.c8(1)-xC))*cos(atan2(section.c8(3)-zC,sqrt((section.c8(2)-yC)^2+(section.c8(1)-xC)^2)))*computeDistance3D(section.c8,section.boundingCircle.center) ...
                              zC+f*sin(atan2(section.c8(3)-zC,sqrt((section.c8(2)-yC)^2+(section.c8(1)-xC)^2)))*computeDistance3D(section.c8,section.boundingCircle.center)];

section.dilatedBoundary.e1 = zeros(length(section.e1),3);
for i=1:length(section.e1)
    section.dilatedBoundary.e1(i,:) = [xC+f*cos(atan2(section.e1(i,2)-yC,section.e1(i,1)-xC))*cos(atan2(section.e1(i,3)-zC,sqrt((section.e1(i,2)-yC)^2+(section.e1(i,1)-xC)^2)))*computeDistance3D(section.e1(i),section.boundingCircle.center) ...
                                       yC+f*sin(atan2(section.e1(i,2)-yC,section.e1(i,1)-xC))*cos(atan2(section.e1(i,3)-zC,sqrt((section.e1(i,2)-yC)^2+(section.e1(i,1)-xC)^2)))*computeDistance3D(section.e1(i),section.boundingCircle.center) ...
                                       zC+f*sin(atan2(section.e1(i,3)-zC,sqrt((section.e1(i,2)-yC)^2+(section.e1(i,1)-xC)^2)))*computeDistance3D(section.e1(i),section.boundingCircle.center)];
end
section.dilatedBoundary.e2 = zeros(length(section.e2),3);
for i=1:length(section.e2)
    section.dilatedBoundary.e2(i,:) = [xC+f*cos(atan2(section.e2(i,2)-yC,section.e2(i,1)-xC))*cos(atan2(section.e2(i,3)-zC,sqrt((section.e2(i,2)-yC)^2+(section.e2(i,1)-xC)^2)))*computeDistance3D(section.e2(i),section.boundingCircle.center) ...
                                       yC+f*sin(atan2(section.e2(i,2)-yC,section.e2(i,1)-xC))*cos(atan2(section.e2(i,3)-zC,sqrt((section.e2(i,2)-yC)^2+(section.e2(i,1)-xC)^2)))*computeDistance3D(section.e2(i),section.boundingCircle.center) ...
                                       zC+f*sin(atan2(section.e2(i,3)-zC,sqrt((section.e2(i,2)-yC)^2+(section.e2(i,1)-xC)^2)))*computeDistance3D(section.e2(i),section.boundingCircle.center)];
end
section.dilatedBoundary.e3 = zeros(length(section.e3),3);
for i=1:length(section.e3)
    section.dilatedBoundary.e3(i,:) = [xC+f*cos(atan2(section.e3(i,2)-yC,section.e3(i,1)-xC))*cos(atan2(section.e3(i,3)-zC,sqrt((section.e3(i,2)-yC)^2+(section.e3(i,1)-xC)^2)))*computeDistance3D(section.e3(i),section.boundingCircle.center) ...
                                       yC+f*sin(atan2(section.e3(i,2)-yC,section.e3(i,1)-xC))*cos(atan2(section.e3(i,3)-zC,sqrt((section.e3(i,2)-yC)^2+(section.e3(i,1)-xC)^2)))*computeDistance3D(section.e3(i),section.boundingCircle.center) ...
                                       zC+f*sin(atan2(section.e3(i,3)-zC,sqrt((section.e3(i,2)-yC)^2+(section.e3(i,1)-xC)^2)))*computeDistance3D(section.e3(i),section.boundingCircle.center)];
end
section.dilatedBoundary.e4 = zeros(length(section.e4),3);
for i=1:length(section.e4)
    section.dilatedBoundary.e4(i,:) = [xC+f*cos(atan2(section.e4(i,2)-yC,section.e4(i,1)-xC))*cos(atan2(section.e4(i,3)-zC,sqrt((section.e4(i,2)-yC)^2+(section.e4(i,1)-xC)^2)))*computeDistance3D(section.e4(i),section.boundingCircle.center) ...
                                       yC+f*sin(atan2(section.e4(i,2)-yC,section.e4(i,1)-xC))*cos(atan2(section.e4(i,3)-zC,sqrt((section.e4(i,2)-yC)^2+(section.e4(i,1)-xC)^2)))*computeDistance3D(section.e4(i),section.boundingCircle.center) ...
                                       zC+f*sin(atan2(section.e4(i,3)-zC,sqrt((section.e4(i,2)-yC)^2+(section.e4(i,1)-xC)^2)))*computeDistance3D(section.e4(i),section.boundingCircle.center)];
end
section.dilatedBoundary.e5 = zeros(length(section.e5),3);
for i=1:length(section.e5)
    section.dilatedBoundary.e5(i,:) = [xC+f*cos(atan2(section.e5(i,2)-yC,section.e5(i,1)-xC))*cos(atan2(section.e5(i,3)-zC,sqrt((section.e5(i,2)-yC)^2+(section.e5(i,1)-xC)^2)))*computeDistance3D(section.e5(i),section.boundingCircle.center) ...
                                       yC+f*sin(atan2(section.e5(i,2)-yC,section.e5(i,1)-xC))*cos(atan2(section.e5(i,3)-zC,sqrt((section.e5(i,2)-yC)^2+(section.e5(i,1)-xC)^2)))*computeDistance3D(section.e5(i),section.boundingCircle.center) ...
                                       zC+f*sin(atan2(section.e5(i,3)-zC,sqrt((section.e5(i,2)-yC)^2+(section.e5(i,1)-xC)^2)))*computeDistance3D(section.e5(i),section.boundingCircle.center)];
end
section.dilatedBoundary.e6 = zeros(length(section.e6),3);
for i=1:length(section.e6)
    section.dilatedBoundary.e6(i,:) = [xC+f*cos(atan2(section.e6(i,2)-yC,section.e6(i,1)-xC))*cos(atan2(section.e6(i,3)-zC,sqrt((section.e6(i,2)-yC)^2+(section.e6(i,1)-xC)^2)))*computeDistance3D(section.e6(i),section.boundingCircle.center) ...
                                       yC+f*sin(atan2(section.e6(i,2)-yC,section.e6(i,1)-xC))*cos(atan2(section.e6(i,3)-zC,sqrt((section.e6(i,2)-yC)^2+(section.e6(i,1)-xC)^2)))*computeDistance3D(section.e6(i),section.boundingCircle.center) ...
                                       zC+f*sin(atan2(section.e6(i,3)-zC,sqrt((section.e6(i,2)-yC)^2+(section.e6(i,1)-xC)^2)))*computeDistance3D(section.e6(i),section.boundingCircle.center)];
end
section.dilatedBoundary.e7 = zeros(length(section.e7),3);
for i=1:length(section.e7)
    section.dilatedBoundary.e7(i,:) = [xC+f*cos(atan2(section.e7(i,2)-yC,section.e7(i,1)-xC))*cos(atan2(section.e7(i,3)-zC,sqrt((section.e7(i,2)-yC)^2+(section.e7(i,1)-xC)^2)))*computeDistance3D(section.e7(i),section.boundingCircle.center) ...
                                       yC+f*sin(atan2(section.e7(i,2)-yC,section.e7(i,1)-xC))*cos(atan2(section.e7(i,3)-zC,sqrt((section.e7(i,2)-yC)^2+(section.e7(i,1)-xC)^2)))*computeDistance3D(section.e7(i),section.boundingCircle.center) ...
                                       zC+f*sin(atan2(section.e7(i,3)-zC,sqrt((section.e7(i,2)-yC)^2+(section.e7(i,1)-xC)^2)))*computeDistance3D(section.e7(i),section.boundingCircle.center)];
end
section.dilatedBoundary.e8 = zeros(length(section.e8),3);
for i=1:length(section.e8)
    section.dilatedBoundary.e8(i,:) = [xC+f*cos(atan2(section.e8(i,2)-yC,section.e8(i,1)-xC))*cos(atan2(section.e8(i,3)-zC,sqrt((section.e8(i,2)-yC)^2+(section.e8(i,1)-xC)^2)))*computeDistance3D(section.e8(i),section.boundingCircle.center) ...
                                       yC+f*sin(atan2(section.e8(i,2)-yC,section.e8(i,1)-xC))*cos(atan2(section.e8(i,3)-zC,sqrt((section.e8(i,2)-yC)^2+(section.e8(i,1)-xC)^2)))*computeDistance3D(section.e8(i),section.boundingCircle.center) ...
                                       zC+f*sin(atan2(section.e8(i,3)-zC,sqrt((section.e8(i,2)-yC)^2+(section.e8(i,1)-xC)^2)))*computeDistance3D(section.e8(i),section.boundingCircle.center)];
end
section.dilatedBoundary.e9 = zeros(length(section.e9),3);
for i=1:length(section.e9)
    section.dilatedBoundary.e9(i,:) = [xC+f*cos(atan2(section.e9(i,2)-yC,section.e9(i,1)-xC))*cos(atan2(section.e9(i,3)-zC,sqrt((section.e9(i,2)-yC)^2+(section.e9(i,1)-xC)^2)))*computeDistance3D(section.e9(i),section.boundingCircle.center) ...
                                       yC+f*sin(atan2(section.e9(i,2)-yC,section.e9(i,1)-xC))*cos(atan2(section.e9(i,3)-zC,sqrt((section.e9(i,2)-yC)^2+(section.e9(i,1)-xC)^2)))*computeDistance3D(section.e9(i),section.boundingCircle.center) ...
                                       zC+f*sin(atan2(section.e9(i,3)-zC,sqrt((section.e9(i,2)-yC)^2+(section.e9(i,1)-xC)^2)))*computeDistance3D(section.e9(i),section.boundingCircle.center)];
end
section.dilatedBoundary.e10 = zeros(length(section.e10),3);
for i=1:length(section.e10)
    section.dilatedBoundary.e10(i,:) = [xC+f*cos(atan2(section.e10(i,2)-yC,section.e10(i,1)-xC))*cos(atan2(section.e10(i,3)-zC,sqrt((section.e10(i,2)-yC)^2+(section.e10(i,1)-xC)^2)))*computeDistance3D(section.e10(i),section.boundingCircle.center) ...
                                       yC+f*sin(atan2(section.e10(i,2)-yC,section.e10(i,1)-xC))*cos(atan2(section.e10(i,3)-zC,sqrt((section.e10(i,2)-yC)^2+(section.e10(i,1)-xC)^2)))*computeDistance3D(section.e10(i),section.boundingCircle.center) ...
                                       zC+f*sin(atan2(section.e10(i,3)-zC,sqrt((section.e10(i,2)-yC)^2+(section.e10(i,1)-xC)^2)))*computeDistance3D(section.e10(i),section.boundingCircle.center)];
end
section.dilatedBoundary.e11 = zeros(length(section.e11),3);
for i=1:length(section.e11)
    section.dilatedBoundary.e11(i,:) = [xC+f*cos(atan2(section.e11(i,2)-yC,section.e11(i,1)-xC))*cos(atan2(section.e11(i,3)-zC,sqrt((section.e11(i,2)-yC)^2+(section.e11(i,1)-xC)^2)))*computeDistance3D(section.e11(i),section.boundingCircle.center) ...
                                       yC+f*sin(atan2(section.e11(i,2)-yC,section.e11(i,1)-xC))*cos(atan2(section.e11(i,3)-zC,sqrt((section.e11(i,2)-yC)^2+(section.e11(i,1)-xC)^2)))*computeDistance3D(section.e11(i),section.boundingCircle.center) ...
                                       zC+f*sin(atan2(section.e11(i,3)-zC,sqrt((section.e11(i,2)-yC)^2+(section.e11(i,1)-xC)^2)))*computeDistance3D(section.e11(i),section.boundingCircle.center)];
end
section.dilatedBoundary.e12 = zeros(length(section.e12),3);
for i=1:length(section.e12)
    section.dilatedBoundary.e12(i,:) = [xC+f*cos(atan2(section.e12(i,2)-yC,section.e12(i,1)-xC))*cos(atan2(section.e12(i,3)-zC,sqrt((section.e12(i,2)-yC)^2+(section.e12(i,1)-xC)^2)))*computeDistance3D(section.e12(i),section.boundingCircle.center) ...
                                       yC+f*sin(atan2(section.e12(i,2)-yC,section.e12(i,1)-xC))*cos(atan2(section.e12(i,3)-zC,sqrt((section.e12(i,2)-yC)^2+(section.e12(i,1)-xC)^2)))*computeDistance3D(section.e12(i),section.boundingCircle.center) ...
                                       zC+f*sin(atan2(section.e12(i,3)-zC,sqrt((section.e12(i,2)-yC)^2+(section.e12(i,1)-xC)^2)))*computeDistance3D(section.e12(i),section.boundingCircle.center)];
end
section.dilatedBoundary.f1 = zeros(length(section.f1),3);
for i=1:length(section.f1)
    section.dilatedBoundary.f1(i,:) = [xC+f*cos(atan2(section.f1(i,2)-yC,section.f1(i,1)-xC))*cos(atan2(section.f1(i,3)-zC,sqrt((section.f1(i,2)-yC)^2+(section.f1(i,1)-xC)^2)))*computeDistance3D(section.f1(i),section.boundingCircle.center) ...
                                       yC+f*sin(atan2(section.f1(i,2)-yC,section.f1(i,1)-xC))*cos(atan2(section.f1(i,3)-zC,sqrt((section.f1(i,2)-yC)^2+(section.f1(i,1)-xC)^2)))*computeDistance3D(section.f1(i),section.boundingCircle.center) ...
                                       zC+f*sin(atan2(section.f1(i,3)-zC,sqrt((section.f1(i,2)-yC)^2+(section.f1(i,1)-xC)^2)))*computeDistance3D(section.f1(i),section.boundingCircle.center)];
end
section.dilatedBoundary.f2 = zeros(length(section.f2),3);
for i=1:length(section.f2)
    section.dilatedBoundary.f2(i,:) = [xC+f*cos(atan2(section.f2(i,2)-yC,section.f2(i,1)-xC))*cos(atan2(section.f2(i,3)-zC,sqrt((section.f2(i,2)-yC)^2+(section.f2(i,1)-xC)^2)))*computeDistance3D(section.f2(i),section.boundingCircle.center) ...
                                       yC+f*sin(atan2(section.f2(i,2)-yC,section.f2(i,1)-xC))*cos(atan2(section.f2(i,3)-zC,sqrt((section.f2(i,2)-yC)^2+(section.f2(i,1)-xC)^2)))*computeDistance3D(section.f2(i),section.boundingCircle.center) ...
                                       zC+f*sin(atan2(section.f2(i,3)-zC,sqrt((section.f2(i,2)-yC)^2+(section.f2(i,1)-xC)^2)))*computeDistance3D(section.f2(i),section.boundingCircle.center)];
end
section.dilatedBoundary.f3 = zeros(length(section.f3),3);
for i=1:length(section.f3)
    section.dilatedBoundary.f3(i,:) = [xC+f*cos(atan2(section.f3(i,2)-yC,section.f3(i,1)-xC))*cos(atan2(section.f3(i,3)-zC,sqrt((section.f3(i,2)-yC)^2+(section.f3(i,1)-xC)^2)))*computeDistance3D(section.f3(i),section.boundingCircle.center) ...
                                       yC+f*sin(atan2(section.f3(i,2)-yC,section.f3(i,1)-xC))*cos(atan2(section.f3(i,3)-zC,sqrt((section.f3(i,2)-yC)^2+(section.f3(i,1)-xC)^2)))*computeDistance3D(section.f3(i),section.boundingCircle.center) ...
                                       zC+f*sin(atan2(section.f3(i,3)-zC,sqrt((section.f3(i,2)-yC)^2+(section.f3(i,1)-xC)^2)))*computeDistance3D(section.f3(i),section.boundingCircle.center)];
end
section.dilatedBoundary.f4 = zeros(length(section.f4),3);
for i=1:length(section.f4)
    section.dilatedBoundary.f4(i,:) = [xC+f*cos(atan2(section.f4(i,2)-yC,section.f4(i,1)-xC))*cos(atan2(section.f4(i,3)-zC,sqrt((section.f4(i,2)-yC)^2+(section.f4(i,1)-xC)^2)))*computeDistance3D(section.f4(i),section.boundingCircle.center) ...
                                       yC+f*sin(atan2(section.f4(i,2)-yC,section.f4(i,1)-xC))*cos(atan2(section.f4(i,3)-zC,sqrt((section.f4(i,2)-yC)^2+(section.f4(i,1)-xC)^2)))*computeDistance3D(section.f4(i),section.boundingCircle.center) ...
                                       zC+f*sin(atan2(section.f4(i,3)-zC,sqrt((section.f4(i,2)-yC)^2+(section.f4(i,1)-xC)^2)))*computeDistance3D(section.f4(i),section.boundingCircle.center)];
end
section.dilatedBoundary.f5 = zeros(length(section.f5),3);
for i=1:length(section.f5)
    section.dilatedBoundary.f5(i,:) = [xC+f*cos(atan2(section.f5(i,2)-yC,section.f5(i,1)-xC))*cos(atan2(section.f5(i,3)-zC,sqrt((section.f5(i,2)-yC)^2+(section.f5(i,1)-xC)^2)))*computeDistance3D(section.f5(i),section.boundingCircle.center) ...
                                       yC+f*sin(atan2(section.f5(i,2)-yC,section.f5(i,1)-xC))*cos(atan2(section.f5(i,3)-zC,sqrt((section.f5(i,2)-yC)^2+(section.f5(i,1)-xC)^2)))*computeDistance3D(section.f5(i),section.boundingCircle.center) ...
                                       zC+f*sin(atan2(section.f5(i,3)-zC,sqrt((section.f5(i,2)-yC)^2+(section.f5(i,1)-xC)^2)))*computeDistance3D(section.f5(i),section.boundingCircle.center)];
end
section.dilatedBoundary.f6 = zeros(length(section.f6),3);
for i=1:length(section.f6)
    section.dilatedBoundary.f6(i,:) = [xC+f*cos(atan2(section.f6(i,2)-yC,section.f6(i,1)-xC))*cos(atan2(section.f6(i,3)-zC,sqrt((section.f6(i,2)-yC)^2+(section.f6(i,1)-xC)^2)))*computeDistance3D(section.f6(i),section.boundingCircle.center) ...
                                       yC+f*sin(atan2(section.f6(i,2)-yC,section.f6(i,1)-xC))*cos(atan2(section.f6(i,3)-zC,sqrt((section.f6(i,2)-yC)^2+(section.f6(i,1)-xC)^2)))*computeDistance3D(section.f6(i),section.boundingCircle.center) ...
                                       zC+f*sin(atan2(section.f6(i,3)-zC,sqrt((section.f6(i,2)-yC)^2+(section.f6(i,1)-xC)^2)))*computeDistance3D(section.f6(i),section.boundingCircle.center)];
end

return