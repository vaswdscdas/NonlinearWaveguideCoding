function dy=myode(t,y)
dy=zeros(2,1);
dy(1)=y(2);
dy(2)=-y(2)*(y(1).^2-1)-y(1);
% function dy=myode(t,y)
% Theda=pi/6;
% u_s=1.2258;
% r=0.075;b=1;H=(7-tan(Theda))*cos(Theda);n=5.1;
% dy=zeros(2,1);
% dy(1)=-2/((2*b/cos(Theda)-H*tan(Theda))*y(2)+tan(Theda)*(y(2))^2)*tan(Theda)*u_s*y(1)*...
%     (1-4/3*pi*r^3*y(1))^n*y(2)-2*b/(cos(Theda)*((2*b/cos(Theda)-H*tan(Theda))*y(2)+...
%     tan(Theda)*(y(2))^2))*u_s*y(1)*(1-4/3*pi*r^3*y(1))^n+...
%     1/((2*b/cos(Theda)-H*tan(Theda))*y(2)+tan(Theda)*(y(2))^2)*y(1)*((2*b/cos(Theda)-...
%     H*tan(Theda))*u_s*(1-4/3*pi*r^3*y(1))^n+...
%     2*tan(Theda)*y(2)*u_s*(1-4/3*pi*r^3*y(1))^n);
% dy(2)=-u_s*(1-4/3*pi*r^3*y(1))^n;