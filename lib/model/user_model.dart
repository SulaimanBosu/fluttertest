

class UserModel {
  int? userId;
  String? name;
  String? lastname;
  String? phone;
  String? username;
  String? password;
  String? file;

  UserModel({
    this.userId,
    this.name,
    this.lastname,
    this.phone,
    this.username,
    this.password,
    this.file,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['User_id'];
    name = json['Name'];
    lastname = json['Lastname'];
    phone = json['Phone'];
    username = json['Username'];
    password = json['Password'];
    file = json['File'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User_id'] = this.userId;
    data['Name'] = this.name;
    data['Lastname'] = this.lastname;
    data['Phone'] = this.phone;
    data['Username'] = this.username;
    data['Password'] = this.password;
    data['File'] = this.file;
    return data;
  }
}
