% get_moor_single.m  1/7/2014  Parker MacCready
%
% This is for extracting the results of ROMS simulations, focused on
% time series at a point, over the full water column, as would be
% collected by a mooring.
%
% NOTE: this calls the extraction code:
% [M] = Z_get_moor(run,mlon,mlat);
% which uses the native matlab netcdf calls, and so is relatively fast.

clear; close all; moor_start_user;

% &&&&&&&&&&& USER EDIT THIS &&&&&&&&&&&&&&
% First define the directory where the ROMS output files are.
% The "basename" is just a useful way of defining a run, and we use it in
% the code only for naming the "outfile"
basename = 'salish_2006_4';
indir = ['/Users/PM3/Documents/roms/output/',basename,'/'];
%indir = ['/pmraid1/daves/runs/',basename,'/OUT/'];
% The code allows you to extract from a bunch of mooring locations at once,
% and the cell array "mloc_list" is where you give names to each mooring.
% E.g. mloc_list = {'name1','name2'}; would allow two moorings.
mloc_list = {'Skagit'};
mlon = -122.4791;
mlat = 48.3464;
% The "tag" is just appended to the outfile name.
tag = 'Skagit';
% &&&&&&&&&&& END USER INPUT &&&&&&&&&&&&&&&

outfile = [Tdir.moor_out,basename,'_',tag,'.mat'];

% screen output
disp(' ')
disp('***************************************************')
disp(['indir = ',indir])
disp(['basename = ',basename])
for mmm = 1:length(mloc_list)
    disp(['mloc = ',mloc_list{mmm}])
    disp([' ** lon = ',num2str(mlon(mmm)), ...
        ' lat = ',num2str(mlat(mmm))])
end
disp(['outfile = ',outfile])
disp('NOTE: run structure only saved in M(1)')
disp('---------------------------------------------------')

% get the run definition
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

