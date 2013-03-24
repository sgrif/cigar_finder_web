CigarFinderWeb::Application.routes.draw do
  resources 'cigar_search_results'
  get 'cigar_stores/nearby' => 'cigar_stores#nearby', as: :nearby_cigar_stores

  get '*anything' => 'main#index'
  root to: 'main#index'
end
