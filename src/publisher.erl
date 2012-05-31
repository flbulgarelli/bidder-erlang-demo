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
publisher(Keywords) ->
  receive
    {bid, Campaign} -> 
      Campaign ! { bid, self(), Keywords },
      publisher(Keywords);
    {bid_all, Campaigns} ->
			[self() ! {bid, It} || It <- Campaigns ];
    {push_campaign, Campaign } -> 
		  io:format('campaing found ~w~n', [Campaign]), 
		  publisher(Keywords);
    {push_ad, Ad } -> 
		  io:format('ad found ~w ~n', [Ad])
	end.

%%
%% Local Functions
%%

	
