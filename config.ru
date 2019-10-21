# Fichier qui contient les informations nécessaires au lancement du serveur.

require 'bundler'
Bundler.require

#require './controller'

$:.unshift File.expand_path("./../lib", __FILE__)
require 'controller'

# On demande au serveur d'exécuter le contenu de la classe ApplicationController
run ApplicationController