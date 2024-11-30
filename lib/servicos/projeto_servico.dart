import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_a3/modelos/modelos_projetos.dart';

class ProjetoServico {
  String userId;
  ProjetoServico() : userId = FirebaseAuth.instance.currentUser!.uid;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> adicionarTarefa (ModelosProjetos modelosProjetos) async {
    await _firestore.
    collection(userId).
    doc(modelosProjetos.id).
    set(modelosProjetos.toMap("tarefa"));
  }

  Future<void> adicionarLembrete (ModelosProjetos modelosProjetos) async {
    await _firestore.
    collection(userId).
    doc(modelosProjetos.id).
    set(modelosProjetos.toMap("lembrete"));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> conectarStreamTarefas(){
    return _firestore.collection(userId).orderBy("titulo").snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> conectarStreamLembretes(){
    return _firestore.collection(userId).orderBy("titulo").snapshots();
  }

  Future<void> removerTarefa({required String idTarefa}){
    return _firestore.collection(userId).doc(idTarefa).delete();
  }

  Future<void> removerLembrete({required String idLembrete}){
    return _firestore.collection(userId).doc(idLembrete).delete();
  }

}