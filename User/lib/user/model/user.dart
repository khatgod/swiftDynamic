class User {
  String fname;
  String lname;
  String age;
  String email;
  String tel;
  String createDate;

  // constructor
  User(
    String fname,
    String lname,
    String email,
    String tel,
    String age,
    String createDate,
  ) {
    this.fname = fname;
    this.lname = lname;
    this.age = age;
    this.email = email;
    this.tel = tel;
    this.createDate = createDate;
  }
}
