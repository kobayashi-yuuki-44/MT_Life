CarrierWave.configure do |config|
    if Rails.env.production?
      config.fog_provider = 'fog/aws'
      config.fog_credentials = {
        provider:              'AWS',
        aws_access_key_id:     'AWS_ACCESS_KEY_ID',
        aws_secret_access_key: 'AWS_SECRET_ACCESS_KEY',
        region:                'AWS_REGION',
      }
      config.fog_directory  = 'NAME_OF_BUCKET'
    end
  end