import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';

class SignUpPage extends StatefulWidget {
  final Function() onClickedSignIn;

  const SignUpPage({Key? key, required this.onClickedSignIn,}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black87,
    appBar: AppBar(
      title: Text('Signup'),
      backgroundColor: Colors.black87,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 170,
                      width: 120,
                      child: DecoratedBox(
                        decoration: new BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 90,),
                  SizedBox(
                      child: Text(
                        'Email Address',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 50,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller: emailController,
                      cursorColor: Colors.orangeAccent,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: '  Enter your email',
                        labelStyle: TextStyle(color: Colors.black54),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                          ? 'Enter a valid email'
                          : null,
                    ),
                  ),
                  SizedBox(height: 8,),
                  SizedBox(
                      child: Text(
                        'Password',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                  SizedBox(height: 8,),
                  Container(
                    height: 50,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: passwordController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(labelText: '   Password',
                        labelStyle: TextStyle(color: Colors.black54),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54),
                        ),
                      ),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton.icon(
                    onPressed: signUp,
                    icon: Icon(Icons.lock),
                    label: Text(
                      'Sign-up',
                      style: TextStyle(color: Colors.black54, fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      backgroundColor: Colors.white38,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.grey,),
                            text: 'Already have an account?  ',
                            children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = widget.onClickedSignIn,
                                  text: 'Login',
                                  style: TextStyle(
                                      //decoration: TextDecoration.underline,
                                      color: Colors.white
                                  )
                              )
                            ]
                        )
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    ),
  );
  Future signUp() async{
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
