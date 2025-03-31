# Contact App 📱

แอปพลิเคชันรายชื่อผู้ติดต่อที่พัฒนาด้วย Flutter และ GetX

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![GetX](https://img.shields.io/badge/GetX-37A4A0?style=for-the-badge&logo=getx&logoColor=white)

## 📋 คุณสมบัติหลัก

* แสดงรายชื่อผู้ติดต่อในรูปแบบ ListView 
* เพิ่มผู้ติดต่อใหม่
* แก้ไขข้อมูลผู้ติดต่อที่มีอยู่
* ลบผู้ติดต่อออกจากรายการ
* การทำงานแบบ CRUD (Create, Read, Update, Delete) ผ่าน RESTful API
* ส่วนติดต่อผู้ใช้ที่สวยงามและใช้งานง่าย

## 🏗️ สถาปัตยกรรม

แอปพลิเคชันนี้ใช้สถาปัตยกรรมแบบ Model-View-Controller (MVC) ร่วมกับ GetX State Management:

- **Model**: ไฟล์ `Contact.dart` สำหรับโครงสร้างข้อมูลผู้ติดต่อ
- **View**: หน้าจอและ UI ในไฟล์ `main.dart`
- **Controller**: `ContactController.dart` ที่จัดการตรรกะทางธุรกิจ
- **Service**: `ApiService.dart` สำหรับการสื่อสารกับ API

## 🛠️ เทคโนโลยีที่ใช้

- **Flutter**: เฟรมเวิร์คสำหรับพัฒนา UI ที่สวยงาม
- **GetX**: สำหรับการจัดการสถานะ, การนำทาง, และการฉีด dependencies
- **HTTP**: สำหรับการสื่อสารกับ RESTful API
- **Material Design**: รูปแบบการออกแบบ UI ที่ดูทันสมัย

## 📦 โครงสร้างไฟล์

```
lib/
├── main.dart           # จุดเริ่มต้นแอปพลิเคชัน และ UI หลัก
├── models/
│   └── contact.dart    # โมเดลข้อมูลผู้ติดต่อ
├── controllers/
│   └── contact_controller.dart  # การควบคุม
└── services/
    └── api_service.dart         # บริการเชื่อมต่อกับ API
```

## 🚀 การติดตั้ง

1. ตรวจสอบให้แน่ใจว่าคุณได้ติดตั้ง Flutter SDK แล้ว
2. โคลนหรือดาวน์โหลดโครงการนี้
3. ติดตั้ง dependencies:

```bash
flutter pub get
```

4. รันแอปพลิเคชัน:

```bash
flutter run
```

## 📱 หน้าจอและฟีเจอร์

### 📋 หน้าหลัก
<img src="https://img.icons8.com/material-rounded/24/000000/list.png" width="16"/> หน้าหลักแสดงรายการผู้ติดต่อทั้งหมด โดยแต่ละรายการจะแสดงชื่อและเบอร์โทรศัพท์พร้อมทั้งปุ่มแก้ไขและลบ

### ➕ เพิ่มผู้ติดต่อ
<img src="https://img.icons8.com/material-rounded/24/000000/plus.png" width="16"/> แตะที่ปุ่มลอยด้านล่างเพื่อเปิดหน้าจอป๊อปอัปสำหรับเพิ่มผู้ติดต่อใหม่ โดยสามารถกรอกชื่อและเบอร์โทรศัพท์

### ✏️ แก้ไขผู้ติดต่อ
<img src="https://img.icons8.com/material-rounded/24/000000/edit.png" width="16"/> แตะที่ไอคอนดินสอเพื่อแก้ไขรายละเอียดของผู้ติดต่อที่มีอยู่

### 🗑️ ลบผู้ติดต่อ
<img src="https://img.icons8.com/material-rounded/24/000000/delete.png" width="16"/> แตะที่ไอคอนถังขยะเพื่อลบผู้ติดต่อ ระบบจะขอให้คุณยืนยันก่อนดำเนินการลบ

## 📊 การใช้งาน API

แอปพลิเคชันนี้ใช้ JSONPlaceholder API เพื่อการทดสอบ การดำเนินการ CRUD ดังนี้:

- **GET**: ดึงข้อมูลผู้ติดต่อทั้งหมด
- **POST**: สร้างผู้ติดต่อใหม่
- **PUT**: อัปเดตข้อมูลผู้ติดต่อที่มีอยู่
- **DELETE**: ลบผู้ติดต่อ

## 📝 หมายเหตุ

เนื่องจากแอปพลิเคชันนี้ใช้ JSONPlaceholder API สำหรับการทดสอบ การเปลี่ยนแปลงข้อมูลจะไม่ถูกบันทึกอย่างถาวรบนเซิร์ฟเวอร์ แต่จะถูกจำลองเพื่อให้ดูเหมือนว่าการดำเนินการเสร็จสมบูรณ์
