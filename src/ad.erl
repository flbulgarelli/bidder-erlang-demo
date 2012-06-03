%% Author: franco
%% Created: May 30, 2012
%% Description: TODO: Add description to ad
-module(ad).

-import(common, [printed/1, clicked/1, ecpm/2]).
-export([ad/1]).
-include("base.hrl").

%% Actors
ad({Url}) ->
  receive
  {init, Package} ->
    ad({Url, #counter{}, Package})
  end;

ad(St = {Url, Counter, Package}) ->
  io:format('Ad ~w with counter ~w~n', [Url, Counter]),
  receive
    
  {bid, Campaign, Bidder } ->
    Bidder ! {push_bid, 
              #bid{url=Url, 
                   ecpm=ecpm(Counter, Package), 
                   ad=self(), 
                   campaign=Campaign } }, 
    ad(St);
  
  clicked ->
    ad({Url, clicked(Counter)});
    
  printed ->
    ad({Url, printed(Counter)})
  
  end.

%% TODO usar cpm, incrementar el cpm, estrategias de escape
%% TODO unit testing
%% TODO mnesia
%% TODO code conventions


