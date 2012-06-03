%% Author: franco
%% Created: May 30, 2012
%% Description: TODO: Add description to campaign
-module(campaign).

-import(lists, [member/2, any/2]).

-export([campaign/1]).

%% Actors
campaign(St = {PositiveKeywords, 
               NegativeKeywords, 
               EnabledUrls, 
               Ads, 
               Cpm}) ->
  receive
  {bid, Bidder, Keywords, Url} ->
    member(Url, EnabledUrls) andalso   
    intersects(Keywords, PositiveKeywords) andalso
    not intersects(Keywords, NegativeKeywords) andalso
    [Ad ! {bid, Bidder, Cpm} || Ad <- Ads]
  end,
  campaign(St).

%% Private Functions
intersects(L1, L2) ->
  any(fun(It) -> 
    member(It, L1) end, L2).
