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
-export([publisher/2]).

%%
%% API Functions
%%
publisher(Keywords, Url) ->
  receive
    {bid_all, Campaigns} ->
      [ It ! { bid, self(), Keywords, Url } || It <- Campaigns],
      publisher(Keywords, Url);
    {push_campaign, Campaign } -> 
		  io:format('campaing found ~w~n', [Campaign]), 
		  publisher(Keywords, Url);
    {push_ad, Ad } -> 
		  io:format('ad found ~w ~n', [Ad])
	end.

%%
%% Local Functions
%%
