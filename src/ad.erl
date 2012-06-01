%% Author: franco
%% Created: May 30, 2012
%% Description: TODO: Add description to ad
-module(ad).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([cpc_ad/1, cpm_ad/1]).

%%
%% API Functions
%%
cpm_ad({Url}) ->
  ad({Url, {0}}).

cpc_ad({Url}) ->
  ad({Url, {0, 0}}).

ad(St = {Url, Counter}) ->
  receive
  {bid, Bidder, Cpm} -> 
    Bidder ! {push_ad, Url, ad_ecpm(St, Cpm)};
  
  {clicked} ->
    ad({Url, increment_clicked(Counter)});
    
  {printed} ->
    ad({Url, increment_printed(Counter)})
  end,
  ad(St).


%% TODO usar cpm, incrementar el cpm, estrategias de escape
%%
%% Local Functions
%%
ad_ecpm({_, Counter}, Cpm) ->
  ecpm(Counter, Cpm).

increment_clicked({PrintCounter, ClickCounter}) ->
  {PrintCounter, ClickCounter+1};
increment_clicked(Counter) ->
  Counter.

increment_printed({PrintCounter, ClickCounter}) ->
  {PrintCounter+1, ClickCounter};
increment_printed({PrintCounter}) ->
  {PrintCounter+1}.

%% ecpm(Counter = {_, _}, Cpm)
%%   -> Cpm * ctr(Counter);
ecpm(_, Cpm)
  -> Cpm.

%% ctr({0, _}) -> 
%%   1;
%% ctr({PrintCount, ClickCount}) ->
%%   ClickCount/ PrintCount.