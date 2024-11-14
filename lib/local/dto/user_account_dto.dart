class UserAccountDto {
  String? id;
  String? pw;

  UserAccountDto({this.id, this.pw});

  @override
  String toString() {
    return "UserAccountDto(id=$id, pw=$pw)";
  }
}
