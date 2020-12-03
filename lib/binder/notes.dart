class Notes {
  String id;
  String status;
  String binder;
  String image;

  Notes.fromMap(Map<String, dynamic> data) {
    id = data["id"];
    status = data["status"];
    binder = data["binder"];
    image = data["image"];
  }
}
