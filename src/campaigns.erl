%% Author: franco
%% Created: Jun 1, 2012
%% Description: TODO: Add description to campaigns
-module(campaigns).

-export([campaigns/1]).

%% Actors
campaigns(Campaigns) -> 
  receive
    
  {bid, Bidder} ->
    Bidder ! { bid_all, Campaigns },
    campaigns(Campaigns)
    
  end.
