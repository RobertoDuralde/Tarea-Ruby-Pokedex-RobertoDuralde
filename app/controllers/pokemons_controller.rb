class PokemonsController < ApplicationController

  def index
    # function loads all pokemons of national region because the
    # pokedex national ID is 1
    begin
      url = Rails.configuration.api_url+'pokedex/1'
      response = RestClient.get url
      if response.code == 200
        # if response was successfully parse JSON
        response = JSON.parse(response)
        # get the values of all pokemons in the national region and paginate
        @pokemons = response["pokemon_entries"].paginate(:page => params[:page], :per_page => 12)
      else
        # if response code isn't succed, set a message to the user and show the view
        flash[:error] = 'Ocurrió un error en la consulta hacia pokeapi. Por favor, inténtalo nuevamente'
      end
    rescue
      #if an exception appears, set a message to the user and show the view
      flash[:error] = 'Ocurrió un error en la consulta hacia pokeapi. Por favor, inténtalo nuevamente'
    end
  end

  def show
    @id = params[:id] #id seleccionado en index

    #Hacemos el request de datos de la API para el pokemón seleccionado
    url_api = Rails.configuration.api_url+"pokemon/"+"#{@id}"
    @dataApi = JSON.parse(RestClient.get(url_api))

    #------------------- OBTENCIÓN DE DATOS ----------------------

    @poke_name = @dataApi["name"]

    @abilities = @dataApi["abilities"]
    n_abilities = @abilities.length

    @moves = @dataApi["moves"]
    n_moves = @moves.length

    @peso = @dataApi["weight"]
    @altura = @dataApi["height"]

    #Nombres de habilidades
    @ability_names = {}
    for i in (0...n_abilities)
      ab_name = @abilities[i]["ability"]["name"]
      @ability_names[i] = ab_name
    end
    #Pasamos los datos a una representación legible
    @ability_name_view = ((@ability_names.values).join(', ')).capitalize

    #Nombres de movimientos
    @move_names = {}
    for i in (0...n_moves)
      move_name = @moves[i]["move"]["name"]
      @move_names[i] = move_name
    end
    #Pasamos los datos a una representación legible
    @move_name_view = ((@move_names.values).join(', ')).capitalize
  end
end
