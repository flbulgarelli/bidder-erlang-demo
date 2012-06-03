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
-import(x, [new/2, new/3]).

%%
%% Exported Functions
%%
-export([start/0]).

%% 
%% API Functions
%% 
start() -> 
	Campaigns = new(campaigns, [
     new(campaign,{
        ['food'],
        ['poison'],
        ['clarin.com', 'lanacion.com'],
        [new(ad, cpm_ad, {'http://localhost/ad1'}),
         new(ad, cpm_ad, {'http://localhost/ad2'}),
         new(ad, cpm_ad, {'http://localhost/ad3'})],
        1.0 
     }),
     new(campaign,{
         ['food'],
         ['poison'],
         ['clarin.com', 'pagina12.com'],
         [new(ad, cpm_ad, {'http://localhost/ad4'}),
          new(ad, cpm_ad, {'http://localhost/ad5'})],
         2.0
    }),
     new(campaign,{
         ['cha cha cha'],
         [],
         ['lanacion.com'],
         [new(ad, cpm_ad, {'http://localhost/ad6'})],
         1.4
     }),
     new(campaign,{
         ['food'],
         ['science'], 
         ['infobae.com' ],
         [new(ad, cpm_ad, {'http://localhost/ad7'}),
          new(ad, cpm_ad, {'http://localhost/ad8'})],
         2.1
    })]),
	Bidder = new(bidder,{
               ['food', 'science'], 
               'clarin.com'
             }),
	Campaigns ! { bid, Bidder }.

%%
%% Local Functions
%%  

