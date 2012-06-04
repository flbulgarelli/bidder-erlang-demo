%% Author: franco
%% Created: Jun 3, 2012
%% Description: TODO: Add description to common
-module(common).

-include("common.hrl").
-export([ecpm/2, ctr/1, clicked/1, printed/1, complete/2]).

%% Private Functions
clicked(Counter = #counter{clicks=C}) ->
  Counter#counter{clicks=C+1}.

printed(Counter = #counter{prints=P}) ->
  Counter#counter{prints=P+1}.

ecpm(Counter, #package{mode=cpc, price=P})
  -> P * ctr(Counter);
ecpm(_, #package{mode=cpm, price=P})
  -> P.

%FIXME este cofieciente fluctua mucho en los primero momentos
ctr(#counter{prints=P, clicks=C}) ->
  C / P.

complete(#counter{clicks=C}, #package{mode=cpc, max=Max}) ->
  C >= Max;
complete(#counter{prints=P}, #package{mode=cpm, max=Max}) ->
  P >= Max.

