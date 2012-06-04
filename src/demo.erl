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
-include("common.hrl").

%%
%% Exported Functions
%%
-export([start/0]).

%% 
%% API Functions
%% 
start() -> 
	Campaigns = [
     new(campaign,{
        ['food'],
        ['poison'],
        ['clarin.com', 'lanacion.com'],
        [new(ad,{'http://localhost/ad1'}),
         new(ad,{'http://localhost/ad2'}),
         new(ad,{'http://localhost/ad3'})],
        #package{mode=cpm, price=1.0, max=100}  
     }),
     new(campaign,{
         ['food'],
         ['poison'],
         ['clarin.com', 'pagina12.com'],
         [new(ad,{'http://localhost/ad4'}),
          new(ad,{'http://localhost/ad5'})],
         #package{mode=cpm, price=2.0, max=100}
    }),
     new(campaign,{
         ['cha cha cha'],
         [],
         ['lanacion.com'],
         [new(ad,{'http://localhost/ad6'})],
         #package{mode=cpm, price=1.4, max=100}
     }),
     new(campaign,{
         ['food'],
         ['science'], 
         ['infobae.com' ],
         [new(ad,{'http://localhost/ad7'}),
          new(ad,{'http://localhost/ad8'})],
         #package{mode=cpm, price=2.1, max=100}
    })],
	Bidder = new(bidder,{
               ['food', 'science'], 
               'clarin.com'
             }),
	Bidder ! {bid_all, Campaigns}.

%%
%% Local Functions
%%  

