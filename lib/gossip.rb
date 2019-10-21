#require 'pry'
require 'csv'

class Gossip
	attr_accessor :author, :content

	def initialize(author, content)
    @author = author
    @content = content
    # gossip_author et gossip_content sont les champs des inputs contenus
    # dans le code html du fichier new_gossip.erb

	end

  # Méthode qui va sauvegarder les potins rentrés par l'utilisateur
  # dans le fichier gossip.csv
	def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
    	csv << [@author, @content]
    end
	end

  # Méthode qui met tous les potins (chaque ligne du fichier gossip.csv
  # contient un potin avec son auteur) dans le tableau all_gossips
	def self.all
		all_gossips = [] #on initialise un array vide

    # va chercher chacune des lignes du csv do
    CSV.read("./db/gossip.csv").each do |csv_line|
    	# crée un gossip avec les infos de la ligne all_gossips << gossip
    	# qui vient d'être créé
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end

    return all_gossips #on retourne un array rempli d'objets Gossip
  end

  # Fonction qui va récupérer le gossip correspondant à l'id donné en argument
  def find(id)
  	return Gossip.all[id]
  end
  
  # Fonction qui va permettre d'éditer un potin déjà existant
  def update
    # récupérer les donées du nouveau formulaire (fichier edit.erb)
    # les mettre à la place du potin voulu dans le fichier .csv
  end
end



