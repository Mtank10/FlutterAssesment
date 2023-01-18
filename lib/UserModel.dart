class UserModel {
  String? email;
  String? first_name;
  String? last_name;
  String? avatar;


  UserModel({
    String? email,
    String? first_name,
    String? last_name,
    String? avatar,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    avatar = json['avatar'];
    first_name = json['first_name'];
    last_name = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['avatar'] = avatar;
    data['first_name'] = first_name;
    data['last_name']=last_name;
    return data;
  }
}