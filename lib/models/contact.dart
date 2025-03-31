class Contact {
  int? id; // id อาจเป็น null ถ้ายังไม่ได้สร้าง (ใช้สำหรับการอ้างอิงข้อมูลที่มีอยู่ในระบบ)
  String name; // ชื่อของผู้ติดต่อ
  String phone; // เบอร์โทรศัพท์ของผู้ติดต่อ

  // Constructor สำหรับสร้าง object Contact
  Contact({this.id, required this.name, required this.phone});

  // ฟังก์ชัน factory สำหรับแปลงข้อมูล JSON เป็น object Contact
  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'], // ดึงค่า id จาก JSON
      name: json['name'], // ดึงค่า name จาก JSON
      phone: json['phone'], // ดึงค่า phone จาก JSON
    );
  }

  // ฟังก์ชันสำหรับแปลง object Contact เป็น JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id, // ใส่ค่า id ลงใน JSON
      'name': name, // ใส่ค่า name ลงใน JSON
      'phone': phone, // ใส่ค่า phone ลงใน JSON
    };
  }
}