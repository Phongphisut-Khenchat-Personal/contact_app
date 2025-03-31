import 'dart:convert'; // ใช้สำหรับการแปลงข้อมูล JSON เป็น Dart object และในทางกลับกัน
import 'package:http/http.dart' as http; // ใช้สำหรับการทำงานกับ HTTP requests เช่น GET, POST, PUT, DELETE
import '../models/contact.dart'; // นำเข้าโมเดล Contact ซึ่งใช้แทนข้อมูลของ contact

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/users'; // URL หลักของ API ที่ใช้สำหรับการเรียกข้อมูล

  // อ่านข้อมูลทั้งหมด (Read)
  Future<List<Contact>> fetchContacts() async {
    // ส่ง HTTP GET request ไปยัง URL ที่กำหนดใน baseUrl
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      // หากสถานะการตอบกลับเป็น 200 (สำเร็จ)
      List jsonResponse = json.decode(response.body); // แปลงข้อมูล JSON ที่ได้จาก API เป็น List
      // แปลงแต่ละรายการใน JSON เป็น object Contact โดยใช้ฟังก์ชัน fromJson และคืนค่าเป็น List ของ Contact
      return jsonResponse.map((data) => Contact.fromJson(data)).toList();
    } else {
      // หากสถานะไม่ใช่ 200 จะโยนข้อผิดพลาด
      throw Exception('ไม่สามารถโหลดข้อมูลได้');
    }
  }

  // สร้างข้อมูลใหม่ (Create)
  Future<Contact> createContact(Contact contact) async {
    // ส่ง HTTP POST request ไปยัง URL ที่กำหนดใน baseUrl พร้อมข้อมูลในรูปแบบ JSON
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'}, // กำหนด Content-Type เป็น JSON
      body: json.encode(contact.toJson()), // แปลง object Contact เป็น JSON
    );
    if (response.statusCode == 201) {
      // หากสถานะการตอบกลับเป็น 201 (สร้างสำเร็จ)
      return Contact.fromJson(json.decode(response.body)); // แปลงข้อมูล JSON ที่ตอบกลับมาเป็น object Contact
    } else {
      // หากสถานะไม่ใช่ 201 จะโยนข้อผิดพลาด
      throw Exception('ไม่สามารถสร้างข้อมูลได้');
    }
  }

  // อัปเดตข้อมูล (Update)
  Future<Contact> updateContact(Contact contact) async {
    // ส่ง HTTP PUT request ไปยัง URL ที่กำหนดใน baseUrl พร้อมข้อมูลในรูปแบบ JSON
    final response = await http.put(
      Uri.parse('$baseUrl/${contact.id}'), // ใช้ ID ของ contact เพื่อระบุข้อมูลที่ต้องการอัปเดต
      headers: {'Content-Type': 'application/json'}, // กำหนด Content-Type เป็น JSON
      body: json.encode(contact.toJson()), // แปลง object Contact เป็น JSON
    );
    if (response.statusCode == 200) {
      // หากสถานะการตอบกลับเป็น 200 (สำเร็จ)
      return Contact.fromJson(json.decode(response.body)); // แปลงข้อมูล JSON ที่ตอบกลับมาเป็น object Contact
    } else {
      // หากสถานะไม่ใช่ 200 จะโยนข้อผิดพลาด
      throw Exception('ไม่สามารถอัปเดตข้อมูลได้');
    }
  }

  // ลบข้อมูล (Delete)
  Future<void> deleteContact(int id) async {
    // ส่ง HTTP DELETE request ไปยัง URL ที่กำหนดใน baseUrl พร้อม ID ของ contact ที่ต้องการลบ
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      // หากสถานะไม่ใช่ 200 จะโยนข้อผิดพลาด
      throw Exception('ไม่สามารถลบข้อมูลได้');
    }
  }
}