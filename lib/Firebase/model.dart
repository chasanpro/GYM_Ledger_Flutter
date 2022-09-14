

class model {
  // {amount: 65868, months: 35, full_name: dyxig i, dop: 2022-01-04 06:22:56, image_url: https://firebasestorage.googleapis.com/v0/b/dharims-886b0.appspot.com/o/Avatars%2FIMG_20211220_101609_compressed4404063825493176605.jpg?alt=media&token=d9d9363c-5cfb-43e5-b34a-66b903f89591, phone_num: 65,650680, doj: 2022-01-04 06:22:56}

  late String full_name;
  late String phone_num;

  // ignore: non_constant_identifier_names
  late String image_url;
  // DateTime dt2 =
  //     DateTime.parse(snapshot.data?.docs[index]['dop']);
  // var diff = now.difference(dt2);
  // int rd = diff.inDays;

  // int value =
  //     28 * int.parse(snapshot.data?.docs[index]['months']);

  // int d = value - rd;

  model();

  model.fromMap(Map<String, dynamic> data) {
    full_name = data['full_name'];
    phone_num = data['phone_num'];
    image_url = data['image_url'];
  }

  Map<String, dynamic> toMap() {
    return {
      'full_name': full_name,
      'phone_num': phone_num,
      'image_url': image_url
    };
  }
}
