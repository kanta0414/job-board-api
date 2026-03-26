Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # ブラウザの preflight (OPTIONS) で返す CORS ヘッダが必要なため、
    # 実際にアクセス元として使うオリジンを明示的に許可します。
    origins 'https://job-board-front-iota.vercel.app',
            'http://localhost:5173',
            'http://localhost:5174',
            'http://127.0.0.1:5173',
            'http://127.0.0.1:5174'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['Authorization', 'Content-Type'],
      credentials: true,
      max_age: 86400
  end
end