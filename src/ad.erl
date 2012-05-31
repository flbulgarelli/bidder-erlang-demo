%% Author: franco
%% Created: May 30, 2012
%% Description: TODO: Add description to ad
-module(ad).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([ad/1]).

%%
%% API Functions
%%
ad(State = {}) ->
  receive
    {bid, Publisher} -> 
      Publisher ! {push_ad, self()},
      ad(State)
  end.

%%
%% Local Functions
%%
ecpm(Cpm) -> Cpm.
