%% Author: franco
%% Created: May 30, 2012
%% Description: TODO: Add description to page
-module(bidder).

-import(ad).

-export([bidder/1]).

%% Actors
bidder({Keywords, Url}) ->
  bidder({Keywords, Url, []});
bidder(St = {Keywords, Url, BestAdSt}) ->
  receive
    
  {bid_all, Campaigns} ->
    [Campaign ! { bid, self(), Keywords, Url} || Campaign <- Campaigns],
    bidder(St);
  
  {push_campaign, Campaign } -> 
	  io:format('campaing found ~w~n', [Campaign]),
    bidder(St);
    
  {push_ad, AdUrl, Ecpm} ->
    io:format('ad found ~w ~n', [AdUrl]),
	  do_push_ad(St, {AdUrl, Ecpm})
  
  after 2000 ->
    best_ad(BestAdSt)
  
  end.

%% Private Functions
do_push_ad({Keywords,Url,[]}, AdSt) ->
  bidder({Keywords, Url, [AdSt]});

do_push_ad(St = {Keywords, Url, [BestAdSt]}, AdSt) ->
  case  ecpm(AdSt) > ecpm(BestAdSt) of 
    true  -> bidder({Keywords, Url, [AdSt]});
    _     -> bidder(St)
  end.

ecpm({_, Ecpm}) -> Ecpm.

best_ad([]) -> 
 io:format('no matching ad found yet~n');
best_ad([BestAdSt]) ->
 io:format('best ad is ~w~n', [BestAdSt]).