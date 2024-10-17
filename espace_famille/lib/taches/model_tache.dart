class Tache {

  String descr = '';
  String img = '';
  List<String> sous_taches = [];

  Tache(String _descr, String _img, bool _sous_taches){
    descr = _descr;
    img = _img;
    if(_sous_taches){
      sous_taches = ['sous taches 1','sous taches 2','sous taches 3'];
    }
  }
}