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
-export([campaign/3]).

%%
%% API Functions
%%
campaign(PositiveKeywords, NegativeKeywords, EnabledUrls) ->
  receive
    {bid, Publisher, Keywords, Url} ->
      lists:member(Url, EnabledUrls) andalso   
      intersects(Keywords, PositiveKeywords) andalso
      not intersects(Keywords, NegativeKeywords) andalso
      Publisher ! {push_campaign, self()}
  end,
  campaign(PositiveKeywords, NegativeKeywords, EnabledUrls).

%%
%% Local Functions
%%
intersects(L1, L2) ->
  lists:any(fun(It) -> 
    lists:member(It, L1) end, L2).
