
# Methods in this file need to be loaded first.
# This is because other initializers may depend on them.
# The funky filename?  Rails loads the initializers in alphabetical order.

def development?
  env_is('development')
end

def staging?
  env_is('staging')
end

def production?
  env_is('production')
end

def test?
  env_is('test')
end

def travis?
  env_is('travis')
end

def env_is(env)
  Rails.env == env
end
