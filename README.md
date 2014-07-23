twitter_analysis
================

Twitter Analysis est un ensemble de scripts permettant de faire un sampling de Twitter et de formater les donn�es. 

Les scripts sont �crits en Ruby et les fonctionnalit�s sont con�ues sp�cifiquement pour notre projet de recherche. Script.rb agr�ge les donn�es et les enregistre au format JSON telles qu'elles sont envoy�es par l'API de Twitter. convert_to_xml.rb utilise les donn�es du pr�c�dent script pour les convertir en un document XML lisible par le framework Carrot2.

Pr�requis
----------------------------

Les scripts ont �t� test�s avec Ruby 1.8.2 et sup�rieur. Les versions pr�c�dentes ne sont pas suport�es. Ruby est install� par d�faut sur Mac OS X et sur la plupart des distributions de Linux.

La librairie de Twitter est n�cessaire. Pour l'installer : 
    
    gem install twitter
    
Ensuite, il faut des cl�s d'API de Twitter. Pour les obtenir, il faut cr�er une app sur [https://apps.twitter.com/], puis les entrer dans les variables d'environnement de votre ordinateur avec:

    export TWITTER_CONSUMER_KEY=votrecl�
    export TWITTER_CONSUMER_SECRET=votrecl�secrete
    
� noter que ces cl�s ne seront sauvegard�es que temporairement dans votre terminal. Informez-vous sur votre syst�me d'exploitation pour savoir comment modifier de fa�on permanente les variables d'environnement.

Utilisation
----------------------------

Le script d'agr�gation requiert au minimum deux param�tres: ll'objectif � atteindre pour la taille du sample, puis la liste des mots-cl�s � chercher. Cet objectif est une approximation et d�pend du volume de tweets r�cents pr�sents sur Twitter.

Exemple d'ex�cution du script:

     ruby -r rubygems script.rb 1000 #tiger #wolf #raptor
 
 