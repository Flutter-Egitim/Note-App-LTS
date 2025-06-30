import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';

// Note list
ValueNotifier<List<Note>> noteListNotifier = ValueNotifier([]);

// is any loading
ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);

// is any error
ValueNotifier<bool> isErrorNotifier = ValueNotifier(false);
