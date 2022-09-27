require 'open-uri'
require 'net/http'

class GamesController < ApplicationController
  def new
    @items = Array.new
    @letters = 'abcdefghijklmnopqrstuvwxyz'.split('').shuffle.first(10)
    @letters.each do |letter|
      @items << letter
    end
  end

  def score
    @chars = params[:guess].split('')
    @letters = params[:items].split

    @included = @chars.all? do |char|
      @letters.include?(char)
    end

    if @included
      response = URI.open("https://wagon-dictionary.herokuapp.com/#{@chars.join}")
      parsedResponse = JSON.parse(response.read)
      @exist = parsedResponse["found"]
    end
  end
end

# récupérer la séquence de lettre tapées dans le form

# Passer de la vue les lettres permettant de générer la séquence (hidden_input)
  # name = letters - params[:letters]

# n'essi la séquence t pas égal aux lettres affichées => "Sorry but "@word" can't be built out of "@letters"

# si mot tapé inclu lettre de la séquence mais n'est n'est pas dans l'API => "Sorry but "@word" does not seem to be valid English word"
  # response = URI.open(monurl)

# réponse obtenue en JSON qu'on doit parser
# json = JSON.parse(response.read)
# p json
