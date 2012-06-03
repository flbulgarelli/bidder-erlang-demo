%% Author: franco
%% Created: May 30, 2012
%% Description: TODO: Add description to campaign
-module(campaign).

-import(lists, [member/2, any/2]).
-import(common, [clicked/1, printed/1]).
-import(erlang, [append_element/2]).
-include("base.hrl").
-export([campaign/1]).

%% Actors
campaign(St) -> 
  campaign_(append_element(St, #counter{})).

campaign_(St = {PositiveKeywords, 
               NegativeKeywords, 
               EnabledUrls, 
               Ads, 
               Package, 
               Counter}) ->
  [Ad ! {init, Package} || Ad <- Ads],
  
  receive
  {bid, Bidder, Keywords, Url} ->
    member(Url, EnabledUrls) andalso   
    intersects(Keywords, PositiveKeywords) andalso
    not intersects(Keywords, NegativeKeywords) andalso
    [Ad ! {bid, self(), Bidder } || Ad <- Ads],
    campaign_(St);
  
  {clicked, Ad} ->
    Ad ! clicked,
    campaign_(counter(St, clicked(Counter)));

  {printed, Ad} ->
    Ad ! printed,
    campaign_(counter(St, printed(Counter)))
  
  end.


%% Private Functions
counter({PositiveKeywords, NegativeKeywords, EnabledUrls, Ads, Package, _}, Counter) ->
  {PositiveKeywords, NegativeKeywords, EnabledUrls, Ads, Package, Counter}.

intersects(L1, L2) ->
  any(fun(It) -> 
    member(It, L1) end, L2).
