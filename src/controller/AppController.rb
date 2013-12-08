require 'sinatra'
require 'json'
require 'date'
require_relative  '../dataAccess/BadFoodDAO'

class BadFoodController < Sinatra::Base

   set :public_folder,"#{Dir.pwd}/webContent"  
   set :logging, true
   set :views, "#{Dir.pwd}/views"

   get '/' do
       @bfes = BadFoodEntry.all()
       erb :BadFoodEntries
   end


   get '/BadFoodEntries.json' do
       content_type :json
       temp = BadFoodEntry.all().collect {|e| e.attributes }
       temp.to_json
   end

   get '/new' do
       redirect "index.html"
   end

    get '/entry/:id?' do |entry_id|
        content_type :json
        ret_hash = {}
        unless entry_id.nil?
            entry = BadFoodEntry.get(entry_id)
            unless entry.nil? 
                ret_hash = entry.attributes
            end
        end
        ret_hash.to_json
    end

    post '/entry' do
      bfe = BadFoodEntry.new
      bfe.dishName = params['dishName']
      bfe.ateWhere = params['ateWhere']
      bfe.ateWhen = Date.parse(params['ateWhen']) 
      bfe.firstTime = params['firstTime'] == 'on'
      bfe.symptoms = params['symptoms']
      bfe.badIngredient = params['badIngredient']
      bfe.comments = params['comments']
      bfe.raise_on_save_failure = true

      begin
           bfe.save
           @bfes = BadFoodEntry.all()
           redirect '/' 
      rescue 
          puts "Errors Occured when saving entry "
      end

    end

end
