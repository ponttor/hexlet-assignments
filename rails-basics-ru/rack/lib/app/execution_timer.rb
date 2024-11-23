# frozen_string_literal: true

class ExecutionTimer
  def initialize(app)
    @app = app
  end

  def call(env)
    before = Time.now.to_f
    status, headers, prev_body = @app.call(env)
    after = Time.now.to_f
    diff = (after - before) * 1_000_000
    log_message = "App took #{diff.to_i} microseconds."
    next_body = prev_body.push('</br>', log_message)

    [status, headers, next_body]
  end
end
