import 'package:flutter/cupertino.dart';
import 'package:hello_world/binder/notes.dart';

class NoteNotifier with ChangeNotifier {
  List<Notes> _noteList = [];
}
