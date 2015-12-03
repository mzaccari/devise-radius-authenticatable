Devise Radius Authenticatable
=============================

[![Gem Version](https://badge.fury.io/rb/devise-radius-authenticatable.png)](http://badge.fury.io/rb/devise-radius-authenticatable)
[![Build Status](https://travis-ci.org/mzaccari/devise-radius-authenticatable.png)](https://travis-ci.org/mzaccari/devise-radius-authenticatable)
[![Code Climate](https://codeclimate.com/github/cbascom/devise-radius-authenticatable.png)](https://codeclimate.com/github/cbascom/devise-radius-authenticatable)

Devise Radius Authenticatable is a Radius authentication strategy for [Devise](http://github.com/plataformatec/devise).

Dependencies
------------

- Rails ~> 3.x or 4.x
- Devise ~> 3.x
- radiustar ~> 0.0.8

Installation
------------

In the Gemfile for your application:

    gem "devise", "~> 3.2"
    gem "devise-radius-authenticatable"

Setup
-----

Run the rails generators for devise (please check the [devise](http://github.com/plataformatec/devise) documents for further instructions)

    rails generate devise:install
    rails generate devise MODEL_NAME

Run the rails generator for devise-radius-authenticatable.  Note that the generator is named with underscores instead of hyphens due to rails restrictions.

    rails generate devise_radius_authenticatable:install <IP> <SECRET> [options]

This will update the devise.rb initializer. The IP and SECRET parameters specify the IP address and shared secret for the radius server.  There are also some options you can pass to the generator to customize some default settings:

Options:

    [--uid-field=UID_FIELD]                                  # What database column to use for the UID
                                                             # Default: uid
    [--port=PORT]                                            # The port to connect to the radius server on
                                                             # Default: 1812
    [--timeout=TIMEOUT]                                      # How long to wait for a response from the radius server
                                                             # Default: 60
    [--retries=RETRIES]                                      # How many times to retry a radius request
                                                             # Default: 0
    [--dictionary-path=DICTIONARY_PATH]                      # The path to load radius dictionary files from
    [--handle-timeout-as-failure=HANDLE_TIMEOUT_AS_FAILURE]  # Option to handle radius timeout as authentication failure
                                                             # Default: false

Documentation
-------------

The rdocs for the gem are available here: http://rubydoc.info/github/mzaccari/devise-radius-authenticatable/master

Usage
-----

In order to use the radius_authenticatable strategy, you must modify your user model to use the :radius_authenticatable module.  The radius_authenticatable strategy can be used standalone or along with database_authenticatable and any other strategies you wish to include. If you use radius_authenticatable alongside other authentication strategies, the default order for the strategies is determined by the order they are loaded in.  The last loaded strategy will be the first strategy executed. The order of these strategies can be configured in the devise.rb initializer as follows:

    config.warden do |warden_config|
      warden_config.default_strategies(:database_authenticatable,
                                       :radius_authenticatable,
                                       {:scope => :admin})
    end

The radius_authenticatable strategy will stop warden from continuing to the next strategy if authentication to the radius server is successful, but will have warden continue to the next stratgey if authentication to the radius server fails.

The field that is used for logins is the first key that's configured in the Devise `config.authentication_keys` settings, which by default is email. For help changing this, please see the [Railscast](http://railscasts.com/episodes/210-customizing-devise) that goes through how to customize Devise.

Configuration
-------------

The radius_authenticatable module is configured through the normal devise initializer `config/initializers/devise.rb`.  The initial values are added to the file when you run the devise_radius_authenticatable:install generator as described previously.

Example:

```ruby
Devise.setup do |config|
  # ==> Configuration for radius_authenticatable
  # The radius_authenticatable strategy can be used in place of the
  # database_authenticatable strategy or alongside it.  The default order of the
  # strategies is the reverse of how they were loaded.  You can control this
  # order by explicitly telling warden the order in which to apply the strategies.
  # See the Warden Configuration section for further details.
  #
  # Configure the hostname or IP address of an individual radius server to use.
  # config.radius_server = '127.0.0.1'

  # Configure multiple radius servers with optional port.
  config.radius_servers = ['127.0.0.1:1812']

  # Configure the port to use when connecting to the radius server.
  config.radius_server_port = 1812

  # Configure the shared secret needed to connect to the radius server.
  config.radius_server_secret = 'testing123'

  # Configure the time in seconds to wait for a radius server to respond.
  config.radius_server_timeout = 10

  # Configure the number of times a request should be retried when a radius server
  # does not immediately respond to requests.
  config.radius_server_retries = 0

  # In some cases you may want to support authentication attempts against
  # multiple radius servers.  In these cases the same username could be used on
  # each of the servers.  In order to create unique database records, a unique
  # username is generated by using the radius username and the radius server IP
  # address once the authentication has succeeded.  This configuration option
  # allows you to chose which database column this calculated UID field will be
  # stored in.
  config.radius_uid_field = :username

  # If you want to control how the unique identifier is created for each radius
  # user, this can be customized by configuring a proc that accepts the username
  # and the radius server as parameters and returns the uid.
  #
  config.radius_uid_generator = Proc.new { |username, server| "#{username}" }

  # There is a very basic radius dictionary provided by default.  Most of the time
  # this will not be sufficient, so this configuration option allows you to
  # specify the path that contains all of the radius dictionary files that should
  # be loaded.
  #
  config.radius_dictionary_path = '/usr/share/freeradius/'

  # Option to handle radius timeout as authentication failure
  #
  config.handle_radius_timeout_as_failure = true
end
```

References
----------

* [FreeRadius](http://www.freeradius.org/)
* [Devise](http://github.com/plataformatec/devise)
* [Warden](http://github.com/hassox/warden)

Copyright (c) 2012-2013 Calvin Bascom Released under the MIT license
