twitter_analysis
================

Twitter Analysis est un ensemble de scripts permettant de faire un sampling de Twitter et de formater les données. 

Les scripts sont écrits en Ruby et les fonctionnalités sont conçues spécifiquement pour notre projet de recherche. Script.rb agrège les données et les enregistre au format JSON telles qu'elles sont envoyées par l'API de Twitter. convert_to_xml.rb utilise les données du précédent script pour les convertir en un document XML lisible par le framework Carrot2.

Prérequis
----------------------------

Les scripts ont été testés avec Ruby 1.8.2 et supérieur. Les versions précédentes ne sont pas suportées. Ruby est installé par défaut sur Mac OS X et sur la plupart des distributions de Linux.

La librairie de Twitter est nécessaire. Pour l'installer : 
    
    gem install 'Twitter'

