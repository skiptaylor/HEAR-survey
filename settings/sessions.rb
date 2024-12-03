# Session settings:
#
# Be sure to set your own session secret.

enable :sessions

set :session_secret, '149e7d40e7b1b3e64775c262c0765022f373f6f5298a6784ea87247ad7261432!'

set :protection, except: :session_hijacking

