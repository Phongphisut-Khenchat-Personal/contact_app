import 'package:get/get.dart'; // ใช้สำหรับการจัดการ state และ routing ด้วย GetX
import '../models/contact.dart'; // นำเข้าโมเดล Contact
import '../services/api_service.dart'; // นำเข้า ApiService สำหรับการเรียกใช้งาน API
import 'package:flutter/material.dart'; // ใช้สำหรับ UI เช่น Colors และ EdgeInsets

class ContactController extends GetxController {
  var contactList = <Contact>[].obs; // รายการผู้ติดต่อแบบ Observable เพื่อให้ UI อัปเดตอัตโนมัติเมื่อข้อมูลเปลี่ยนแปลง
  final ApiService apiService = ApiService(); // อินสแตนซ์ของ ApiService สำหรับเรียกใช้งาน API

  @override
  void onInit() {
    fetchContacts(); // โหลดข้อมูลผู้ติดต่อเมื่อเริ่มต้น
    super.onInit();
  }

  // ดึงข้อมูลผู้ติดต่อทั้งหมด
  void fetchContacts() async {
    try {
      var contacts = await apiService.fetchContacts(); // เรียก API เพื่อดึงข้อมูลผู้ติดต่อ
      contactList.assignAll(contacts); // อัปเดตรายการผู้ติดต่อใน contactList
    } catch (e) {
      // แสดงข้อความแจ้งเตือนเมื่อเกิดข้อผิดพลาด
      Get.snackbar(
        'เกิดข้อผิดพลาด', // หัวข้อข้อความ
        e.toString(), // ข้อความแสดงข้อผิดพลาด
        snackPosition: SnackPosition.TOP, // ตำแหน่งของ Snackbar
        backgroundColor: Colors.redAccent, // สีพื้นหลังของ Snackbar
        colorText: Colors.white, // สีข้อความ
        margin: EdgeInsets.all(10), // ระยะขอบรอบ Snackbar
        borderRadius: 10, // ความโค้งมนของขอบ Snackbar
      );
    }
  }

  // เพิ่มผู้ติดต่อใหม่
  void addContact(String name, String phone) async {
    if (name.isEmpty || phone.isEmpty) {
      // ตรวจสอบว่าชื่อหรือเบอร์โทรว่างหรือไม่
      Get.snackbar(
        'ข้อผิดพลาด', // หัวข้อข้อความ
        'กรุณากรอกข้อมูลให้ครบ', // ข้อความแจ้งเตือน
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: EdgeInsets.all(10),
        borderRadius: 10,
      );
      return; // ยกเลิกการทำงานหากข้อมูลไม่ครบ
    }
    try {
      Contact newContact = Contact(name: name, phone: phone); // สร้าง object Contact ใหม่
      var contact = await apiService.createContact(newContact); // เรียก API เพื่อเพิ่มผู้ติดต่อใหม่
      contactList.add(contact); // เพิ่มผู้ติดต่อใหม่ใน contactList
      Get.snackbar(
        'สำเร็จ', // หัวข้อข้อความ
        'เพิ่มผู้ติดต่อ $name เรียบร้อยแล้ว', // ข้อความแจ้งเตือน
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.teal,
        colorText: Colors.white,
        margin: EdgeInsets.all(10),
        borderRadius: 10,
      );
    } catch (e) {
      // แสดงข้อความแจ้งเตือนเมื่อเกิดข้อผิดพลาด
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: EdgeInsets.all(10),
        borderRadius: 10,
      );
    }
  }

  // อัปเดตผู้ติดต่อ
  void updateContact(Contact contact) async {
    if (contact.name.isEmpty || contact.phone.isEmpty) {
      // ตรวจสอบว่าชื่อหรือเบอร์โทรว่างหรือไม่
      Get.snackbar(
        'ข้อผิดพลาด',
        'กรุณากรอกข้อมูลให้ครบ',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: EdgeInsets.all(10),
        borderRadius: 10,
      );
      return; // ยกเลิกการทำงานหากข้อมูลไม่ครบ
    }
    try {
      var updatedContact = await apiService.updateContact(contact); // เรียก API เพื่ออัปเดตผู้ติดต่อ
      int index = contactList.indexWhere((c) => c.id == contact.id); // ค้นหา index ของผู้ติดต่อที่ต้องการอัปเดต
      if (index != -1) contactList[index] = updatedContact; // อัปเดตข้อมูลใน contactList
      Get.snackbar(
        'สำเร็จ',
        'อัปเดตผู้ติดต่อ ${contact.name} เรียบร้อยแล้ว',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.teal,
        colorText: Colors.white,
        margin: EdgeInsets.all(10),
        borderRadius: 10,
      );
    } catch (e) {
      // แสดงข้อความแจ้งเตือนเมื่อเกิดข้อผิดพลาด
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: EdgeInsets.all(10),
        borderRadius: 10,
      );
    }
  }

  // ลบผู้ติดต่อ
  void deleteContact(int id) async {
    try {
      await apiService.deleteContact(id); // เรียก API เพื่อลบผู้ติดต่อ
      var deletedContact = contactList.firstWhere((c) => c.id == id); // ค้นหาผู้ติดต่อที่ถูกลบ
      contactList.removeWhere((contact) => contact.id == id); // ลบผู้ติดต่อออกจาก contactList
      Get.snackbar(
        'สำเร็จ',
        'ลบผู้ติดต่อ ${deletedContact.name} เรียบร้อยแล้ว',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.teal,
        colorText: Colors.white,
        margin: EdgeInsets.all(10),
        borderRadius: 10,
      );
    } catch (e) {
      // แสดงข้อความแจ้งเตือนเมื่อเกิดข้อผิดพลาด
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: EdgeInsets.all(10),
        borderRadius: 10,
      );
    }
  }
}