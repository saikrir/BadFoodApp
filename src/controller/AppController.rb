require 'sinatra'
require 'date'
require 'dm-core'
require 'dm-noisy-failures'
require_relative  '../dataAccess/BadFoodDAO'

class BadFoodController < Sinatra::Base

   set :public_folder,"#{Dir.pwd}/webContent"  
   set :logging, true
   set :views, "#{Dir.pwd}/views"

   get '/' do
       @bfes = BadFoodEntry.all()
       erb :BadFoodEntries
   end

   get '/new' do
       redirect("index.html")
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
      rescue DataMapper::SaveFailureError => e
         puts "#{e.resource.errors.inspect}" 
      end

    end

end
