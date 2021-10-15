# Flutter กับ ฐานข้อมูล NoSQL
โปรเจค Note app จะเป็นระบบ Register/Login โดยเชื่อมต่อกับฐานข้อมูล Firebase

## Document
### welcome.dart
ใน welcome.dart จะมี class WelcomeScreen() ที่มีปุ่ม Login กับ Register
โดยเมื่อกดแต่ละปุุ่ม จะมีการใช้คำสั่ง Navigator.push() ทำการ return LoginScreen() และ RegisterScreen() 
เพื่อแสดงหน้า Login และ Register

<img src="https://user-images.githubusercontent.com/48233991/137513104-7aedecd9-66ec-41c4-982b-37ce4f9105ed.png" height="400" /> <img src="https://user-images.githubusercontent.com/48233991/137510154-6d7bfa57-41ba-4359-9b05-7b3f4626a43e.png" height="400" />

### register.dart
ใน register.dart จะมี class RegisterScreen() ที่มีตัวแปร _ formKey สำหรับเก็บ key ของ Form() , profile สำหรับเก็บ instance ของโมเดล Profile , _ firebase สำหรับเชื่อมต่อกับ firebase

![image](https://user-images.githubusercontent.com/48233991/137515870-2e21c638-af10-406e-99a7-3454ec23d330.png)

ใน Form() จะมี TextFormField() ที่ใช้รับข้อมูล Email กับ Password และมีการ validator ข้อมูล จากนั้นก็เก็บข้อมูลไว้ในตัวแปร profile ในแต่ละส่วน

![image](https://user-images.githubusercontent.com/48233991/137516280-c39faabc-5d9d-47a0-8db9-02890c144c5d.png)

และมีปุ่ม Register ที่จะเรียกใช้คำสั่ง FirebaseAuth.instance.createUserWithEmailAndPassword() เพื่อ ส่งค่าใน profile ไปสร้างในฐานข้อมูล firebase

![image](https://user-images.githubusercontent.com/48233991/137516757-df4b4661-fe14-4aec-929c-b0a295760e64.png)

### login.dart
ใน login.dart จะมี TextFormField() แบบเดียวกับใน register.dart ที่ใช้รับข้อมูลการ Login
และมีปุ่ม Login ที่จะเรียกใช้คำสั่ง FirebaseAuth.instance.signInWithEmailAndPassword() เพื่อ ส่งค่าใน profile ไปตรวจสอบกับข้อมูลในฐานข้อมูล firebase

![image](https://user-images.githubusercontent.com/48233991/137518779-93993f0d-ce5a-41bd-b0ed-d82b0ee64ccd.png)

### home.dart
ใน home.dart ที่มีตัวแปร _ auth สำหรับเก็บ instance Firebase จะมีปุ่ม Logout ที่เรียกใช้ _ auth.signOut() เพื่อทำการ Logout

![image](https://user-images.githubusercontent.com/48233991/137520660-fa325229-cee1-4429-adb0-a0326077ab46.png)




