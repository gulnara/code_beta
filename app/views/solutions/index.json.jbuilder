json.array!(@solutions) do |solution|
  json.extract! solution, :id, :answer
  json.url solution_url(solution, format: :json)
end
