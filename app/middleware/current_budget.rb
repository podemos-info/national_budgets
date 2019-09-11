class CurrentBudget
  def initialize(app)
    @app = app
  end

  def call(env)
    env["current_budget"] = Budget.first
    @app.call(env)
  end
end
