% moor_start_user.m  8/20/2013  Parker MacCready
%
% sets up paths and directories (in structure Tdir) for mooring code
% for the directory moor_user

addpath('../alpha');
Tdir = toolstart;
Tdir.moor_out = [Tdir.output,'moor_out/'];
if ~exist(Tdir.moor_out,'dir'); mkdir(Tdir.moor_out); end;

addpath([Tdir.tools 'moor/Z_functions']);
addpath([Tdir.tools 'moor/Z_plot_code']);
