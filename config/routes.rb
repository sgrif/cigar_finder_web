CigarFinderWeb::Application.routes.draw do
  resources 'cigar_search_results', only: :index do
    post 'report_carried', on: :collection
    post 'report_not_carried', on: :collection
  end

  resources 'cigars', only: :index

  resources 'cigar_stores', only: [] do
    member do
      get :missing_information
    end
  end

  get '*anything' => 'main#index'
  root to: 'main#index'
end
