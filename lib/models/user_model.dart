class UserModel {
  String? id;
  String? name;
  String? email;
  String? phoneno;
  String? image;
  String? role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneno,
    required this.image,
    required this.role,
  });

  UserModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    email = map["email"];
    phoneno = map["phoneno"];
    image = map["image"];
    role = map["role"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phoneno": phoneno,
      "image": image,
      "role": role,
    };
  }

  static UserModel? loggedinUser;
  static String defaultImage =
      'https://th.bing.com/th/id/R.ff49e3f95086a5354150f6587f450760?rik=ZLkvQ%2bNSitShtw&pid=ImgRaw&r=0';

  // List<UserModel> defaultUsers = [
  //   UserModel(
  //     id: '1',
  //     name: 'Admin',
  //     email: 'admin@fmcgpro.com',
  //     phoneno: '01234561',
  //     image: defaultImage,
  //     role: 'admin',
  //   ),
  //   UserModel(
  //     id: '2',
  //     name: 'Dispatcher',
  //     email: 'user@fmcgpro.com',
  //     phoneno: '01234562',
  //     image: defaultImage,
  //     role: 'user',
  //   ),
  //   UserModel(
  //     id: '3',
  //     name: 'Driver',
  //     email: 'driver@fmcgpro.com',
  //     phoneno: '01234563',
  //     image: defaultImage,
  //     role: 'driver',
  //   ),
  // ];
}
