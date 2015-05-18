% lp_driver.m 9/26/2013 Parker MacCready
%
% This is code for making tidally-averaged versions of the history files
% from a ROMS run
%
% Using Godin filter (24, 24, 25 hr) with native netcdf language


clear; moor_start_user; %set global paths and directories

%% USER INPUT SECTION
runname = 'C2003';
indir = ['/Users/PM3/Documents/roms/output/',runname,'/'];
suffix = 'lp';
outdir = [Tdir.moor_out,runname,'_',suffix,'/'];
if 0
    outputTimebase = datenum(2003,6,15,12,0,0):1:datenum(2003,6,17,12,0,0);
    istart = 165; %set the start output file # if you wish to start mid-way through a run
else
    outputTimebase = []; % the default [] is 1 file per day at noon
    istart = 1;
end

%%
% set up the output directory
if exist(outdir,'dir'); rmdir(outdir,'s'); end;
disp(['Makin new output directory: ' outdir]); mkdir(outdir);

%get run information
run = roms_createRunDef(indir);

%% perform the low pass filter
tTotal = tic;
run.hislp = roms_godinfilt(run.his,outputTimebase,suffix,outdir,istart);
tElapsed = toc(tTotal);
disp('********************************')
disp(['Total elapsed time = ',num2str(tElapsed),' sec']);

