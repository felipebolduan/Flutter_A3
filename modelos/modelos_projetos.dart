class modelosProjeto {
  String id;
  String titulo;
  String descricao;
  String data;
  String horario;

  modelosProjeto({
    required this.id, 
    required this.titulo, 
    required this.descricao,
    required this.data,
    required this.horario
    });
    
  modelosProjeto.fromMap(Map<String, dynamic> map): 
    id = map["id"], 
    titulo = map["titulo"], 
    descricao = map["descricao"], 
    data = map["data"], 
    horario = map["horario"];

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "titulo": titulo,
      "decricao": descricao,
      "data": data,
      "horario": horario,
    };
  }
}