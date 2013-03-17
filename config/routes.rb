CigarFinderWeb::Application.routes.draw do
  resources 'cigar_search_results'

  mount JasmineRails::Engine => "/specs" unless Rails.env.production?

  root to: 'main#index'
end
