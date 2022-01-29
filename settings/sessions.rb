# Session settings:
#
# Be sure to set your own session secret.

enable :sessions

set :session_secret, 'farscape123'

set :protection, except: :session_hijacking

