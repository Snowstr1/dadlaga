import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

ValueNotifier<AuthService> authService = ValueNotifier(AuthService());

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email, 
      password: password
      );

      if (!credential.user!.emailVerified){
        await firebaseAuth.signOut();
        throw FirebaseAuthException(
          code: 'email-not-verified',
          message: 'Please verify your email before logging in.',
          );
      }
      return credential;
  }

Future<UserCredential> createAccount({
  required String email,
  required String password,
  required String name,
  required String phone,
  required String role,  
}) async {
  final credential = await firebaseAuth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );

final roleDoc = role == 'Teacher' ? 'Teacher' : 'Student';

await FirebaseFirestore.instance
  .collection('Users')
  .doc(roleDoc)
  .collection('UserList')
  .doc(credential.user!.uid)
  .set({
    'email': email,
    'name': name,
    'phone': phone,
    'role': role,
    'createdAt': FieldValue.serverTimestamp(),
  });


  await credential.user?.sendEmailVerification();

  return credential;
}



    Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    }


    Future<void> resetPassword({
      required String email,
    }) async {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } 
    
    Future<void> updateUsername({
      required String username,
    }) async {
      await currentUser!.updateDisplayName(username);
    }

    Future<void> deleteAccount ({
      required String email,
      required String password,
    }) async {
      AuthCredential credential = 
        EmailAuthProvider.credential(email: email, password: password);
      await currentUser!.reauthenticateWithCredential(credential);
      await currentUser!.delete();
      await firebaseAuth.signOut();
    }

    Future<void> resetPasswordFromCurrentPassword({
      required String currentPassword,
      required String newPassword,
      required String email,
    }) async {
      AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: currentPassword);
      await currentUser!.reauthenticateWithCredential(credential);
      await currentUser!.updatePassword(newPassword);
    }
} 