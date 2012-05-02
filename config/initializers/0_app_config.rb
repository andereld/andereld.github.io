# This initializer loads sensitive constants into the APP_CONFIG hash from
# a YAML file kept out of version control. It should run prior to other
# initializers, hence the '0_' in the filename.

APP_CONFIG = YAML::load_file("#{Rails.root}/config/config.yml")
