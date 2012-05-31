%% Author: franco
%% Created: May 30, 2012
%% Description: TODO: Add description to page
-module(publisher).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([publisher/1]).

%%
%% API Functions
%%
publisher(State = {Keywords, Url}) ->
  receive
    {bid_all, Campaigns} ->
      [Campaign ! { bid, self(), Keywords, Url} || Campaign <- Campaigns],
      publisher(State);
    
    {push_campaign, Campaign } -> 
		  io:format('campaing found ~w~n', [Campaign]), 
		  publisher(State);
    
    {push_ad, Ad } -> 
		  io:format('ad found ~w ~n', [Ad]),
      publisher(State)
	end.

%%
%% Local Functions
%%
