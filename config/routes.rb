CigarFinderWeb::Application.routes.draw do
  resource 'cigar_search'

  root to: 'main#index'
end
