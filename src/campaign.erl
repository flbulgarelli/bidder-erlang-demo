%% Author: franco
%% Created: May 30, 2012
%% Description: TODO: Add description to campaign
-module(campaign).

%%
%% Include files
%%
-import(lists).

%%
%% Exported Functions
%%
-export([campaign/2]).

%%
%% API Functions
%%
campaign(PositiveKeywords, NegativeKeywords) ->
  receive
    {bid, Publisher, Keywords} ->
      intersects(Keywords, PositiveKeywords) andalso
      Publisher ! {push_campaign, self()}
  end,
  campaign(PositiveKeywords, NegativeKeywords).

%%
%% Local Functions
%%
intersects(L1, L2) ->
  lists:any(fun(It) -> 
    lists:member(It, L1) end, L2).
