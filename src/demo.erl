%% Author: franco
%% Created: May 30, 2012
%% Description: TODO: Add description to demo
-module(demo).

%%
%% Include files
%%
-import(campaign).
-import(publisher).
-import(ad).

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
        [new(ad, {}),
         new(ad, {}),
         new(ad, {})] 
     }),
     new(campaign,{
         ['food'],
         ['poison'],
         ['clarin.com', 'pagina12.com'],
         [new(ad, {}),
          new(ad, {}),
          new(ad, {})]
    }),
     new(campaign,{
         ['cha cha cha'],
         [],
         ['lanacion.com'],
         [new(ad, {}),
          new(ad, {}),
          new(ad, {})]
     }),
     new(campaign,{
         ['food'],
         ['science'], 
         ['infobae.com' ],
         [new(ad, {}),
          new(ad, {}),
          new(ad, {})
       ]})],
	APublisher = new(publisher,{
                 ['food', 'science'], 
                 'clarin.com'
               }),
	APublisher ! { bid_all, Campaigns }. 

%%
%% Local Functions
%%  
new(Mod, State) ->
  spawn(Mod, Mod, [State]).
