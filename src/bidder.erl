%% Author: franco
%% Created: May 30, 2012
%% Description: TODO: Add description to page
-module(bidder).

%%
%% Include files
%%
-import(ad).

%%
%% Exported Functions
%%
-export([bidder/1]).

%%
%% API Functions
%%
bidder({Keywords, Url}) ->
  bidder({Keywords, Url, []});
bidder(State = {Keywords, Url, BestAdState}) ->
  receive
  {bid_all, Campaigns} ->
    [Campaign ! { bid, self(), Keywords, Url} || Campaign <- Campaigns],
    bidder(State);
  
  {push_campaign, Campaign } -> 
	  io:format('campaing found ~w~n', [Campaign]),
    bidder(State);
  
  {push_ad, Ad, AdState} -> 
	  do_push_ad(Ad, AdState, State);
    
  {best_ad} ->
    best_ad(BestAdState),
    bidder(State)
  end.

%%
%% Local Functions
%%
do_push_ad(Ad, AdState, BidderState) ->
  io:format('ad found ~w ~n', [Ad]),
  do_push_ad_state(AdState, BidderState).


do_push_ad_state(AdState, {Keywords,Url,[]}) ->
  bidder({Keywords, Url, [AdState]});

do_push_ad_state(AdState, State = {Keywords,Url,BestAdState}) ->
  case  ad:ecpm(AdState) > ad:ecpm(BestAdState) of 
    true  -> bidder({Keywords, Url, [AdState]});
    _     -> bidder(State)
  end.

best_ad([]) -> 
 io:format('no matching ad found yet~n');
best_ad([BestAdState]) ->
 io:format('best ad is ~w~n', [BestAdState]).