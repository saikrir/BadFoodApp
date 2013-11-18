require 'dm-core'
require 'dm-migrations'
require 'dm-mysql-adapter'
require 'dm-timestamps'
require 'dm-validations'

DataMapper.setup( :default, "mysql://web_admin:tempid1@raspberrypi/BAD_FOOD" )


    class BadFoodEntry
        include DataMapper::Resource

        property :id, Serial ,key: true, unique_index: true   
        property :dishName, String, :required => true
        property :ateWhere, String, :required => true
        property :ateWhen, String, :required => true
        property :firstTime, Boolean,:required => true
        property :symptoms, String,:required => true
        property :badIngredient, String,:required => true
        property :comments, String,:required => true
        #property :created_on, Date
        #property :updated_at, DateTime
    end

DataMapper.finalize
puts "Done!"
