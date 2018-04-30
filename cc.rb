require 'sinatra'
require 'sinatra/reloader'

#string, shift
#params["string"], params["shift"]

@@ciphered = ""

helpers do
  def caesar_cipher (string, number=0)
    (number > 26) ? number = number % 26 : number #prevent going over-boundary
    #a-z => 97-122, A-Z => 65-90
    def loop_back (chr_code, number) # z => a, Z => A
      ((chr_code + number > 122 && chr_code.between?(97,122)) ||
       (chr_code + number > 90 && chr_code.between?(65,90))) ?
        chr_code + number - 26 : chr_code + number
    end

    array = string.split('')
    array.collect! { |letter| (letter =~ /[\d\W]/) ? #if each letter is non-alphanumeric, skip, otherwise apply number
                     letter = letter : letter = loop_back(letter.ord, number).chr }
    array.join('')
  end
end

get '/' do
  
  if params[:string].nil?
    string = ""
    erb :index, :locals => {:string => string}
  else
    @@ciphered = caesar_cipher(params[:string],params[:shift].to_i)
    erb :index, :locals => {:string => string}
  end

end
