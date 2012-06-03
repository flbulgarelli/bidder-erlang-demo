%% Author: franco
%% Created: May 30, 2012
%% Description: TODO: Add description to campaign
-module(campaign).

-import(lists, [member/2, any/2]).
-include("base.hrl").
-export([campaign/1]).

%% Actors
campaign(St = {PositiveKeywords, 
               NegativeKeywords, 
               EnabledUrls, 
               Ads, 
               Package}) ->
  [Ad ! {init, Package } || Ad <- Ads],
  
  receive
  {bid, Bidder, Keywords, Url} ->
    member(Url, EnabledUrls) andalso   
    intersects(Keywords, PositiveKeywords) andalso
    not intersects(Keywords, NegativeKeywords) andalso
    [Ad ! {bid, self(), Bidder } || Ad <- Ads];
  
  {clicked, Ad} ->
    Ad ! clicked;

  {printed, Ad} ->
    Ad ! printed
  
  end,
  campaign(St).

%% Private Functions
intersects(L1, L2) ->
  any(fun(It) -> 
    member(It, L1) end, L2).
