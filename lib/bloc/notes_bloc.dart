import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/note.dart';
import '../services/firebase_service.dart';

abstract class NotesEvent {}
class LoadNotes extends NotesEvent {}
class AddNote extends NotesEvent {
  final String text;
  AddNote(this.text);
}
class UpdateNote extends NotesEvent {
  final String id;
  final String text;
  UpdateNote(this.id, this.text);
}
class DeleteNote extends NotesEvent {
  final String id;
  DeleteNote(this.id);
}

abstract class NotesState {}
class NotesInitial extends NotesState {}
class NotesLoading extends NotesState {}
class NotesLoaded extends NotesState {
  final List<Note> notes;
  NotesLoaded(this.notes);
}
class NotesError extends NotesState {
  final String message;
  NotesError(this.message);
}

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final FirebaseService _firebaseService;

  NotesBloc(this._firebaseService) : super(NotesInitial()) {
    on<LoadNotes>(_onLoadNotes);
    on<AddNote>(_onAddNote);
    on<UpdateNote>(_onUpdateNote);
    on<DeleteNote>(_onDeleteNote);
  }

  Future<void> _onLoadNotes(LoadNotes event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    try {
      final notes = await _firebaseService.fetchNotes();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _onAddNote(AddNote event, Emitter<NotesState> emit) async {
    try {
      await _firebaseService.addNote(event.text);
      add(LoadNotes());
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _onUpdateNote(UpdateNote event, Emitter<NotesState> emit) async {
    try {
      await _firebaseService.updateNote(event.id, event.text);
      add(LoadNotes());
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _onDeleteNote(DeleteNote event, Emitter<NotesState> emit) async {
    try {
      await _firebaseService.deleteNote(event.id);
      add(LoadNotes());
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }
}