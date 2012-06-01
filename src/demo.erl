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
	Campaigns = x:new(campaigns, [
     x:new(campaign,{
        ['food'],
        ['poison'],
        ['clarin.com', 'lanacion.com'],
        [x:new(ad, cpm_ad, {'http://localhost/ad1'}),
         x:new(ad, cpm_ad, {'http://localhost/ad2'}),
         x:new(ad, cpm_ad, {'http://localhost/ad3'})],
        1.0 
     }),
     x:new(campaign,{
         ['food'],
         ['poison'],
         ['clarin.com', 'pagina12.com'],
         [x:new(ad, cpm_ad, {'http://localhost/ad4'}),
          x:new(ad, cpm_ad, {'http://localhost/ad5'})],
         2.0
    }),
     x:new(campaign,{
         ['cha cha cha'],
         [],
         ['lanacion.com'],
         [x:new(ad, cpm_ad, {'http://localhost/ad6'})],
         1.4
     }),
     x:new(campaign,{
         ['food'],
         ['science'], 
         ['infobae.com' ],
         [x:new(ad, cpm_ad, {'http://localhost/ad7'}),
          x:new(ad, cpm_ad, {'http://localhost/ad8'})],
         2.1
    })]),
	Bidder = x:new(bidder,{
               ['food', 'science'], 
               'clarin.com'
             }),
	Campaigns ! { bid, Bidder }.

%%
%% Local Functions
%%  

