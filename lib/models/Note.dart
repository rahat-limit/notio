// ignore: file_names
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

// ignore: must_be_immutable
class Note extends Equatable {
  final String id;
  String text;
  Category category;
  DateTime datetime;
  Note({
    required this.text,
    this.category = Category.simple,
    required this.datetime,
    String? id,
  }) : id = id ?? uuid.v4();
  factory Note.updateNote(Note previousNote, String text) {
    return Note(
        id: previousNote.id,
        text: text,
        category: previousNote.category,
        datetime: previousNote.datetime);
  }
  factory Note.init() {
    return Note(
        id: '-1',
        text: '',
        category: Category.simple,
        datetime: DateTime(2017, 9, 7, 17, 30));
  }
  @override
  List<Object> get props => [id];
}

enum Category {
  simple,
  plans,
  travel,
  recipes,
  work,
}

Category identifyByIndex(int index) {
  Category category;
  switch (index) {
    case 0:
      category = Category.simple;
      break;
    case 3:
      category = Category.recipes;
      break;
    case 2:
      category = Category.travel;
      break;
    case 1:
      category = Category.plans;
      break;
    case 4:
      category = Category.work;
      break;
    default:
      category = Category.simple;
      break;
  }
  return category;
}

String identifyTitleByCategory(Category category) {
  String title = '';
  switch (category) {
    case Category.simple:
      title = 'Simple Notes:';
      break;
    case Category.recipes:
      title = 'Recipes:';
      break;
    case Category.travel:
      title = 'Travel:';
      break;
    case Category.plans:
      title = 'Plans:';
      break;
    case Category.work:
      title = 'Work:';
      break;
    default:
      title = 'Other';
      break;
  }
  return title;
}

String identifyIconByCategory(Category category) {
  String iconPath = '';
  switch (category) {
    case Category.simple:
      iconPath = 'assets/icons/note_icon.png';
      break;
    case Category.recipes:
      iconPath = 'assets/icons/cook_icon.png';
      break;
    case Category.travel:
      iconPath = 'assets/icons/travel_icon.png';
      break;
    case Category.plans:
      iconPath = 'assets/icons/goal_icon.png';
      break;
    case Category.work:
      iconPath = 'assets/icons/worker.png';
      break;
    default:
      iconPath = 'assets/icons/note_icon.png';
      break;
  }
  return iconPath;
}
