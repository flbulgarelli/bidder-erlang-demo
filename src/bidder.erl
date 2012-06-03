%% Author: franco
%% Created: May 30, 2012
%% Description: TODO: Add description to page
-module(bidder).

-export([bidder/1]).

-include("base.hrl").

%% Variables: El sufijo St indica que es un record o tupla asociado a un actor. vale lo mismo para los campos de un struct 

%% Actors
%TODO remove superflous state
bidder({Keywords, Url}) ->
  bidder({Keywords, Url, []});
bidder(St = {Keywords, Url, BestBid}) ->
  receive
  {bid_all, Campaigns} ->
    [Campaign ! { bid, self(), Keywords, Url} || Campaign <- Campaigns],
    bidder(St);
    
  {push_bid, NewBid} ->
    io:format('ad found ~w ~n', [NewBid]),
	  do_push_bid(St, NewBid)
  after 2000 ->
    best_bid(BestBid)
  end.

%% Private Functions
do_push_bid({Keywords,Url,[]}, NewBid) ->
  bidder({Keywords, Url, [NewBid]});

do_push_bid(St = {Keywords, Url, [BestBid]}, NewBid) ->
  case  NewBid#bid.ecpm > BestBid#bid.ecpm of 
    true  -> bidder({Keywords, Url, [NewBid]});
    _     -> bidder(St)
  end.


best_bid([]) -> 
 io:format('no matching ad found yet~n');
best_bid([BestBid]) ->
 io:format('best bid is ~w~n', [BestBid]),
 BestBid#bid.campaign ! {printed, BestBid#bid.ad }.