%% Author: franco
%% Created: Jun 1, 2012
%% Description: TODO: Add description to x
-module(x).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([new/2]).

%%
%% API Functions
%%
new(ActorType, State) ->
  spawn(ActorType, ActorType, [State]).

%%
%% Local Functions
%%

