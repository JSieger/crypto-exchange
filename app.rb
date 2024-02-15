require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

  get("/") do
    begin
      # Build the API URL, including the API key in the query string
      api_url = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest"
    
      # Set up the headers with your API key
      headers = {
        "X-CMC_PRO_API_KEY" => ENV["COINLAYER_KEY"] 
      }
    
      # Make the HTTP request to the API
      response = HTTP.headers(headers).get(api_url)
    
      # Check if the response is successful
      if response.code == 200
        # Convert the response body to JSON
        parsed_data = JSON.parse(response.body)
    
        # Extract the relevant data from the JSON response
        @symbols = parsed_data["data"].map { |currency| [currency["symbol"], currency["quote"]["USD"]["price"]] }.to_h
      else
        # Handle the case when the API request fails or returns an error
        @symbols = {} # Set to an empty hash or other default value
        # You might also want to display an error message to the user
      end
    rescue StandardError => e
      # Handle any exceptions that occur during the API request
      puts "Error fetching data from the API: #{e.message}"
      @symbols = {} # Set to an empty hash or other default value
      # You might also want to display an error message to the user
    end
    
    # Render a view template where you show the symbols
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
