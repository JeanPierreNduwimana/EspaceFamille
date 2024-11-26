import 'model_commentaire.dart';

class Annonce {

  int id = 0;
  String username = '';
  String description = '';
  String date = '';
  int Favs = 0;
  int Comments = 0;
  String url = '';
  List<Commentaire> commentaires = [];

  Annonce(int _id,
  String _utilisateur,
  String _description,
  String _dateCreation,
  int _nbLike,
  int _nbCommentaire,
  String _url){

    id = _id;
    username = _utilisateur;
    description = _description;
    date = _dateCreation;
    Favs = _nbLike;
    Comments = _nbCommentaire;
    url = _url;

  }



}