function demoLogo()

close all
clear all
clc

N = 36; 

figureFULL;
% S S
theta   = linspace(0,2*pi,N); 

x  = cos(3/2*theta)/2;
z  = (1 + 1i)*sin(0.7*(theta-pi) + pi)
% z  = (1+1i)*(sqrt(1/4 - (x-1/2).^2) + 0.5);
% z2 = 1.3*(1+1i)*(1/2 - sqrt(1/4 - (x-1/2).^2)).*sign(1/2-x);

xS = [x 1/0]; 
zS = [z 1/0]; 

% O N
% theta   = linspace(0,2*pi,50); 
x       = cos(theta);

z       = cos(3*theta) + 1i*sin(theta); 

xO = [x/2 1/0 x/2 1/0] + 1.25; 
zO = [z, 1/0, conj(z) 1/0];

% A A
x       = linspace(-1/2,1/2,N);
z       = (1+1i)*(1 - 8*x.^2); 
z2      = (1+1i)*zeros(size(x)); 

xA = [x 1/0 x 1/0] + 2.5; 
zA = [z, 1/0, z2, 1/0];

% P K
x = -1/2 + 0.01*theta;
z = sin(theta) + 1i*cos(3/4*theta);

x2 = -1/2*cos(2*theta*3/4);
z2 = -sin(theta*3/4) + 1i*(1/2-1/2*cos(theta*3/4));
xP = [x x2 1/0] + 3.75; 
zP = [z z2 1/0];


% - E
x = 1/2*cos(2*theta);
z = cos(theta/2)+1/8*sin(2*theta);

x_ = [x 1/0]+ 5; 
z_ = [z 1/0];


xInput = [xS xO xA xP x_]+2;
zInput = [zS zO zA zP z_];


soapSnakeLogo(xInput,zInput);


% figureFULL;


end

function soapSnakeLogo(x,z)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % function to display the complex behavior of: 
    %   f(x) -> z     x is real, z is complex
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % EXAMPLES
    
    % Example 1) 
    % The complex function exp(1i*2*pi*x), with Gaussian decaying magnitude: 
    %    x = linspace(-2.2,2.2,201); 
    %    z = exp(1i*2*pi*x).*exp(-1/2*x.^2);
    %    figure; soapSnake3(x,z);
    
    % Example 2) 
    % Two branches
    % Please separate multiple branches / functions with x = 1/0
    %   x = [linspace(-2,-0.1,200), 1/0, linspace(0.1,2,200)];
    %   z = log(x); 
    %   figure; soapSnake3(x,z);
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Author: Job Bouwman
    % 21-02-2016
    % jgbouwman@hotmail.com
    
    
    %% Find the non-valid indices and the separation indices:
    separation_indices = unique([...
        find(isinf(x)),...
        find(isinf(z)),...
        find(abs(z)>1e3)]);
    
    codeList = -1*ones(size(x));
    code = 1;
    increaseCodeNumber = 0;
    for k = 1:length(x)
        if find(separation_indices==k)
            codeList(k) = 0;
            if increaseCodeNumber
                code = code + 1;
                increaseCodeNumber = 0;
            end
        else
            codeList(k) = code;
            increaseCodeNumber = 1;
        end
    end
    
    
    hold on
    xMin =  1e99;
    xMax = -1e99;
    rMin =  1e99;
    rMax = -1e99;
    iMin =  1e99;
    iMax = -1e99;
    
    for m = 1:max(codeList)
        xCur = x(codeList==m);
        zCur = z(codeList==m);
        
        xMin = min([xMin, min(     xCur )]);
        xMax = max([xMax, max(     xCur )]);
        rMin = min([rMin, min(real(zCur))]);
        rMax = max([rMax, max(real(zCur))]);
        iMin = min([iMin, min(imag(zCur))]);
        iMax = max([iMax, max(imag(zCur))]);
        
        xCell{m} = xCur;
        zCell{m} = zCur;
        snakePlot([xCur; real(zCur); imag(zCur)],0.1*ones(size(zCur)));
    end
    
    %% Creating the right domain: 
    xDom    = 1.1*[xMin,xMax] - 0.1*[xMax,xMin];
    absMax = max(abs([rMin,rMax,iMin,iMax]));
    
    realDom = [...
        min([rMin -sqrt(absMax)]), ...
        max([rMax +sqrt(absMax)])];
    
    imagDom = [...
        min([iMin -sqrt(absMax)]), ...
        max([iMax +sqrt(absMax)])];
    

    % Widen and make the real and imaginary domain equivalent size: 
    absRadius = sqrt(2)*sqrt(...
            ((realDom(2)-realDom(1))/2)^2 + ...
            ((imagDom(2)-imagDom(1))/2)^2);  
        realDom = mean(realDom) + absRadius*[-1, +1];
        imagDom = mean(imagDom) + absRadius*[-1, +1];
    % combine: 
        BB = 2*[xDom realDom imagDom];
        BB(1) = -2;
        BB(2) =  10;
        
    
     for m = 1:max(codeList)
            x = xCell{m};
            z = zCell{m};
  
   
  
    % setting some different shadings for the three projection walls: 
        rat = 20; % steps of grey levels
        wallColor1 = (rat - 0)/rat*[1 1 1]; % white (complex)
        wallColor2 = (rat - 2)/rat*[1 1 1]; % ligth grey ()
        wallColor3 = (rat - 1)/rat*[1 1 1]; % offwhite ()
        
        wallColor1 = [1 1 1]; % white (complex)
        wallColor2 = [1 1 1]; % ligth grey ()
        wallColor3 = [1 1 1]; % offwhite ()
    
  
      
    for k = 1:(length(x)-1)
        
        % rgb color of each panel: 
        % (making phi = 0 yellow, phi = pi/2 red, and so forth);
        colorOfPanel = 1/2+1/2*cos(-1+angle(z(k)+z(k+1))+2*pi/3*[0 1 2]);
       
        % the 'wire frame' of each soap skin:
        
        SOAPHEART = 0;
        if SOAPHEART
            soapWire =  [...
               [x(k), x(k), x(k+1), x(k+1),x(k)];...
               real([ABBER(k) z(k) z(k+1) ABBER(k+1),ABBER(k)]);...
               imag([ABBER(k),z(k),z(k+1),ABBER(k+1),ABBER(k)])];
        else
            soapWire =  [...
               [x(k), x(k), x(k+1), x(k+1),x(k)];...
               real([0,z(k),z(k+1),0,0]);...
               imag([0,z(k),z(k+1),0,0])];
        end
       
  
        % draw 'shadows' on the wall:
        for projNr = 0:3
            wire = soapWire;
       
            switch projNr
                case 0; 
                    wallColorCur = [1 1 1];
                case 1; 
                    wallColorCur = wallColor1;
                    wire(1,:) = BB(1)+1e-3;
                case 2; 
                    wallColorCur = wallColor2;
                    wire(2,:) = BB(4)-1e-3;
                case 3; 
                    wallColorCur = wallColor3;
                    wire(3,:) = BB(5)+1e-3;
            end
            if projNr > 0
                panelColor = ((3/4+1/4*colorOfPanel).*wallColorCur);
            else
                panelColor = colorOfPanel; 
            end
            h1 = fill3(wire(1,:),wire(2,:), wire(3,:),panelColor);
            if projNr == 0
                alpha(h1,0.2);
            end
%            set(h1,'EdgeColor','none');
            set(h1,'EdgeColor',panelColor*0.95);
        end
    end
    end
    
    % draw walls: 
    xCycle  = [BB(1) BB(1) BB(2) BB(2) BB(1)];
    reCycle = [BB(3) BB(3) BB(4) BB(4) BB(3)];
    imCycle = [BB(5) BB(5) BB(6) BB(6) BB(5)];
 
    h1 = fill3(BB(1)*ones(1,4), reCycle(1:4),imCycle(2:5), wallColor1);  hold on; % ,'Color', sqrt(blueColor)); 
        set(h1,'EdgeColor','none');
    h1 = fill3(xCycle(1:4), 1.01*BB(4)*ones(1,4),imCycle(2:5),wallColor2);  hold on; % ,'Color', sqrt(blueColor)); 
        set(h1,'EdgeColor','none');
    h1 = fill3(xCycle(1:4), reCycle(2:5), 1.01*BB(5)*ones(1,4),wallColor3);  hold on; % ,'Color', sqrt(blueColor)); 
        set(h1,'EdgeColor','none');
   
    % The complex symbol
    N = 200; 
    phi = linspace(1/4*pi, 7/4*pi, N); 
    C_plx = [exp(1i*phi) 0.8*exp(1i*fliplr(phi))];
    C_plx(round(N*1.3):round(N*1.35)) = conj(C_plx(round(N*1.3):round(N*1.35)));
    
    sizeC = min(BB(4) - BB(3), BB(6) - BB(5))/6;
    C_plx = C_plx/2*sizeC + BB(3) + 1i*BB(5) + (1 + 1i)*sizeC;
    
   
    h1 = fill3(0.95*BB(1)*ones(size(C_plx)), real(C_plx),imag(C_plx), wallColor1/2);  hold on; % ,'Color', sqrt(blueColor)); 
    % set(h1,'EdgeColor','k');
    
    set(h1,'EdgeColor','none');
    alpha(h1,0.7);   
    
    
    % The x 
    shift = 3;
    phi = linspace(0, 2*pi, 13);
    phi = phi(1:12);
    C_plx = exp(1i*phi);
    C_plx(1:3:end) = C_plx(1:3:end)*(1/2*sqrt(3) - 1/2);
    A_plx = C_plx;
    C_plx(2:3:12) = 1.5*C_plx(2:3:12)-0.5*C_plx(mod((2:3:12)+7-1, 12)+1);
    C_plx(3:3:12) = 1.5*A_plx(3:3:12)-0.5*A_plx(mod((3:3:12)+5-1, 12)+1);
    C_plx = C_plx/1.5;
   %  C_plx = complex(real(C_plx) + 0.2*imag(C_plx), imag(C_plx));
    
    reFact = 40;
    C_plx = C_plx*(BB(4) - BB(3))/reFact + BB(2) + shift*(BB(4) - BB(3))/reFact*(-1 - 1i);
    
    h1 = fill3(real(C_plx), imag(C_plx), 0.99*BB(5)*ones(size(C_plx)), 1/2+[0 0 0]);  hold on; % ,'Color', sqrt(blueColor)); 
    set(h1,'EdgeColor','none');
  
    h1 = fill3(real(C_plx), 0.99*BB(4)*ones(size(C_plx)),imag(C_plx),  1/2+[0 0 0]);  hold on; % ,'Color', sqrt(blueColor)); 
    set(h1,'EdgeColor','none');
  
    h1 = fill3(real(C_plx), imag(C_plx), imag(C_plx), [0 0 0]);  hold on; % ,'Color', sqrt(blueColor)); 
    set(h1,'EdgeColor','none');
  
    % The R 
    im = [-1 +1 (0.4+0.6*cos(linspace(0,pi,100))) -1  -1 -0.2  -0.2    0.2   (0.4-0.2*cos(linspace(0,pi,100)))  0.6     0  -1     -1];  
    re = [-1 -1 (0.4+0.6*sin(linspace(0,pi,100)))  1 0.6  0     -0.6  -0.6   (0.4+0.2*sin(linspace(0,pi,100)))  -0.6   -0.6 -0.6  -1];
    
    
    C_plx = re + 1i*im;  
   %  C_plx = complex(real(C_plx) + 0.2*imag(C_plx), imag(C_plx));
    
    C_plx = C_plx*(BB(4) - BB(3))/reFact + BB(4) + shift*(BB(4) - BB(3))/reFact*(-1 - 1i);
   
    h1 = fill3(-imag(C_plx - 2*shift*(BB(4) - BB(3))/reFact*(-1 - 1i)),real(C_plx),  0.99*BB(5)  +    0*imag(C_plx), 1/2+[0 0 0]);  hold on; % ,'Color', sqrt(blueColor)); 
    set(h1,'EdgeColor','none');
  
    h1 = fill3(BB(1)*0.99 +    0*-imag(C_plx - 2*shift*(BB(4) - BB(3))/reFact*(-1 - 1i)), real(C_plx),  imag(C_plx), 1/2+[0 0 0]);  hold on; % ,'Color', sqrt(blueColor)); 
    set(h1,'EdgeColor','none');
  
    h1 = fill3(-imag(C_plx - 2*shift*(BB(4) - BB(3))/reFact*(-1 - 1i)), real(C_plx),  imag(C_plx), [0 0 0]);  hold on; % ,'Color', sqrt(blueColor)); 
    set(h1,'EdgeColor','none');
   
    
    % The I 
    im = [-1, +1 ,+1, -1]; 
    re = [-0.2, -0.2, 0.2, 0.2];
    C_plx = re + 1i*im;  
   %  C_plx = complex(real(C_plx) + 0.2*imag(C_plx), imag(C_plx));
    
    C_plx = C_plx*(BB(4) - BB(3))/reFact + 1i*BB(6) + shift*(BB(4) - BB(3))/reFact*(-1 - 1i);
   
    h1 = fill3(BB(1)*0.99 +    0*real(C_plx)  , real(C_plx),  imag(C_plx),1/2+[0 0 0]);  hold on; % ,'Color', sqrt(blueColor)); 
    set(h1,'EdgeColor','none');
 
    
        h1 = fill3(real(C_plx)  , 0.99*BB(4)  +    0*real(C_plx),  imag(C_plx), 1/2+[0 0 0]);  hold on; % ,'Color', sqrt(blueColor)); 
    set(h1,'EdgeColor','none');
  
    
        h1 = fill3(real(C_plx)  , real(C_plx),  imag(C_plx), [0 0 0]);  hold on; % ,'Color', sqrt(blueColor)); 
    set(h1,'EdgeColor','none');
 
    
    
        
  
%     if  ~snakeModus
%         for m = 1:length(x)
%             plot3(x(m)*[1 1], [0 real(z(m))],[0 imag(z(m))], 'Color', (1/4-cos(2*angle(z(m)))/4)*[1 1 1], 'LineWidth', 1); 
%         end  
%     end
   
    % draw plot itself:
    wallFactor = 3/4;
    projNrs = 1:3;

     for m = 1:max(codeList)
            x = xCell{m};
            z = zCell{m};

        for k = 1:(length(x)-1)
            LINE = [x(k:k+1);real(z(k:k+1));imag(z(k:k+1))];
            thick = 2*(mean(abs(z(k:k+1))));
            thick = 5; % 2*(mean(abs(z(k:k+1))));
            
            for projNr = projNrs
                curLine = LINE;
                switch projNr
                    case 0; curCol = 1/2*[1 1 1];
                    case 1; curCol = 1/2*wallColor1; curLine(1,:) = BB(1);
                    case 2; curCol = 1/2*wallColor2; curLine(2,:) = BB(4);
                    case 3; curCol = 1/2*wallColor3; curLine(3,:) = BB(5);
                end  
                if projNr > 0
                    curCol = curCol*wallFactor;
                else
                    curCol = [0 0 0]; % curCol*wallFactor.*colorOfPanel;
                end
                plot3(curLine(1,:),curLine(2,:),curLine(3,:),'Color',curCol, 'LineWidth',thick); 
            end
        end
     end
    
    % draw axes:
    for axDim = 1:3
        a = circshift([0,0,1], [0, axDim]); 
        plot3(...
            a(1)*[BB(1), BB(2)],...
            a(2)*[BB(3), BB(4)],...
            a(3)*[BB(5), BB(6)],...
            'Color',0*[1 1 1], 'LineWidth',2); 
        for axDim2 = 1:2
            b = circshift([0,0,1], [0, axDim2+axDim]); 
            plot3(...
                a(1)*[BB(1), BB(2)] + b(1)*(1-a(1))*BB(1),...
                a(2)*[BB(3), BB(4)] + b(2)*(1-a(2))*BB(4),...
                a(3)*[BB(5), BB(6)] + b(3)*(1-a(3))*BB(5),...
                'Color',2/3*[1 1 1], 'LineWidth',2);
        end
    end
    
    % arrows: 
    minPosLength = min([BB(2), BB(4), BB(6)]);
    ARR = minPosLength/15*[-3 - 1i, 0, -3 + 1i , -2];
    
    fill3(imag(ARR) , imag(ARR),  BB(6) + real(ARR),[0 0 0]);  hold on; % ,'Color', sqrt(blueColor)); 
        h1 = fill3(BB(1)+0.01+0*imag(ARR) , imag(ARR),  BB(6) + real(ARR),2/3+[0 0 0]);  hold on; % ,'Color', sqrt(blueColor)); 
        set(h1,'EdgeColor','none');
        h1 = fill3(imag(ARR) , BB(4)+0*imag(ARR),  BB(6) + real(ARR),2/3+[0 0 0]);  hold on; % ,'Color', sqrt(blueColor)); 
        set(h1,'EdgeColor','none');
   
    fill3(-imag(ARR) , BB(4) + real(ARR), imag(ARR),[0 0 0]);  hold on; % ,'Color', sqrt(blueColor)); 
        h1 = fill3(BB(1)+0.01+0*imag(ARR) , BB(4) + real(ARR),  imag(ARR),2/3+[0 0 0]);  hold on; % ,'Color', sqrt(blueColor)); 
        set(h1,'EdgeColor','none');
        h1 = fill3(-imag(ARR) , BB(4) + real(ARR),  BB(5) +0*imag(ARR),2/3+[0 0 0]);  hold on; % ,'Color', sqrt(blueColor)); 
        set(h1,'EdgeColor','none');
    
    fill3(BB(2) + real(ARR), imag(ARR) ,imag(ARR),[0 0 0]);  hold on; % ,'Color', sqrt(blueColor)); 
        h1 = fill3(BB(2) + real(ARR) , BB(4)+0*imag(ARR), imag(ARR),2/3+[0 0 0]);  hold on; % ,'Color', sqrt(blueColor)); 
        set(h1,'EdgeColor','none');
        h1 = fill3(BB(2) + real(ARR), imag(ARR),  BB(5) +0*imag(ARR),2/3+[0 0 0]);  hold on; % ,'Color', sqrt(blueColor)); 
        set(h1,'EdgeColor','none');
   
    a = -1:1;
   % scatter3(a,0*a,0*a,400, '.k');
    scatter3(0*a,a, 0*a,400, '.k');
    scatter3(0*a,0*a,a,400, '.k');
    

        
    axis equal
     set(gcf,'color','w');
    view([0.5 -1 0.5]);
    view([2/3 -1 1.1]);
    
    % camproj('perspective');
    axis([BB(1) BB(2) BB(3) BB(4) BB(5) BB(6)]);  
    % axis off
end

function [x,y,z] = snakePlot(curve,r,n,ct)
    % Usage: [x,y,z]=tubeplot(curve,r,n,ct)
    % 
    % Tubeplot constructs a tube, or warped cylinder, along
    % any 3D curve, much like the build in cylinder function.
    % If no output are requested, the tube is plotted.
    % Otherwise, you can plot by using surf(x,y,z);
    %
    % Example of use:
    % t=linspace(0,2*pi,50);
    % tubeplot([cos(t);sin(t);0.2*(t-pi).^2],0.1);
    % daspect([1,1,1]); camlight;
    %
    % Arguments:
    % curve: [3,N] vector of curve data
    % r      the radius of the tube
    % n      number of points to use on circumference. Defaults to 8
    % ct     threshold for collapsing points. Defaults to r/2 
    %
    % The algorithms fails if you have bends beyond 90 degrees.
    % Janus H. Wesenberg, july 2004

      if nargin<3 || isempty(n), n=8;
         if nargin<2, error('Give at least curve and radius');
        end;
      end;
      if size(curve,1)~=3
        error('Malformed curve: should be [3,N]');
      end;
      if nargin<4 || isempty(ct)
        ct=0.5*r;
      end

  
  %Collapse points within 0.5 r of each other
  npoints=1;
  for k=2:(size(curve,2)-1)
    if norm(curve(:,k)-curve(:,npoints))>ct(k);
      npoints=npoints+1;
      curve(:,npoints) = curve(:,k);
      ctNew(:,npoints) = ct(:,k);
      rNew(:,npoints) = r(:,k);
    end
  end
  ct = ctNew; 
  r = rNew; 
  
  %Always include endpoint
  if norm(curve(:,end)-curve(:,npoints))>0
    npoints=npoints+1;
    curve(:,npoints)=curve(:,end);
    ct(:,npoints) = ct(:,end);
    r(:,npoints) = r(:,end);
  end

  %deltavecs: average for internal points.
  %           first stretch for endpoints.
  dv=curve(:,[2:end,end])-curve(:,[1,1:end-1]);

  %make nvec not parallel to dv(:,1)
  nvec=zeros(3,1);
  [buf,idx]=min(abs(dv(:,1))); nvec(idx)=1;

  xyz=repmat([0],[3,n+1,npoints+2]);
  
  %precalculate cos and sing factors:
  cfact=repmat(cos(linspace(0,2*pi,n+1)),[3,1]);
  sfact=repmat(sin(linspace(0,2*pi,n+1)),[3,1]);
  
  %Main loop: propagate the normal (nvec) along the tube
  for k=1:npoints
    convec=cross(nvec,dv(:,k));
    convec=convec./norm(convec);
    nvec=cross(dv(:,k),convec);
    nvec=nvec./norm(nvec);
    %update xyz:
    xyz(:,:,k+1)=repmat(curve(:,k),[1,n+1])+...
        cfact.*repmat(r(k)*nvec,[1,n+1])...
        +sfact.*repmat(r(k)*convec,[1,n+1]);
  end;
  
  %finally, cap the ends:
  xyz(:,:,1)=repmat(curve(:,1),[1,n+1]);
  xyz(:,:,end)=repmat(curve(:,end),[1,n+1]);
  
  %,extract results:
  x=squeeze(xyz(1,:,:));
  y=squeeze(xyz(2,:,:));
  z=squeeze(xyz(3,:,:));
  
  %... and plot:
  if nargout<3
    surfl(x,y,z); 
    colormap 'gray'
    shading faceted
  end   
end
  
