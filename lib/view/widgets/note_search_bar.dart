import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:notes_sqflite_flutter/controller/notes_controller.dart';
import 'package:notes_sqflite_flutter/model/note_entity.dart';

import '../screens/note_details_screen.dart';

class NoteSearchbar extends SearchDelegate {
  final NotesController controller = Get.find<NotesController>();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.arrow_menu,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var suggestionList = query.isEmpty
        ? controller.notes
        : controller.notes.where((note) =>
            note.title.toLowerCase().contains(query.toLowerCase()) ||
            note.content.toLowerCase().contains(query.toLowerCase())).toList();

    return buildSuggestionsNotes(suggestionList);
  }

  Widget buildSuggestionsNotes(List<Note> notes) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: StaggeredGridView.countBuilder(
        itemCount: notes.length,
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => NoteDetailsScreen(), arguments: index);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(10, 10),
                      blurRadius: 15,
                    )
                  ]),
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notes[index].title,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    notes[index].content,
                    style: TextStyle(
                      fontSize: 17,
                    ),
                    maxLines: 6,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    notes[index].dateTimeEdited,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
