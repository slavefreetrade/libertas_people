class TodoItem {
  String uid;
  final String description;

  TodoItem({this.uid, this.description});

  Map<String,dynamic> toMap() {
    return {
      "uid": this.uid,
      "description": this.description,
    };
  }
}
