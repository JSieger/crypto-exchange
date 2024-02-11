require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do

    # build the API url, including the API key in the query string
    api_url = "http://api.coinlayer.com/api/live?access_key=#{ENV["COINLAYER_KEY"]}"
  
    # use HTTP.get to retrieve the API information
    raw_data = HTTP.get(api_url)
  
    # convert the raw request to a string
    raw_data_string = raw_data.to_s
  
    # convert the string to JSON
    parsed_data = JSON.parse(raw_data_string)
  
    # get the symbols from the JSON
    @symbols = parsed_data["rates"]
  
    # render a view template where I show the symbols
    erb(:homepage)
  end

  get("/:currency/:rate") do
    # build the API url, including the API key in the query string
    api_url = "http://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_KEY"]}"
  
    # use HTTP.get to retrieve the API information
    raw_data = HTTP.get(api_url)
  
    # convert the raw request to a string
    raw_data_string = raw_data.to_s
  
    # convert the string to JSON
    parsed_data = JSON.parse(raw_data_string)
  

    @currency = params.fetch("currency")

    @result = params.fetch("rate")
  
    erb(:currency)
  
  end
  