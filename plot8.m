% plot8.m  8/20/2013  Parker MacCready
%
% this plots results from 8 years of hopefully-continuous output, and
% overlays some SciDAC runs

clear
close all
moor_start_user

% load the multi-year series
% NOTE these were all at RC
year_vec = [2002:2009];
TD = [];
ZETA = [];
T0 = []; T1 = [];
S0 = []; S1 = [];
for ii = 1:length(year_vec)
    year = year_vec(ii);
    switch year
        case 2002
            prefix = 'B';
        otherwise
            prefix = 'C';
    end
    load([Tdir.moor_out,'cascadia/',prefix,num2str(year),'_RC.mat']);
    for ii = 1:length(M)
        ind = ii;
        if strcmp(M(ii).mloc,'RN'); break; end;
    end
    TD = [TD, M(ind).td];
    ZETA = [ZETA, M(1).zeta];
    T0 = [T0, M(ind).temp(1,:)];
    T1 = [T1, M(ind).temp(end,:)];
    S0 = [S0, M(ind).salt(1,:)];
    S1 = [S1, M(ind).salt(end,:)];
end

% load  some 2005 runs
% NOTE these have all three RISE moorings

load([Tdir.moor_out,'SciDAC/J2005_RISE3.mat']);
for ii = 1:length(M)
    ind = ii;
    if strcmp(M(ii).mloc,'RN'); break; end;
end
TDJ = M(ind).td;
T0J = M(ind).temp(1,:);
T1J = M(ind).temp(end,:);
S0J = M(ind).salt(1,:);
S1J = M(ind).salt(end,:);

load([Tdir.moor_out,'SciDAC/Jcam2005_RISE3.mat']);
for ii = 1:length(M)
    ind = ii;
    if strcmp(M(ii).mloc,'RN'); break; end;
end
TDJcam = M(ind).td;
T0Jcam = M(ind).temp(1,:);
T1Jcam = M(ind).temp(end,:);
S0Jcam = M(ind).salt(1,:);
S1Jcam = M(ind).salt(end,:);

load([Tdir.moor_out,'SciDAC/Tpop2005_RN.mat']);
for ii = 1:length(M)
    ind = ii;
    if strcmp(M(ii).mloc,'RN'); break; end;
end
TDpop = M(ind).td;
T0pop = M(ind).temp(1,:);
T1pop = M(ind).temp(end,:);
S0pop = M(ind).salt(1,:);
S1pop = M(ind).salt(end,:);

%lh1 = plot(TD,Z_dasfilt(T0,'godin'),'-b',TD,Z_dasfilt(T1,'godin'),'-r');
lh1 = plot(TD,T0,'.b',TD,T1,'.r');
hold on
lh2 = plot(TDJ,Z_dasfilt(T0J,'godin'),'-c', ...
    TDJ,Z_dasfilt(T1J,'godin'),'-g');
lh3 = plot(TDJcam,Z_dasfilt(T0Jcam,'godin'), ...
    '-k',TDJcam,Z_dasfilt(T1Jcam,'godin'),'-m');
lh4 = plot(TDpop,Z_dasfilt(T0pop,'godin'), ...
    '-b',TDpop,Z_dasfilt(T1pop,'godin'),'-r','linewidth',2);
datetick
grid on
legend([lh1;lh2;lh3;lh4],'T0','T1','T0J','T1J','T0Jcam','T1Jcam', ...
    'T0pop','T1pop',0);
xlabel('Date')
ylabel('Temperature (deg C)');
title(['Top and Bottom Values at ',M(ind).mloc])

set(gcf,'position',[50 50 1000 400]);
set(gcf,'PaperPositionMode','auto');
print('-djpeg100',[Tdir.moor_out,'Temperature_compare.jpg']);

figure

%lh1 = plot(TD,Z_dasfilt(S0,'godin'),'-b',TD,Z_dasfilt(S1,'godin'),'-r');
lh1 = plot(TD,S0,'.b',TD,S1,'.r');
hold on
lh2 = plot(TDJ,Z_dasfilt(S0J,'godin'),'-c', ...
    TDJ,Z_dasfilt(S1J,'godin'),'-g');
lh3 = plot(TDJcam,Z_dasfilt(S0Jcam,'godin'), ...
    '-k',TDJcam,Z_dasfilt(S1Jcam,'godin'),'-m');
lh4 = plot(TDpop,Z_dasfilt(S0pop,'godin'), ...
    '-b',TDpop,Z_dasfilt(S1pop,'godin'),'-r','linewidth',2);
datetick
grid on
legend([lh1;lh2;lh3;lh4],'S0','S1','S0J','S1J','S0Jcam','S1Jcam', ...
    'S0pop','S1pop',0);
xlabel('Date')
ylabel('Salinity');
title(['Top and Bottom Values at ',M(ind).mloc])

set(gcf,'position',[50 50 1000 400]);
set(gcf,'PaperPositionMode','auto');
print('-djpeg100',[Tdir.moor_out,'Salinity_compare.jpg']);


