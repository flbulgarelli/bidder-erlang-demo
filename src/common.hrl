%% Author: franco
%% Created: Jun 3, 2012
%% Description: TODO: Add description to counter
-record(bid, {url, ecpm, ad, campaign}).
-record(counter, {prints=0, clicks=0}).
-record(package, {mode, price, max}).