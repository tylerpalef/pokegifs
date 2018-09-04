class PokemonController < ApplicationController
    def show
      res = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")

      body = JSON.parse(res.body)
      name = body["name"]
      id = body["id"]
      type = find_type(body)

      res = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{params[:id]}=g")

      body = JSON.parse(res.body)
      gif_url = body["data"][0]["url"]

      render json: {
        "name" => name,
        "id" => id,
        "type" => type,
        "gif" => gif_url}


    end

    def find_type(body)
      type_str = []
      body["types"].map do |t|
        t["type"]["name"]
      end
    end


  end
