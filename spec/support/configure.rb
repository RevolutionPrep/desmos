RSpec.configure do |config|
  config.before(:each) do
    Desmos::Configuration.domain  = 'api.tutortrove.com'
    Desmos::Configuration.version = 1
    Desmos::Configuration.key     = '111'
    Desmos::Configuration.secret  = 'abcde'
  end
end