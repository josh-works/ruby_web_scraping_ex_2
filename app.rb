require 'sinatra'

get '/' do
  sentance = random_sentance
  sentances = load_text_file
  erb :default, locals: { 
    sentance: sentance,
    sentances: sentances
   }
end


private

def load_text_file
  @load_text_file ||= File.new('./sentances.txt').read.split("\n")
end

def random_sentance
  load_text_file.sample
end
