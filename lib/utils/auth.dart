import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<GoogleSignInAccount?> getSignedInAccount(GoogleSignIn googleSignIn) async {
  // Is the user already signed in?
  GoogleSignInAccount? account = googleSignIn.currentUser;
  // Try to sign in the previous user:
  if (account == null) {
    await googleSignIn.signInSilently();
  }
  return account;
}

Future<UserCredential> signIntoFirebase(GoogleSignInAccount googleSignInAccount) async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn(clientId: '339099570080-jeunhfkt9s9mqf1urd3q3s1lsbp385b3.apps.googleusercontent.com').signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  return await FirebaseAuth.instance.signInWithCredential(credential);
}
