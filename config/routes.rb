CigarFinderWeb::Application.routes.draw do
  resources 'cigar_search_results', only: [:index, :create]
  get 'cigar_stores/nearby' => 'cigar_stores#nearby', as: :nearby_cigar_stores

  get '*anything' => 'main#index'
  root to: 'main#index'
end
