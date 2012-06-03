%% Author: franco
%% Created: May 30, 2012
%% Description: TODO: Add description to campaign
-module(campaign).

-import(lists, [member/2, any/2]).
-import(common, [clicked/1, printed/1, complete/2]).
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
    do_counter_updated(St, Package, clicked(Counter));

  {printed, Ad} ->
    Ad ! printed,
    do_counter_updated(St, Package, printed(Counter))
  
  end.
%TODO end ads when campaign ends
%% Private Functions
do_counter_updated(St, Package, UpdatedCounter) ->
  case complete(UpdatedCounter, Package) of
    true -> io:format("campaign finished ~n"), ok;
    _    -> campaign_(counter(St, UpdatedCounter))  
  end.

counter(St, Counter) ->
  setelement(6, St, Counter).

intersects(L1, L2) ->
  any(fun(It) -> 
    member(It, L1) end, L2).
