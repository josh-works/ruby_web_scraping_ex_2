require 'sinatra'

get '/' do
  quote = load_text_file
  p quote
  erb :default, locals: { quote: quote }
end


private

def load_text_file
  sentances = File.new('./sentances.txt').read.split("\n").sample
end