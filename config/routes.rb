CigarFinderWeb::Application.routes.draw do
  resources 'cigar_search_results'

  root to: 'main#index'
end
