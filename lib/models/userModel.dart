class Users {
  String first_name;
  String last_name;
  String access_token;

  Users(this.access_token, this.first_name, this.last_name);

  Users.fromJson(Map<dynamic, dynamic> json) {
    first_name = json["first_name"];
    last_name = json["last_name"];
    access_token = json["access_token"];

    print("USER FIRST NAME: $first_name");
    print("USER LAST NAME: $last_name");
    print("ACCESS TOKEN: $access_token");
  }
}