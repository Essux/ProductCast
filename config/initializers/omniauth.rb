Rails.application.config.middleware.use OmniAuth::Builder do
  # Datos de la aplicación para autenticarse mediante Google y Office 365.
  # Por seguridad se deberían guardar en ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_SECRET"] respectivamente
  # pero por simplicidad lo dejaré explícito.
  provider :google_oauth2, '558250518047-f0hg8vqhhtvljvk0ka461sp1rjmokiol.apps.googleusercontent.com', '2sFT92P8R84Dww8N8nq6rr0R', access_type: 'online', name: 'google'
  provider :microsoft_office365, '69477ec5-2509-4794-a136-9c08833d6d76', 'vCODF1482?uxuxulPYH8+<:', name: 'microsoft'
end