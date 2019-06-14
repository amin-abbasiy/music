if Rails.env.test? then
   CarrierWave.configure do |config|
      config.enable_processing = false
   end
end