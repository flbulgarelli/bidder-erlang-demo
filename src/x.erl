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
-export([new/2, new/3]).

%%
%% API Functions
%%
new(ActorType, State) ->
  new(ActorType, ActorType, State).

new(ActorType, Constructor, State) ->
  spawn(ActorType, Constructor, [State]).

%%
%% Local Functions
%%

