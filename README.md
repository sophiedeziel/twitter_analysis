twitter_analysis
================

Twitter Analysis est un ensemble de scripts permettant de faire un sampling de Twitter et de formater les donn�es. 

Les scripts sont �crits en Ruby et les fonctionnalit�s sont con�ues sp�cifiquement pour notre projet de recherche. Script.rb agr�ge les donn�es et les enregistre au format JSON telles qu'elles sont envoy�es par l'API de Twitter. convert_to_xml.rb utilise les donn�es du pr�c�dent script pour les convertir en un document XML lisible par le framework Carrot2.

Pr�requis
----------------------------

Les scripts ont �t� test�s avec Ruby 1.8.2 et sup�rieur. Les versions pr�c�dentes ne sont pas suport�es. Ruby est install� par d�faut sur Mac OS X et sur la plupart des distributions de Linux.

La librairie de Twitter est n�cessaire. Pour l'installer : 
    
    gem install 'Twitter'

