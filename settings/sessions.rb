# Session settings:
#
# Be sure to set your own session secret.

enable :sessions

set :session_secret, '6760e7d10526d965137df788e19f2a2a124511a9301b321164a63b5752f69c74'

set :protection, except: :session_hijacking

