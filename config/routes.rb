PlanCharacters::Application.routes.draw do
  # rubocop:disable LineLength

  # Main pages
  root to: 'main#index', as: :homepage

  # Info pages
  scope '/about' do
    get '/anon-login', to: 'main#anoninfo',    as: :anon_info
    get '/privacy',    to: 'main#privacyinfo', as: :privacy_info
    get '/attribution', to: 'main#attribution', as: :attribution_info
  end

  # User-centric stuff
  scope '/my' do
    get '/content',     to: 'main#dashboard', as: :dashboard
    get '/submissions', to: 'main#comingsoon'
  end

  # Sessions
  get '/login',  to: 'sessions#new',     as: :login
  post '/login',  to: 'sessions#create',  as: :login_process
  get '/logout', to: 'sessions#destroy', as: :logout

  # Users
  get '/register',     to: 'users#new',    as: :signup
  post '/register',     to: 'users#create', as: :signup_process
  get '/account',      to: 'users#edit',   as: :account
  patch '/register',     to: 'users#update', as: :account_process
  get '/be-anonymous', to: 'users#anonymous', as: :anonymous
  get '/anon-login',   to: 'users#anonymous_login', as: :anonymous_login

  # Planning
  scope '/plan' do
    # Characters
    get '/characters',         to: 'characters#index',   as: :character_list
    get '/characters/from/:universe', to: 'characters#index', as: :characters_by_universe
    get '/character/new',      to: 'characters#new',     as: :character_create
    post '/character/new',      to: 'characters#create',  as: :character_create_process
    get '/character/:id',      to: 'characters#show',    as: :character
    get '/character/:id/edit', to: 'characters#edit',    as: :character_edit
    patch '/character/:id',      to: 'characters#update',  as: :character_edit_process
    delete '/character/:id',      to: 'characters#destroy', as: :character_destroy

    # Equipment
    get '/equipment',          to: 'equipment#index',   as: :equipment_list
    get '/equipment/from/:universe', to: 'equipment#index', as: :equipment_by_universe
    get '/equipment/new',      to: 'equipment#new',     as: :equipment_create
    get '/equipment/new/:type_of', to: 'equipment#new',     as: :equipment_create_type
    post '/equipment/new',      to: 'equipment#create',  as: :equipment_create_process
    get '/equipment/:id',      to: 'equipment#show',    as: :equipment
    get '/equipment/:id/edit', to: 'equipment#edit',    as: :equipment_edit
    patch '/equipment/:id',      to: 'equipment#update',  as: :equipment_edit_process
    delete '/equipment/:id',      to: 'equipment#destroy', as: :equipment_destroy

    # Languages
    get '/languages',         to: 'languages#index',   as: :language_list
    get '/languages/from/:universe', to: 'languages#index',   as: :languages_by_universe
    get '/language/new',      to: 'languages#new',     as: :language_create
    post '/language/new',      to: 'languages#create',  as: :language_create_process
    get '/language/:id',      to: 'languages#show',    as: :language
    get '/language/:id/edit', to: 'languages#edit',    as: :language_edit
    patch '/language/:id',      to: 'languages#update',  as: :language_edit_process
    delete '/language/:id',      to: 'languages#destroy', as: :language_destroy

    # Locations
    get '/locations',         to: 'locations#index',   as: :location_list
    get '/locations/from/:universe', to: 'locations#index', as: :locations_by_universe
    get '/location/new',      to: 'locations#new',     as: :location_create
    post '/location/new',      to: 'locations#create',  as: :location_create_process
    get '/location/new/:type_of', to: 'locations#new',     as: :location_create_type
    get '/location/:id',      to: 'locations#show',    as: :location
    get '/location/:id/edit', to: 'locations#edit',    as: :location_edit
    patch '/location/:id',      to: 'locations#update',  as: :location_edit_process
    delete '/location/:id',      to: 'locations#destroy', as: :location_destroy

    # Magic
    get '/magic',          to: 'magic#index',   as: :magic_list
    get '/magic/from/:universe', to: 'magic#index', as: :magic_by_universe
    get '/magic/new',      to: 'magic#new',     as: :magic_create
    post '/magic/new',      to: 'magic#create',  as: :magic_create_process
    get '/magic/new/:type_of', to: 'magic#new',     as: :magic_create_type
    get '/magic/:id',      to: 'magic#show',    as: :magic
    get '/magic/:id/edit', to: 'magic#edit',    as: :magic_edit
    patch '/magic/:id',      to: 'magic#update',  as: :magic_edit_process
    delete '/magic/:id',      to: 'magic#destroy', as: :magic_destroy

    # Universes
    get '/universes',         to: 'universes#index',   as: :universe_list
    get '/universe/new',      to: 'universes#new',     as: :universe_create
    post '/universe/new',      to: 'universes#create',  as: :universe_create_process
    get '/universe/:id',      to: 'universes#show',    as: :universe
    get '/universe/:id/edit', to: 'universes#edit',    as: :universe_edit
    patch '/universe/:id',      to: 'universes#update',  as: :universe_edit_process
    delete '/universe/:id',      to: 'universes#destroy', as: :universe_destroy

    # Coming Soon TM
    get '/plots',     to: 'main#comingsoon'
  end

  # API Endpoints
  scope '/generate' do
    # General information

    # Character information
    scope '/character' do
      get '/age',               to: 'characters_generator#age'
      get '/bodytype',          to: 'characters_generator#bodytype'
      get '/eyecolor',          to: 'characters_generator#eyecolor'
      get '/facial-hair',       to: 'characters_generator#facialhair'
      get '/haircolor',         to: 'characters_generator#haircolor'
      get '/hairstyle',         to: 'characters_generator#hairstyle'
      get '/height',            to: 'characters_generator#height'
      get '/identifying-mark',  to: 'characters_generator#identifyingmark'
      get '/name',              to: 'characters_generator#name'
      get '/race',              to: 'characters_generator#race'
      get '/skintone',          to: 'characters_generator#skintone'
      get '/weight',            to: 'characters_generator#weight'
    end

    # Location information
    scope '/location' do
      get '/name',              to: 'locations_generator#name'
    end

    # Equipment location
    scope '/equipment' do
      scope '/weapon' do
        get '/',                to: 'equipment_generator#weapon'

        get '/axe',             to: 'equipment_generator#weapon_axe'
        get '/bow',             to: 'equipment_generator#weapon_bow'
        get '/club',            to: 'equipment_generator#weapon_club'
        get '/fist',            to: 'equipment_generator#weapon_fist'
        get '/flexible',        to: 'equipment_generator#weapon_flexible'
        # TODO: /gun
        get '/polearm',         to: 'equipment_generator#weapon_polearm'
        get '/shortsword',      to: 'equipment_generator#weapon_shortsword'
        get '/sword',           to: 'equipment_generator#weapon_sword'
        get '/thrown',          to: 'equipment_generator#weapon_thrown'
      end

      scope '/armor' do
        get '/',                to: 'equipment_generator#armor'

        get '/shield',          to: 'equipment_generator#armor_shield'
      end
    end
  end

  # Adoption Agency
  scope '/adoption' do
    get '/', to: 'main#comingsoon'
  end

  # Idea Market
  scope '/market' do
    get '/', to: 'main#comingsoon'
  end

  # Write
  scope '/write' do
    get '/lyrics',     to: 'main#comingsoon'
    get '/novel',      to: 'main#comingsoon'
    get '/nonfiction', to: 'main#comingsoon'
    get '/poetry',     to: 'main#comingsoon'
    get '/screenplay', to: 'main#comingsoon'
    get '/story',      to: 'main#comingsoon'
  end

  # Revise
  scope '/revise' do
    get '/checklists',          to: 'main#comingsoon'
    get '/analytics',           to: 'main#comingsoon'
    get '/peer-critiques',      to: 'main#comingsoon'
    get '/professional-review', to: 'main#comingsoon'
  end

  # Submit
  scope '/submit' do
    get '/blog',              to: 'main#comingsoon'
    get '/print-publishers',  to: 'main#comingsoon'
    get '/online-publishers', to: 'main#comingsoon'
  end

  # rubocop:enable LineLength
end
