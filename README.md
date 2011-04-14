SessionVOC Session Store Example Webapp
=======================================

This is an example webapp intended for use with the SessionVOC Session Store.

The SessionVOC is a noSQL database optimized for the management of user sessions. Additionally the SessionVOC establishes security mechanisms that are difficult to implement with other session management systems. It depends on the actual scenario which of these functions has the highest priority.

For more information, check out:
http://www.worldofvoc.com/products/sessionvoc/summary/


Installation
------------

Tested on Ruby 1.8.7 (Rubygems 1.5.2) and Rails 3.0.5 and higher.
	
	[sudo] gem install bundler
	[sudo] gem install rails
	
Install the gem dependencies with bundler:

	cd <RAILS_ROOT>
	bundle install


Configuration
-------------

SessionVOC:

In order to use this Rails example webapp you need to have a working installation of SessionVOC. Example configurations for SessionVOC can be found in the "examples" directory. The "example.xml" is the configuration you need to run the tests and the "example.sql" contains the database schema.

Copy both files to the /tmp directory on your server or local machine and execute the following commands (as root):

 * cd /tmp
 * sevc example.xml
 * cp ./sessionvoc.so /usr/lib/sessionvoc/sessionvoc.so
 * /etc/init.d/sessionvoc restart
 * mysql -u root -p
   * create database sessionvoc;
   * exit
 * mysql -u root -p sessionvoc < example.sql

Checkout the SessionVOC Wiki for more information: http://www.worldofvoc.com/wiki/


Rails 3 Integration:

Please make sure that your SessionVOC installation configuration contains the `_csrf_token` attribute definition in "transData" (checkout example.xml).

Basic steps to perform within your Rails webapp:

 * Add the "sessionvoc-store" gem to your Gemfile
 * Create a "sessionvoc.yml" file in your config directory
 * Create a "session_store.rb" file in the "config/initializers" directory and add the following line (please fill in your app name):

	`{YOUR APP NAME}::Application.config.session_store :sessionvoc_store`

 * Add the following line to your application_controller.rb file:

	`before_filter :init_sessionvoc`

Usage
-----

Add the "sessionvoc-store" gem to your bundler Gemfile:

    gem 'sessionvoc-store'

Run "bundle install" if necessary.

Trying out the example webapp:

	cd <RAILS_ROOT>
	rails server
	
Open up your browser to "http://localhost:3000" and try out the examples.

The Login example is available at "http://localhost:3000/login"

	Username: testuser
	Password: tester


Examples
--------

Working with sessions:

	Setting a key/value pair from inside your controller action:

	session.set_trans_data(session['sid'], 'message', 'Hello from Rails!')
	session.set_user_data(session['sid'], 'name', 'Tes')

Getting a value from "transData"/"userData":

	puts session['transData']['message']
	puts session['userData]['name']

Authentification:

	success = session.login(session['sid'], 'testuser', 'tester')
	session.logout(session['sid'])

Working with forms:

	fid = session.new_form
	sessionvoc_form_data = session.get_form_data(fid)
	session.set_form_data(fid, sessionvoc_form_data)
	session.delete_form_data(fid)


Copyright
---------

Copyright (c) 2011 triAGENS GmbH. See LICENSE.txt for further details.

Author: Oliver Kiessler (kiessler@inceedo.com)
