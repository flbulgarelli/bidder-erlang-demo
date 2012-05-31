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
-export([ad/1, ecpm/1]).

%%
%% API Functions
%%
ecpm(_) -> 10.

ad(State = {}) ->
  receive
    
  {bid, Publisher} -> 
    Publisher ! {push_ad, self(), State}
  
  end,
  ad(State).

%%
%% Local Functions
%%
