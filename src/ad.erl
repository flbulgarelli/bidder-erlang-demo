%% Author: franco
%% Created: May 30, 2012
%% Description: TODO: Add description to ad
-module(ad).

-export([cpc_ad/1, cpm_ad/1]).
-record(cpm, {prints=0}).
-record(cpc, {prints=0, clicks=0}).

%% Actors
cpm_ad({Url}) ->
  ad({Url, #cpm{}}).

cpc_ad({Url}) ->
  ad({Url, #cpc{}}).

ad(St = {Url, Counter}) ->
  io:format('Ad ~w with counter ~w~n', [Url, Counter]),
  receive
  {bid, Bidder, Cpm} -> 
    Bidder ! {push_bid, self(), Url, ecpm(Counter, Cpm)},
    ad(St);
  
  clicked ->
    ad({Url, increment_clicked(Counter)});
    
  printed ->
    ad({Url, increment_printed(Counter)})
  end.

%% TODO usar cpm, incrementar el cpm, estrategias de escape
%% TODO unit testing
%% TODO mnesia
%% TODO code conventions

%% Private Functions
increment_clicked(Counter = #cpc{clicks=C}) ->
  Counter#cpc{clicks=C+1};
increment_clicked(Counter = #cpm{}) ->
  Counter.

increment_printed(Counter = #cpc{prints=P}) ->
  Counter#cpc{prints=P+1};
increment_printed(Counter = #cpm{prints=P}) ->
  Counter#cpm{prints=P+1}.

ecpm(Counter = #cpc{}, Cpm)
  -> Cpm * ctr(Counter);
ecpm(#cpm{}, Cpm)
  -> Cpm.

%FIXME este cofieciente fluctua mucho en los primero momentos
ctr(#cpc{prints=P, clicks=C}) ->
  C / P.