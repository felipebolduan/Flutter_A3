class ModelosProjetos {
  String id;
  String titulo;
  String descricao;
  String data;
  String horario;
  String tipo;

  ModelosProjetos({
    required this.id, 
    required this.titulo, 
    required this.descricao,
    required this.data,
    required this.horario,
    required this.tipo
    });
    
  ModelosProjetos.fromMap(Map<String, dynamic> map): 
    id = map["id"], 
    titulo = map["titulo"], 
    descricao = map["decricao"], 
    data = map["data"], 
    horario = map["horario"],
    tipo = map["tipo"];
    
  ModelosProjetos.fromObject(dynamic object): 
    id = object?.id, 
    titulo = object?.titulo, 
    descricao = object?.decricao, 
    data = object?.data, 
    horario = object?.horario,
    tipo = object?.tipo;

  Map<String, dynamic> toMap(tipo){
    return {
      "id": id,
      "titulo": titulo,
      "decricao": descricao,
      "data": data,
      "horario": horario,
      "tipo": tipo
    };
  }
}