CigarFinderWeb::Application.routes.draw do
  resources 'cigar_search_results'

  get '*anything' => 'main#index'
  root to: 'main#index'
end
