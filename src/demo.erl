%% Author: franco
%% Created: May 30, 2012
%% Description: TODO: Add description to demo
-module(demo).

%%
%% Include files
%%
-import(campaign).
-import(publisher).

%%
%% Exported Functions
%%
-export([start/0]).

%%
%% API Functions
%%
start() -> 
	Campaigns = [
     new(campaign, [['food'],        ['poison'],   ['clarin.com',    'lanacion.com']]),
     new(campaign, [['food'],        ['poison'],   ['clarin.com',    'pagina12.com']]),
     new(campaign, [['cha cha cha'], [],           ['lanacion.com']]),
     new(campaign, [['food'],        ['science'],  ['infobae.com' ]])] , 
	APublisher = new(publisher, [['food', 'science'], 'clarin.com']),
	APublisher ! { bid_all, Campaigns }. 

%%
%% Local Functions
%%  
new(Mod, Args) ->
  spawn(Mod, Mod, Args).
