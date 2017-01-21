# config/initializers/recaptcha.rb
Recaptcha.configure do |config|
  config.site_key  = '6LewoRIUAAAAAKoJ8gMhdo1iIriKvZytKJx5UBhA'
  config.secret_key = '6LewoRIUAAAAAATXOlGlpS_YDB8wnx2MrQqHDEv8'
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
end