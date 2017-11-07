Rails.application.config.middleware.use OmniAuth::Builder do
  # Datos de la aplicación para autenticarse mediante Google.
  # Por seguridad se deberían guardar en ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_SECRET"] respectivamente
  # pero por simplicidad lo dejaré explícito.
  provider :google_oauth2, '558250518047-f0hg8vqhhtvljvk0ka461sp1rjmokiol.apps.googleusercontent.com', '2sFT92P8R84Dww8N8nq6rr0R', access_type: 'online', name: 'google'
end