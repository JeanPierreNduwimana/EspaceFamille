import 'dart:math';

class AppService{
  AppService();

  //verification booléen de longueur maximale des description des tache
  String maximumString(String descrTache, int max){
    if(descrTache.length > max){
      String stringAEnvoyer = '';
      int index = 0;
      while(index < max){
        stringAEnvoyer += descrTache[index];
        index++;
      }
      return ('$stringAEnvoyer...');

    }else{
      return descrTache;
    }
  }

  String randomDefaultProfileImage(){
    //les images par default sont nommé de 1 à 5 .jpg
    //Donc on retourne un chiffre aléatoire correspondant à un image
    int imageName = Random().nextInt(4) + 1;
    return 'assets/images/default_profile_pictures/$imageName.jpg';
  }
}