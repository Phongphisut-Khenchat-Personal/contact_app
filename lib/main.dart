import 'package:flutter/material.dart'; // ใช้สำหรับการสร้าง UI
import 'package:get/get.dart'; // ใช้สำหรับการจัดการ state และ routing ด้วย GetX
import 'controllers/contact_controller.dart'; // นำเข้า ContactController สำหรับการจัดการข้อมูลผู้ติดต่อ
import 'models/contact.dart'; // นำเข้าโมเดล Contact

void main() {
  runApp(MyApp()); // เริ่มต้นแอปพลิเคชันด้วย MyApp
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Contact App', // ชื่อแอปพลิเคชัน
      theme: ThemeData(
        primarySwatch: Colors.teal, // ธีมสีหลักของแอป
        visualDensity: VisualDensity.adaptivePlatformDensity, // ปรับความหนาแน่นของ UI ให้เหมาะสมกับแพลตฟอร์ม
      ),
      home: ContactPage(), // หน้าแรกของแอปคือ ContactPage
    );
  }
}

class ContactPage extends StatelessWidget {
  final ContactController controller = Get.put(ContactController()); // สร้างและผูก ContactController กับ GetX

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'รายชื่อผู้ติดต่อ', // ชื่อหัวข้อใน AppBar
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 2, // ความสูงของเงาใต้ AppBar
        backgroundColor: Colors.teal, // สีพื้นหลังของ AppBar
      ),
      body: Obx(
        () => controller.contactList.isEmpty
            ? Center(
                child: Text(
                  'ไม่มีผู้ติดต่อ', // ข้อความแสดงเมื่อไม่มีผู้ติดต่อ
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.all(10), // ระยะขอบรอบ ListView
                itemCount: controller.contactList.length, // จำนวนรายการใน contactList
                itemBuilder: (context, index) {
                  var contact = controller.contactList[index]; // ดึงข้อมูลผู้ติดต่อแต่ละรายการ
                  return Card(
                    elevation: 3, // ความสูงของเงาใต้ Card
                    margin: EdgeInsets.symmetric(vertical: 5), // ระยะขอบแนวตั้งของ Card
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // ความโค้งมนของขอบ Card
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal.shade100, // สีพื้นหลังของ Avatar
                        child: Text(
                          contact.name[0].toUpperCase(), // ตัวอักษรแรกของชื่อผู้ติดต่อ
                          style: TextStyle(
                            color: Colors.teal, // สีตัวอักษร
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        contact.name, // ชื่อผู้ติดต่อ
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(contact.phone), // เบอร์โทรศัพท์ของผู้ติดต่อ
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min, // จำกัดขนาดของ Row ให้เล็กที่สุด
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.teal), // ไอคอนแก้ไข
                            onPressed: () => _showEditDialog(context, contact), // เรียกฟังก์ชันแก้ไข
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.redAccent), // ไอคอนลบ
                            onPressed: () => _confirmDelete(context, contact.id!), // เรียกฟังก์ชันยืนยันการลบ
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context), // เรียกฟังก์ชันเพิ่มผู้ติดต่อ
        backgroundColor: Colors.teal, // สีพื้นหลังของปุ่ม
        child: Icon(Icons.add, size: 30), // ไอคอนเพิ่ม
      ),
    );
  }

  // ฟังก์ชันยืนยันการลบ
  void _confirmDelete(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // ความโค้งมนของ AlertDialog
        title: Text(
          'ยืนยันการลบ', // หัวข้อข้อความ
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
        ),
        content: Text('คุณแน่ใจหรือไม่ว่าต้องการลบผู้ติดต่อนี้?'), // ข้อความยืนยัน
        actions: [
          TextButton(
            onPressed: () => Get.back(), // ปิด Dialog
            child: Text('ยกเลิก', style: TextStyle(color: Colors.grey)), // ปุ่มยกเลิก
          ),
          ElevatedButton(
            onPressed: () {
              controller.deleteContact(id); // ลบผู้ติดต่อ
              Get.back(); // ปิด Dialog
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent, // สีพื้นหลังของปุ่มลบ
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // ความโค้งมนของปุ่ม
              ),
            ),
            child: Text('ลบ'), // ข้อความในปุ่ม
          ),
        ],
      ),
    );
  }

  // ฟอร์มสำหรับเพิ่มผู้ติดต่อ
  void _showAddDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController(); // ตัวควบคุมสำหรับช่องกรอกชื่อ
    TextEditingController phoneController = TextEditingController(); // ตัวควบคุมสำหรับช่องกรอกเบอร์โทร
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // ความโค้งมนของ AlertDialog
        title: Text(
          'เพิ่มผู้ติดต่อ', // หัวข้อข้อความ
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min, // จำกัดขนาดของ Column ให้เล็กที่สุด
          children: [
            TextField(
              controller: nameController, // ช่องกรอกชื่อ
              decoration: InputDecoration(
                labelText: 'ชื่อ', // ป้ายกำกับ
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // ความโค้งมนของช่องกรอก
                ),
                prefixIcon: Icon(Icons.person), // ไอคอนในช่องกรอก
              ),
            ),
            SizedBox(height: 10), // ระยะห่างระหว่างช่องกรอก
            TextField(
              controller: phoneController, // ช่องกรอกเบอร์โทร
              decoration: InputDecoration(
                labelText: 'เบอร์โทร', // ป้ายกำกับ
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // ความโค้งมนของช่องกรอก
                ),
                prefixIcon: Icon(Icons.phone), // ไอคอนในช่องกรอก
              ),
              keyboardType: TextInputType.phone, // กำหนดประเภทคีย์บอร์ด
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(), // ปิด Dialog
            child: Text('ยกเลิก', style: TextStyle(color: Colors.grey)), // ปุ่มยกเลิก
          ),
          ElevatedButton(
            onPressed: () {
              controller.addContact(nameController.text, phoneController.text); // เพิ่มผู้ติดต่อใหม่
              Get.back(); // ปิด Dialog
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal, // สีพื้นหลังของปุ่มเพิ่ม
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // ความโค้งมนของปุ่ม
              ),
            ),
            child: Text('เพิ่ม'), // ข้อความในปุ่ม
          ),
        ],
      ),
    );
  }

  // ฟอร์มสำหรับแก้ไขผู้ติดต่อ
  void _showEditDialog(BuildContext context, Contact contact) {
    TextEditingController nameController = TextEditingController(text: contact.name); // ตัวควบคุมสำหรับช่องกรอกชื่อ
    TextEditingController phoneController = TextEditingController(text: contact.phone); // ตัวควบคุมสำหรับช่องกรอกเบอร์โทร
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // ความโค้งมนของ AlertDialog
        title: Text(
          'แก้ไขผู้ติดต่อ', // หัวข้อข้อความ
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min, // จำกัดขนาดของ Column ให้เล็กที่สุด
          children: [
            TextField(
              controller: nameController, // ช่องกรอกชื่อ
              decoration: InputDecoration(
                labelText: 'ชื่อ', // ป้ายกำกับ
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // ความโค้งมนของช่องกรอก
                ),
                prefixIcon: Icon(Icons.person), // ไอคอนในช่องกรอก
              ),
            ),
            SizedBox(height: 10), // ระยะห่างระหว่างช่องกรอก
            TextField(
              controller: phoneController, // ช่องกรอกเบอร์โทร
              decoration: InputDecoration(
                labelText: 'เบอร์โทร', // ป้ายกำกับ
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // ความโค้งมนของช่องกรอก
                ),
                prefixIcon: Icon(Icons.phone), // ไอคอนในช่องกรอก
              ),
              keyboardType: TextInputType.phone, // กำหนดประเภทคีย์บอร์ด
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(), // ปิด Dialog
            child: Text('ยกเลิก', style: TextStyle(color: Colors.grey)), // ปุ่มยกเลิก
          ),
          ElevatedButton(
            onPressed: () {
              contact.name = nameController.text; // อัปเดตชื่อผู้ติดต่อ
              contact.phone = phoneController.text; // อัปเดตเบอร์โทรผู้ติดต่อ
              controller.updateContact(contact); // เรียกฟังก์ชันอัปเดตผู้ติดต่อ
              Get.back(); // ปิด Dialog
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal, // สีพื้นหลังของปุ่มบันทึก
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // ความโค้งมนของปุ่ม
              ),
            ),
            child: Text('บันทึก'), // ข้อความในปุ่ม
          ),
        ],
      ),
    );
  }
}