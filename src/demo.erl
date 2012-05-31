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
     new(campaign, [['food'],        ['poison']]),
     new(campaign, [['food'],        ['poison']]),
     new(campaign, [['cha cha cha'], []]),
     new(campaign, [['food'],        ['science']])] , 
	APublisher = new(publisher, [['food', 'science']]),
	APublisher ! { bid_all, Campaigns }. 

%%
%% Local Functions
%%  
new(Mod, Args) ->
  spawn(Mod, Mod, Args).

