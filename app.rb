require 'sinatra'

get '/' do
  paragraphs = load_text_file
  p paragraphs.first
  erb :default, locals: { paragraphs: paragraphs }
end


private

def load_text_file
  sentances = File.new('./sentances.txt').read.split("\n")
end