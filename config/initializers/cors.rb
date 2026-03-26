Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do

    origins 'https://job-board-front-iota.vercel.app'

    # ローカル開発も一緒に使いたい場合はコメントを外す
    # origins 'https://job-board-front-iota.vercel.app',
    #         'http://localhost:3000',
    #         'http://127.0.0.1:3000'
    origins 'http://localhost:5173',
            'http://localhost:5174',
            'http://127.0.0.1:5173',
            'http://127.0.0.1:5174'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['Authorization', 'Content-Type'],
      max_age: 600
  end
end