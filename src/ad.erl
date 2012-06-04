%% Author: franco
%% Created: May 30, 2012
%% Description: TODO: Add description to ad
-module(ad).

-include("common.hrl").
-import(common, [printed/1, clicked/1, ecpm/2]).

-export([ad/1]).

%% Actors
ad({Url}) ->
  receive
  {init, Package} ->
    ad_({Url, #counter{}, Package})
  end.
ad_(St = {Url, Counter, Package}) ->
  io:format('Ad ~w with counter ~w~n', [Url, Counter]),
  receive
    
  {bid, Campaign, Bidder } ->
    Bidder ! {push_bid, 
              #bid{url=Url, 
                   ecpm=ecpm(Counter, Package), 
                   ad=self(), 
                   campaign=Campaign } }, 
    ad_(St);
  
  clicked ->
    ad_({Url, clicked(Counter), Package});
    
  printed ->
    ad_({Url, printed(Counter), Package})
  
  end.

%% TODO estrategias de escape
%% TODO unit testing
%% TODO mnesia
%% TODO code conventions
%% TODO usar records para el estado interno


