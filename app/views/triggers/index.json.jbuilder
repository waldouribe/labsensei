json.array!(@strategies) do |strategy|
  json.extract! strategy, :id, :parameter_kind_id, :klass, :function, :description
  json.url strategy_url(strategy, format: :json)
end
