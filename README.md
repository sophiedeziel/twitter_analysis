twitter_analysis
================

Twitter Analysis est un ensemble de scripts permettant de faire un sampling de Twitter et de formater les données. 

Les scripts sont écrits en Ruby et les fonctionnalités sont conçues spécifiquement pour notre projet de recherche. Script.rb agrège les données et les enregistre au format JSON telles qu'elles sont envoyées par l'API de Twitter. convert_to_xml.rb utilise les données du précédent script pour les convertir en un document XML lisible par le framework Carrot2.

Prérequis
----------------------------

Les scripts ont été testés avec Ruby 1.8.2 et supérieur. Les versions précédentes ne sont pas suportées. Ruby est installé par défaut sur Mac OS X et sur la plupart des distributions de Linux.

La librairie de Twitter est nécessaire. Pour l'installer : 
    
    gem install twitter
    
Ensuite, il faut des clés d'API de Twitter. Pour les obtenir, il faut créer une app sur [https://apps.twitter.com/], puis les entrer dans les variables d'environnement de votre ordinateur avec:

    export TWITTER_CONSUMER_KEY=votreclé
    export TWITTER_CONSUMER_SECRET=votreclésecrete
    
À noter que ces clés ne seront sauvegardées que temporairement dans votre terminal. Informez-vous sur votre système d'exploitation pour savoir comment modifier de façon permanente les variables d'environnement.

Utilisation
----------------------------

Le script d'agrégation requiert au minimum deux paramètres: ll'objectif à atteindre pour la taille du sample, puis la liste des mots-clés à chercher. Cet objectif est une approximation et dépend du volume de tweets récents présents sur Twitter.

Exemple d'exécution du script:

     ruby -r rubygems script.rb 1000 #tiger #wolf #raptor
 
 