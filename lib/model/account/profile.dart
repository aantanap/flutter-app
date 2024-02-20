class Profile {
  String? emailAddress;
  String? password;
  String? confirmpassword;
  String? name;
  String? lName;
  String? tel;

  Profile(
      { this.emailAddress,
       this.password,
       this.confirmpassword,
       this.name,
       this.lName,
       this.tel});
      
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        emailAddress: json["emailAddress"] ?? "",
        password: json["password"] ?? "",
        confirmpassword: json["confirmpassword"] ?? "",
        name: json["name"] ?? "",
        lName: json["lName"] ?? "",
        tel: json["tel"] ?? "");
  }
  Map<String, dynamic> toJson() => {
        "emailAddress": emailAddress,
        "password": password,
        "confirmpassword": confirmpassword,
        "name": name,
        "lName": lName,
        "tel": tel,
      };
}