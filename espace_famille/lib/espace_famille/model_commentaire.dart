class Commentaire{

  int id = 0;
  int annonceId = 0;
  String utilisateur = '';
  String description = '';
  String dateCreation = '';
  int nbLike = 0;
  int nbCommentaire = 0;
  bool afficheSousCommentaire = false;
  List<Commentaire> commentaires = [];
  Commentaire(int _id, int _annonceId,String _utilisateur,
  String _description,
  String _dateCreation,
  int _nbLike,
  int _nbCommentaire){
    id = _id;
    annonceId = _annonceId;
    utilisateur = _utilisateur;
    description = _description;
    dateCreation = _dateCreation;
    nbLike = _nbLike;
    nbCommentaire = _nbCommentaire;
  }
}