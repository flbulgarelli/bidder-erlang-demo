%% Author: franco
%% Created: May 30, 2012
%% Description: TODO: Add description to demo
-module(demo).

%%
%% Include files
%%
-import(campaign).
-import(bidder).
-import(ad).
-import(x).

%%
%% Exported Functions
%%
-export([start/0]).

%% 
%% API Functions
%% 

start() -> 
	Campaigns = [
     x:new(campaign,{
        ['food'],
        ['poison'],
        ['clarin.com', 'lanacion.com'],
        [x:new(ad, {}),
         x:new(ad, {}),
         x:new(ad, {})] 
     }),
     x:new(campaign,{
         ['food'],
         ['poison'],
         ['clarin.com', 'pagina12.com'],
         [x:new(ad, {}),
          x:new(ad, {}),
          x:new(ad, {})]
    }),
     x:new(campaign,{
         ['cha cha cha'],
         [],
         ['lanacion.com'],
         [x:new(ad, {}),
          x:new(ad, {}),
          x:new(ad, {})]
     }),
     x:new(campaign,{
         ['food'],
         ['science'], 
         ['infobae.com' ],
         [x:new(ad, {}),
          x:new(ad, {}),
          x:new(ad, {})
       ]})],
	Bidder = x:new(bidder,{
               ['food', 'science'], 
               'clarin.com'
             }),
	Bidder ! { bid_all, Campaigns },
  Bidder.

%%
%% Local Functions
%%  

