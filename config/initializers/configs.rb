APP_CONFIG = YAML.load_file(Rails.root.join('config', 'configs.yml'))[Rails.env] rescue {}
