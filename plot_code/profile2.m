function []=profile2(M)

% profile2.m 2/5/2013 Parker MacCready
%
% plots the results of a mooring extraction,
% focused on shear and stratification

% note "fn" is not needed; could drop from the function call

% 8/20/2013 slow!

td = M.td;
ys = datestr(td(1),'yyyy');
yn = str2num(ys);
td0 = td - datenum(yn,1,1,0,0,0);

z = M.z_rho; eta = M.zeta; zb = M.z_w(1,:);
u = M.u; v = M.v;
t = M.temp; s = M.salt;
% extrapolate to top and bottom
zz = [zb; z; eta];
uu = [0*zb; u; u(end,:)];
vv = [0*zb; v; v(end,:)];
tt = [t(1,:); t; t(end,:)];
ss = [s(1,:); s; s(end,:)];
[NR,NC] = size(ss);

td0 = repmat(td0,NR,1);

rho = Z_fast_potdens(ss,tt);
rhop = rho - mean(rho,2)*ones(1,NC);

uup = uu - ones(NR,1)*M.ubar;
vvp = vv - ones(NR,1)*M.vbar;

figure; set(gcf,'position',[20 20 1400 900]); Z_fig(16);

subplot(311)
contourf(td0,zz,uup,[-1:.05:1])
%shading interp
caxis([-0.25 0.25]);
colorbar('eastoutside')
ylabel('Z (m)')
axis([td0(1) td0(end) zz(1,1) 5]);
set(gca,'xticklabel',[]);
[xt,yt] = Z_lab('ll');
text(xt,yt,'U-prime (m s^{-1}) ')
title([strrep(M.basename,'_',' '),' ',M.mloc],'fontweight','bold')

subplot(312)
contourf(td0,zz,vvp,[-1:.05:1])
%shading interp
caxis([-0.25 0.25]);
colorbar('eastoutside')
ylabel('Z (m)')
axis([td0(1) td0(end) zz(1,1) 5]);
set(gca,'xticklabel',[]);
[xt,yt] = Z_lab('ll');
text(xt,yt,'V-prime (m s^{-1}) ')

subplot(313)
contourf(td0,zz,rhop,[-1:.05:1])
%shading interp
caxis([-.3 .3]);
colorbar('eastoutside')
hold on
ylabel('Z (m)')
axis([td0(1) td0(end) zz(1,1) 5]);
set(gca,'xticklabel',[]);
[xt,yt] = Z_lab('ll');
text(xt,yt,'rho-prime (kg m^{-3}) ','color','w')
xlabel(['Yearday ',ys])

