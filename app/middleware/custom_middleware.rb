class CustomMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    DevicesRepo.new.update_usage_time(env['HTTP_DEVICEID'])
    @app.call(env)
  end
end
