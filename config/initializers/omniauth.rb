Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'p5JvEGWJvGH3dZabtVLNPw', 'YrQJuRPa69MhJBjvcbhODFZDqpNMVlKY9hcd9JIteAM'
  provider :facebook, '218826714882166', '2450ea31aac399ce86155378d9ef69c2'
end