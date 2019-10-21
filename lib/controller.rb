# Les deux lignes suivantes ne sont plus nécessaires car elles sont
# déjà présentes dans le fichier config.ru
#require 'bundler'
#Bundler.require
require 'gossip'


class ApplicationController < Sinatra::Base
	#get '/' do
		#"<html><head><title>The Gossip Project</title></head><body><h1>Mon super site de gossip !</h1></body></html>"
	  # La ligne suivante va faire pointer la bonne route du fichier
	  # controller.rb vers le fichier index.erb.
	  # Donc si quelqu'un va sur '/', cela va afficher la view index.erb
	#  erb :index
	#end

  # Cette ligne va permettre d'exécuter le code la classe dans avoir
  # à écrire un "ApplictionController.new.perform"
  # Exécuter un fichier qui définit une classe, ça ne donne rien.
  # Il faut forcément l'exécution d'une méthode en bas de la classe
  # pour lancer le programme. C'est ce que fait cette ligne.
	#run! if app_file == $0

  # Lorsque l'utilisateur clique sur le lien et va sur '/gossips/new',
  # le programme le renvoie vers le fichier new_gossip.erb qui
  # contient le formulaire qui lui permettra de crée un nouveau potin
	get '/gossips/new/' do
		erb :new_gossip
	end

  # Quand l'utilisateur va sur la page d'URL /gossip/new/, le programme
  # crée un nouvel objet de la classe Gossip
  # et le sauvegarde dans le fichier gossip.csv
	post '/gossips/new/' do
		Gossip.new(params["gossip_author"], params["gossip_content"]).save

		# Après avoir crée un nouveau potin, le programme redirige l'utilisateur
		# vers la route '/' (page d'accueil) avec la commande suivante
		redirect '/'
  end

  # Quand l'utilisateur va sur la page dont l'URL est /gossip/new,
  # le programme affiche le contenu des puts dans le terminal
  #post '/gossips/new/' do
  #	puts 'Salut, je suis dans le serveur'
  #	puts "Ceci est le contenu du hash params : #{params}"
  #	puts "Trop bien ! Et ceci est ce que l'utilisateur a passé dans le champ gossip_author : #{params["gossip_author"]}"
  #	puts "De la bombe, et du coup ça, ça doit être ce que l'utilisateur a passé dans le champ gossip_content : #{params["gossip_content"]}"
  #	puts "Ca déchire sa mère, bon allez, je m'en vais du serveur, allez crever."
  #end

  get '/' do
  	# Lorsque l'utilisateur va sur la page d'URL '/', le programme
  	# le redirige vers la page dont le code html est contenu dans
  	# le fichier index.erb
  	# ET
  	# la méthode locals va permettre d'envoyer au fichier index.erb
  	# des variables que l'on utilisera. Ici il s'agit de l'array
  	# obtenu en faisant Gossip.all que l'on met dans la variable Ruby
  	# gossips.
  	erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/:id' do
  	#erb :show # Pas besoin de préciser le id
  	erb :show, locals: {gossips: Gossip.all.find(params['id'].to_i)}
  end

  get '/gossips/:id/edit' do
    erb :edit
  end

  post '/gossips/:id/edit' do
    # appel à la fonction update de la classe Gossip
    Gossip.update
  end
end