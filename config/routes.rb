EmpiricalGrammar::Application.routes.draw do
  Quill::API.endpoints.each do |endpoint, _|
    resources endpoint, controller: 'api', as: "api_#{endpoint}", endpoint: endpoint
  end
end
