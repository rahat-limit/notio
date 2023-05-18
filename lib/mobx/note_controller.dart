import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/models/Note.dart';
import 'package:project/services/sql_local_db.dart';
import 'package:mobx/mobx.dart';
part 'note_controller.g.dart';

class NoteData = _NoteDataBase with _$NoteData;

abstract class _NoteDataBase with Store {
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  User? currentUser = FirebaseAuth.instance.currentUser;

  @observable
  bool isPageLoading = false;

  @observable
  ObservableList<Note> notes = ObservableList<Note>.of([]);

  @computed
  List<Note> get getNotes => notes;

  Future deleteCloudData() async {
    final doc = usersCollection.doc(currentUser!.uid);
    await doc.delete();
  }

  Future setCloudData() async {
    List data = [];
    for (Note elem in notes) {
      data.add({
        'id': elem.id,
        'text': elem.text,
        'category': elem.category.index,
        'date': elem.datetime,
      });
    }
    final doc = usersCollection.doc(currentUser!.uid);
    await doc.get().then(
      (snap) async {
        if (snap.exists) {
          await doc.update({'notes': data});
        } else {
          await doc.set({'notes': data});
        }
      },
    );
  }

  @action
  Future getStorageData() async {
    await LocalStorage().getData().then((value) {
      notes.clear();
      notes.addAll(value);
    });
  }

  @action
  Future addNote(Note note) async {
    await LocalStorage().insert(note: note);
    notes.add(note);
    await setCloudData();
  }

  @action
  Future updateNote(Note note, String text) async {
    for (int i = 0; i < notes.length; i++) {
      if (notes[i] == note) {
        notes[i].text = text;
        notes[i].datetime = DateTime.now();
        await LocalStorage().updateRow(note: notes[i]);
      }
    }
    await setCloudData();
  }

  @action
  void setPageLoaded() {
    isPageLoading = true;
  }

  @action
  void setPageLoading() {
    isPageLoading = false;
  }

  @action
  Future removeNote(Note note) async {
    await LocalStorage().deleteRow(note.id);
    notes.remove(note);
    await setCloudData();
  }

  @action
  Future deleteAll() async {
    await LocalStorage().deleteAll();
    deleteCloudData();
    notes.clear();
  }

  @action
  Iterable<Note> getNotesByCategory(Category category) {
    Iterable<Note> items = [];
    items = notes.where(
      (element) => element.category == category,
    );
    return items;
  }

  @action
  List<Note> getRecentNotes({int len = 5}) {
    notes.sort(
      (a, b) => b.datetime.compareTo(a.datetime),
    );
    if (notes.length > len) {
      return notes.sublist(notes.length - len, notes.length);
    } else {
      return notes;
    }
  }
}
