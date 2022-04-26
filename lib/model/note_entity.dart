class Note {
  int id ;
  String title;
  String content;
  String dateTimeEdited;
  String dateTimeCreated;

  Note(
      {this.id = 8,
      this.title = '',
      this.content = '',
      this.dateTimeEdited = '',
      this.dateTimeCreated = ''});

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "title": this.title,
      "content": this.content,
      "dateTimeEdited": this.dateTimeEdited,
      "dateTimeCreated": this.dateTimeCreated,
    };
  }
}
