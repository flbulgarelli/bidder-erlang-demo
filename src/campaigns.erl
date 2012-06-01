%% Author: franco
%% Created: Jun 1, 2012
%% Description: TODO: Add description to campaigns
-module(campaigns).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([campaigns/1]).

%%
%% API Functions
%%
campaigns({Campaigns}) -> 
  receive
    
  {bid, Bidder} ->
    Bidder ! { bid_all, Campaigns },
    campaigns({Campaigns})
    
  end.

%%
%% Local Functions
%%

