import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Future<void> signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<List<Note>> fetchNotes() async {
    final snapshot = await _firestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('notes')
        .orderBy('createdAt', descending: true)
        .get();
    
    return snapshot.docs.map((doc) => Note.fromMap(doc.data(), doc.id)).toList();
  }

  Future<void> addNote(String text) async {
    await _firestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('notes')
        .add(Note(
          id: '',
          text: text,
          createdAt: DateTime.now(),
        ).toMap());
  }

  Future<void> updateNote(String id, String text) async {
    await _firestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('notes')
        .doc(id)
        .update({'text': text});
  }

  Future<void> deleteNote(String id) async {
    await _firestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('notes')
        .doc(id)
        .delete();
  }
}