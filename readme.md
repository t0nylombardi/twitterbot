Ruby Twitterbot
===========

This is a script to run a Twitterbot searching for one-word keywords that
users are tweeting about and replaying back with a set of predefined sententces.


Features
--------
* Works via Twitter's OAuth system.
* Handles search queries and replies to users
* Has a time limit so that Twitter does not block your tweets
* Easy to use way for updating and changing tweets

Is Writing Bots a Good Use of My Time?
======================================

Quick answer: if you're planning on being spammish on Twitter, you
should probably find something else to do. If you're planning on
writing a bot that isn't too rude or annoying, or that expects a
certain amount of opt-in from users, then you're probably good.


Using Twitterbot
================

Make a Developer Twitter account
----------------------
Before you setup a bot for the first time, you will need to register an
application with Twitter.  Twitter requires all API communication to be via an
app which is registered on Twitter. I would set one up and make it
part of twitterbot, but unfortunately Twitter doesn't allow developers
to publicly post the OAuth consumer key/secret that you would need to
use.  If you're planning to run more than one bot, you only need to do
this step once -- you can use the same app setup for other bots too. 

1. [Setup your own app](https://twitter.com/apps/new) on Twitter.

2. Put in whatever name, description, and website you want.

3. Take the api-key values, and enter them in lib/bot.rb. It should look like this:

         api_keys = {
  			consumer_key:        'CONSUMER KEY GOES HERE',
  			consumer_secret:     'CONSUMER SECRET GOES HERE',
  			access_token:        'ACCESS TOKEN GOES HERE',
  			access_token_secret: 'ACCESS TOKEN SECRET' }
 		          

You will need read and write access to these keys. 


Run TwitterBot
--------------

Run the script from within the folder. 

   	-> ruby init.rb tweets.txt keyword1 keyword2 keyword3 keyword4 

You can add all the keywords you want. Keywords must be oneword phrases: 
	
	hiphop nowplaying americanidol throwbackthursday sundayfunday 

That's it!

TwitterBot uses the the Twitter gem
(https://github.com/sferik/twitter) to handle the underlying API
calls. Any calls to the search/reply methods will return
Twitter::Status objects, which are basically extended hashes.

Tweets Text file
--------------
The text file that is included has bogus text in there comprised from:
(http://www.picksumipsum.co.uk/)
You can change the sentences to whatever you would like.  Each sentence
Should be less than 120 characters so that the username your tweeting
to can be included: 

	@randomName "sentemce thats less or equal to 120 charaters" 

Any new file should be put in the main directory and listed when running the file 

	-> ruby init.rb newfile.txt keyword1 keyword2 keyword3 keyword4 etc



Copyright/License
-----------------

Copyright (c) 2014 t0ny Shier. TwitterBot is distributed under a
modified WTFPL licence -- it's the 'Do what the fuck you want to --
but don't be an asshole' public license.  Please see LICENSE.txt for
further details. Basically, do whatever you want with this code, but
don't be an asshole about it.  If you spam users inappropriately,
expect your karma to suffer.


http://Jinsiisolutions.com
