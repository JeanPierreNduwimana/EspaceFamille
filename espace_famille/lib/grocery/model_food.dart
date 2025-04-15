class Food {
  //String alimentKey = '';
  String nom = '';
  //String description = '';
  //String dateAjout = '';
  int quantite = 0;
  bool validerAchat = false;
  //String imageUri = '';
  //bool alimentauto = false;

  /*Aliment(String Nom, String _description, int Quantite,bool ValiderAchat, String _imageUri, String _dateAjout, bool _alimentauto){

    nom = Nom;
    description = _description;
    quantite = Quantite;
    validerAchat = ValiderAchat;
    imageUri = _imageUri;
    dateAjout = _dateAjout;
    alimentauto = _alimentauto;

  } */

  Food(String Nom, int Quantite, bool ValiderAchat) {
    nom = Nom;
    quantite = Quantite;
    validerAchat = ValiderAchat;
  }
}
