# Replace API_KEY and API_SECRET with the values you got from Twitter
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "MPx9e1Qnpsb3dKpNcijUGKfUS", "AKA3RPDzf5s8OJUn0H3VQTuRYNRCgi0cx6BNWYYlTFBkzWkvoI"
end