import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'transfer_models.g.dart';

/// dart run build_runner build --delete-conflicting-outputs
///
@JsonSerializable()
class SignUpRequest {
  SignUpRequest(
      this.username, this.birthday, this.password, this.confirmPassword);

  String username;
  String birthday;
  String password;
  String confirmPassword;

  factory SignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
}

@JsonSerializable()
class LogInRequest {
  LogInRequest(this.username, this.password);

  String username;
  String password;

  factory LogInRequest.fromJson(Map<String, dynamic> json) =>
      _$LogInRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LogInRequestToJson(this);
}

@JsonSerializable()
class Member {
  Member(this.anniversary, this.avgStars, this.famId, this.id,
      this.profileDescr, this.profileImgUrl, this.username);

  DateTime anniversary;
  double avgStars;
  String famId;
  String id;
  String profileDescr;
  String profileImgUrl;
  String username;

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
  Map<String, dynamic> toJson() => _$MemberToJson(this);
}

@JsonSerializable()
class Food {
  Food(this.addedBy, this.dateAdded, this.description, this.imgUrl, this.id,
      this.isPurchased, this.name, this.quantity);

  String addedBy;
  @TimestampConverter() // Use a custom converter
  DateTime dateAdded;
  String description;
  String id;
  String imgUrl;
  bool isPurchased;
  String name;
  int quantity;

  // Use JsonSerializable for automatic JSON serialization
  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);

  Map<String, dynamic> toJson() => _$FoodToJson(this);
}

// Custom converter to handle Timestamp -> DateTime conversion
class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

@JsonSerializable()
class SavedFood {
  SavedFood(this.imgUrl, this.id, this.name, this.quantity);

  String id;
  String imgUrl;
  String name;
  int quantity;

  factory SavedFood.fromJson(Map<String, dynamic> json) =>
      _$SavedFoodFromJson(json);
  Map<String, dynamic> toJson() => _$SavedFoodToJson(this);
}

///MOVED MODELS
///

class Annonce {
  int id = 0;
  String username = '';
  String description = '';
  String date = '';
  int Favs = 0;
  bool liked = true;
  int Comments = 0;
  String url = '';
  List<Commentaire> commentaires = [];

  Annonce(int _id, String _utilisateur, String _description,
      String _dateCreation, int _nbLike, int _nbCommentaire, String _url) {
    id = _id;
    username = _utilisateur;
    description = _description;
    date = _dateCreation;
    Favs = _nbLike;
    Comments = _nbCommentaire;
    url = _url;
  }
}

class Commentaire {
  int id = 0;
  int annonceId = 0;
  String utilisateur = '';
  String description = '';
  String dateCreation = '';
  int nbLike = 0;
  int nbCommentaire = 0;
  bool afficheSousCommentaire = false;
  bool afficheSectionReponse = false;
  List<Commentaire> commentaires = [];
  Commentaire(int _id, int _annonceId, String _utilisateur, String _description,
      String _dateCreation, int _nbLike, int _nbCommentaire) {
    id = _id;
    annonceId = _annonceId;
    utilisateur = _utilisateur;
    description = _description;
    dateCreation = _dateCreation;
    nbLike = _nbLike;
    nbCommentaire = _nbCommentaire;
  }
}

class Profile {
  String nom = '';
  String date = '';
  double nbEtoiles = 0;

  Profile(String _nom, String _date, double _nbEtoiles) {
    nom = _nom;
    date = _date;
    nbEtoiles = _nbEtoiles;
  }
}

class Tache {
  String descr = '';
  String img = '';
  List<String> sous_taches = [];

  Tache(String _descr, String _img, bool _sous_taches) {
    descr = _descr;
    img = _img;
    if (_sous_taches) {
      sous_taches = ['sous taches 1', 'sous taches 2', 'sous taches 3'];
    }
  }
}
