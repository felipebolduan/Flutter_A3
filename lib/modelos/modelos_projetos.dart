class ModelosProjetos {
  String id;
  String titulo;
  String descricao;
  String data;
  String horario;

  ModelosProjetos({
    required this.id, 
    required this.titulo, 
    required this.descricao,
    required this.data,
    required this.horario
    });
    
  ModelosProjetos.fromMap(Map<String, dynamic> map): 
    id = map["id"], 
    titulo = map["titulo"], 
    descricao = map["decricao"], 
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