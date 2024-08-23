class UserDataClass {
  String? name;
  String? email;
  String? imageUrl;
  String? status;

  UserDataClass({this.name, this.email, this.imageUrl, this.status});

  UserDataClass.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    imageUrl = json['imageUrl'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['imageUrl'] = this.imageUrl;
    data['status'] = this.status;
    return data;
  }
}
