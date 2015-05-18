% plot_RN.m  8/20/2013  Parker MacCready
%
% this plots results for RN 2005, and overlays some SciDAC runs

clear; close all; moor_start_user

td0 = datenum(2005,1,1,0,0,0);

% get the RN observations
obs = load([Tdir.data,'RISE_Mooring_Data/Processed_new/rino2005.mat']);
TD{1} = obs.seacat.td;
DTH(1) = 24*(TD{1}(2) - TD{1}(1));
for zlev = 1:length(obs.seacat.z);
    Z{1,zlev} = obs.seacat.z(zlev); % {obs or which model, zlevel}
    S{1,zlev} = obs.seacat.salt(zlev,:);
    T{1,zlev} = obs.seacat.temp(zlev,:);
end


% mlist = {'OBSERVED','C2005_RN.mat','J2005_RISE3.mat', ...
%     'Jcam2005_RISE3.mat','Tpop2005_RN.mat', ...
%     'YH_2013May24_2005_RN.mat'};
mlist = {'OBSERVED','J2005_RISE3.mat', ...
    'Jcam2005_RISE3.mat','Tpop2005_RN.mat', ...
    'YH_2013Sep24_2005_RN.mat'};
mlist_alt = {'OBSERVED','Cascadia Base Run', ...
    'Base + CAM Reanalysis Forcing','Base + POP Reanalysis Forcing', ...
    'CAM+POP Reanalysis Forcing within CESM+ROMS'};

% for ii = 1:length(mlist)
%     mlist_alt{ii} = strrep(mlist{ii},'_',' ');
% end

for mm = 2:length(mlist)
    moor_file = mlist{mm};
    load([Tdir.moor_out,moor_file]);
    for ii = 1:length(M)
        ind = ii;
        if strcmp(M(ii).mloc,'RN'); break; end;
    end
    TD{mm} = M(ind).td; DTH(mm) = 24*(TD{mm}(2) - TD{mm}(1));
    z = M(ind).z_rho; ztop = M(ind).z_w(end,:);
    zz = [mean(z,2);mean(ztop)];
    for jj = 1:length(Z(1,:))
        zind = dsearchn(zz,Z{1,jj});
        Z{mm,jj} = zz(zind);
        S{mm,jj} = M(ind).salt(zind,:);
        T{mm,jj} = M(ind).temp(zind,:);
    end
end

%

Z_fig(10); lh = nan(length(mlist),1); cvec = 'krbgmcy';

for jj = 1:3 % which depth
    for vv = 1:2 % which variable
        npanel = vv + (jj-1)*2;
        subplot(3,2,npanel)
        for mm = [2:length(mlist) 1]
            if mm==1; lw = 3; else lw = 1; end
            if vv==1
            lh(mm,1) = plot(TD{mm}-td0,Z_jfilt(S{mm,4-jj}',round(100/DTH(mm)))', ...
                ['-',cvec(mm)],'linewidth',lw);
            ca = [24 34];
            else
            lh(mm,1) = plot(TD{mm}-td0,Z_jfilt(T{mm,4-jj}',round(100/DTH(mm)))', ...
                ['-',cvec(mm)],'linewidth',lw);
            ca = [4 18];
            end
            hold on
        end
        ylim(ca); xlim([0 365]);
        if npanel==5; legend(lh,mlist_alt,'location','southeast'); end;
        if npanel==1; title('RISE North Mooring 2005'); end;
        grid on
        if npanel==5 | npanel==6; xlabel('Yearday 2005'); end;
        if vv==1
            ylabel('Salinity');
        else
            ylabel('Temperature')
        end;
        [xt,yt] = Z_lab('ll');
        text(xt,yt,['Z = ',num2str(Z{1,4-jj}),' m '])
    end
end

set(gcf,'position',[10 10 1150 700]);
set(gcf,'paperpositionmode','auto');
print('-djpeg100','plot_RN.jpg')


