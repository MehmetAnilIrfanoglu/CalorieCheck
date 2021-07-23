import 'package:caloriecheck_app/SecondScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'userClass.dart';

class AuthenticationService {

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signupProcess(String email, String password, String name,
      String gender,String performance, String age, String weight, String height) async {

    if (email.trim().isEmpty || !email.trim().contains("@")) {
      return "Please enter a valid email address";
    }
    if (password.trim().length < 7) {
      return "Password must be at least 7 characters long";
    }
    if (name.trim().length < 4) {
      return "Name must be at least 4 characters long";
    }


    try {
      print("Inputs are verified");

      // with e-mail and password the authentication user is generated
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user.uid)
          .set(
        {
          "name": name.trim(),
          "gender": gender.trim(),
          "performance": performance.trim(),
          "age": age,
          "weight": weight,
          "height": height,

        },
      );

      return "Correct";

    } on FirebaseAuthException catch (err) {
      var message = "An error occured, please check your credentials!";

      if (err.message != null) {
        message = err.message;
      }
      throw message;
    } catch (err) {
      throw err.message;
    }
  }


  CollectionReference history = FirebaseFirestore.instance.collection('history');


  Future<void> addHistory(String name,double calorie) async {
      return await history
          .add({
        'name': name,
        'calorie': calorie,

        'id': "",
      })
          .then((value) {
        history.doc(value.id).update({'id': SecondScreen.id});
        print("Food Added");
      })
          .catchError((error) => print("Failed to add note: $error"));
    }




  Future<userClass> signInProccess(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      var user = await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user.uid)
          .get();

      userClass newUser = new userClass(
        email: userCredential.user.email,
        id: userCredential.user.uid,
        name: user["name"],
        gender: user["gender"],
        weight: user["weight"],
        height: user["height"],
        age: user["age"],
        performance: user["performance"],
      );

      return newUser;

    } on FirebaseAuthException catch (err) {
      var message = "An error occured, please check your credentials!";

      if (err.code != null) {
        message = err.code;
      }
      throw message;
    } catch (err) {
      throw err.code;
    }
  }

  Future<String> updateProcess(String id, String name, String gender, String performance,String age,String weight,String height) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(id).update({
        'name' : name,
        'gender' : gender,
        'performance' : performance,
        'age': age,
        'weight': weight,
        'height' : height,
      });

      return 'Correct';

    } on FirebaseAuthException catch (err) {
      var message = "An error occured, please check your credentials!";

      if (err.code != null) {
        message = err.code;
      }
      throw message;
    } catch (err) {
      throw err.code;
    }
  }

  Future<String> delete(String id) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(id).delete();

      return 'Correct';

    } on FirebaseAuthException catch (err) {
      var message = "An error occured, please check your credentials!";

      if (err.code != null) {
        message = err.code;
      }
      throw message;
    } catch (err) {
      throw err.code;
    }
  }
  Future<String> deleteUser() async {
    try {
      await _auth.currentUser.delete();

      return 'Correct';

    } on FirebaseAuthException catch (err) {
      var message = "An error occured, please check your credentials!";

      if (err.code != null) {
        message = err.code;
      }
      throw message;
    } catch (err) {
      throw err.code;
    }
  }

}