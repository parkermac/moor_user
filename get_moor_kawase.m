% get_moor_kawase.m  1/29/2013  Parker MacCready
%
% This is for extracting the results of ROMS simulations, focused on
% time series at a point, over the full water column, as would be
% collected by a mooring.
%
% NOTE: this calls the extraction code:
% [M] = Z_get_moor(run,mlon,mlat);
% which uses the native matlab netcdf calls, and so is relatively fast.

%% designed for an extraction for Mitsuhiro Kawase


clear; close all; moor_start_user;

% &&&&&&&&&&& USER EDIT THIS &&&&&&&&&&&&&&

% create location vectors
a = [-122.6758,47.97024; ...
-122.6726,47.96909; ...
-122.6695,47.96785; ...
-122.666,47.96656; ...
-122.6624,47.96529; ...
-122.6588,47.96395; ...
-122.6552,47.96243; ...
-122.6516,47.96075; ...
-122.6478,47.95898; ...
-122.644,47.95717; ...
-122.6401,47.9554; ...
-122.6363,47.95358; ...
-122.6326,47.95161; ...
-122.6288,47.94952; ...
-122.6251,47.94738; ...
-122.6213,47.94525; ...
-122.6175,47.9431];

mlon = a(:,1);
mlat = a(:,2);

for ii = 1:length(mlon)
    mloc_list{ii} = ['HC',num2str(ii)];
end

tag = 'HC';

basename = 'salish_2006_4';
year = 2006;
indir = ['/pmraid1/daves/runs/',basename,'/OUT/'];
% &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

outfile = [Tdir.moor_out,basename,'_',tag,'.mat'];

% screen output
disp(' ')
disp('***************************************************')
disp(['indir = ',indir])
disp(['basename = ',basename])
for mmm = 1:length(mloc_list)
    disp(['mloc = ',mloc_list{mmm},', year = ',num2str(year)])
    disp([' ** lon = ',num2str(mlon(mmm)), ...
        ' lat = ',num2str(mlat(mmm))])
end
disp(['outfile = ',outfile])
disp('NOTE: run structure only saved in M(1)')
disp('---------------------------------------------------')

%% get the run definition
run = roms_createRunDef('my_run',indir);

% extract the mooring
[M] = Z_get_moor(run,mlon,mlat);

% add to the results structure
M(1).run = run;
M(1).basename = basename;
for mmm = 1:length(mloc_list)
    mloc = mloc_list{mmm};
    M(mmm).mloc = mloc;
end

% save the results
save(outfile,'M');
disp('---------------------------------------------------')

