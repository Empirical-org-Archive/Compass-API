EmpiricalGrammar::Application.routes.draw do

  Quill::API.endpoints.each do |endpoint, spec|
    sending = if spec.singular? then :resource else :resources end
    send sending, endpoint, controller: 'api', as: "api_#{endpoint}", endpoint: endpoint
  end
end
