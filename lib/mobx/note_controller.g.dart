// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NoteData on _NoteDataBase, Store {
  Computed<List<Note>>? _$getNotesComputed;

  @override
  List<Note> get getNotes =>
      (_$getNotesComputed ??= Computed<List<Note>>(() => super.getNotes,
              name: '_NoteDataBase.getNotes'))
          .value;

  late final _$isPageLoadingAtom =
      Atom(name: '_NoteDataBase.isPageLoading', context: context);

  @override
  bool get isPageLoading {
    _$isPageLoadingAtom.reportRead();
    return super.isPageLoading;
  }

  @override
  set isPageLoading(bool value) {
    _$isPageLoadingAtom.reportWrite(value, super.isPageLoading, () {
      super.isPageLoading = value;
    });
  }

  late final _$notesAtom = Atom(name: '_NoteDataBase.notes', context: context);

  @override
  ObservableList<Note> get notes {
    _$notesAtom.reportRead();
    return super.notes;
  }

  @override
  set notes(ObservableList<Note> value) {
    _$notesAtom.reportWrite(value, super.notes, () {
      super.notes = value;
    });
  }

  late final _$getStorageDataAsyncAction =
      AsyncAction('_NoteDataBase.getStorageData', context: context);

  @override
  Future<dynamic> getStorageData() {
    return _$getStorageDataAsyncAction.run(() => super.getStorageData());
  }

  late final _$addNoteAsyncAction =
      AsyncAction('_NoteDataBase.addNote', context: context);

  @override
  Future<dynamic> addNote(Note note) {
    return _$addNoteAsyncAction.run(() => super.addNote(note));
  }

  late final _$updateNoteAsyncAction =
      AsyncAction('_NoteDataBase.updateNote', context: context);

  @override
  Future<dynamic> updateNote(Note note, String text) {
    return _$updateNoteAsyncAction.run(() => super.updateNote(note, text));
  }

  late final _$removeNoteAsyncAction =
      AsyncAction('_NoteDataBase.removeNote', context: context);

  @override
  Future<dynamic> removeNote(Note note) {
    return _$removeNoteAsyncAction.run(() => super.removeNote(note));
  }

  late final _$deleteAllAsyncAction =
      AsyncAction('_NoteDataBase.deleteAll', context: context);

  @override
  Future<dynamic> deleteAll() {
    return _$deleteAllAsyncAction.run(() => super.deleteAll());
  }

  late final _$_NoteDataBaseActionController =
      ActionController(name: '_NoteDataBase', context: context);

  @override
  void setPageLoaded() {
    final _$actionInfo = _$_NoteDataBaseActionController.startAction(
        name: '_NoteDataBase.setPageLoaded');
    try {
      return super.setPageLoaded();
    } finally {
      _$_NoteDataBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPageLoading() {
    final _$actionInfo = _$_NoteDataBaseActionController.startAction(
        name: '_NoteDataBase.setPageLoading');
    try {
      return super.setPageLoading();
    } finally {
      _$_NoteDataBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Iterable<Note> getNotesByCategory(Category category) {
    final _$actionInfo = _$_NoteDataBaseActionController.startAction(
        name: '_NoteDataBase.getNotesByCategory');
    try {
      return super.getNotesByCategory(category);
    } finally {
      _$_NoteDataBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<Note> getRecentNotes({int len = 5}) {
    final _$actionInfo = _$_NoteDataBaseActionController.startAction(
        name: '_NoteDataBase.getRecentNotes');
    try {
      return super.getRecentNotes(len: len);
    } finally {
      _$_NoteDataBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isPageLoading: ${isPageLoading},
notes: ${notes},
getNotes: ${getNotes}
    ''';
  }
}
