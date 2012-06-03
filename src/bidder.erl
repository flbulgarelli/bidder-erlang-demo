%% Author: franco
%% Created: May 30, 2012
%% Description: TODO: Add description to page
-module(bidder).

-export([bidder/1]).
-record(bid, {url, ecpm, ad, campaign}).

%% Variables: El sufijo St indica que es un record o tupla asociado a un actor. vale lo mismo para los campos de un struct 

%% Actors
%TODO remove superflous state
bidder({Keywords, Url}) ->
  bidder({Keywords, Url, []});
bidder(St = {Keywords, Url, Bid}) ->
  receive
  {bid_all, Campaigns} ->
    [Campaign ! { bid, self(), Keywords, Url} || Campaign <- Campaigns],
    bidder(St);
    
  {push_bid, Ad, AdUrl, Ecpm, Campaign} ->
    io:format('ad found ~w ~n', [AdUrl]),
	  do_push_bid(St, #bid{url=AdUrl, ecpm=Ecpm, ad=Ad, campaign=Campaign})
      
  after 2000 ->
    best_bid(Bid)
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