import 'package:animate_do/animate_do.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wedding_planner/classes/Helpers.dart';
import 'package:wedding_planner/classes/User.dart';
import 'package:wedding_planner/style/Theme.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();

  bool _validateEmail = false, _validatePass = false, _validateConf = false;
  String _confText = "";
  String _passText = "", _emailText ="";

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, size: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children:[
            const SizedBox(height: 30,),
            FadeInUp(duration: Duration(milliseconds: 1000),
                child: Text("Sign up", style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: gold
                ),)),
            const SizedBox(height: 20,),
            FadeInUp(duration: Duration(milliseconds: 1200), child: Text("Create an account, It's free", style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700]
            ),)),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  FadeInUp(duration: const Duration(milliseconds: 1200),
                      child: makeInput(
                          label: "Email",
                          controller: _emailController,
                          error: _validateEmail,
                          errorText: _emailText
                      )),
                  FadeInUp(duration: const Duration(milliseconds: 1300),
                      child: makeInput(
                          label: "Password",
                          obscureText: true,
                          controller: _passwordController,
                          error: _validatePass,
                          errorText: _passText,
                      )),

                  FadeInUp(duration: const Duration(milliseconds: 1400),
                      child: makeInput(
                          label: "Confirm Password",
                          obscureText: true,
                          controller: _confirmPassController,
                          error: _validateConf,
                          errorText: _confText,
                      )),

                ],
              ),
            ),
            FadeInUp(duration: const Duration(milliseconds: 1500),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(10),
                      gradient: LinearGradient(
                          colors: [dun, goldAccent])),

                  child: TextButton(
                    onPressed: (){
                      setState(() {
                        _validatePass = _passwordController.text.isEmpty;
                        _validateConf = _confirmPassController.text.isEmpty;
                        _validateEmail = _emailController.text.isEmpty;
                      });

                      //if password or confirm password is empty we signal that
                      if(_validatePass) _passText = 'Field cannot be empty';
                      if(_validateConf) _confText = 'Field cannot be empty';
                      if(_validateEmail) _emailText = 'Field cannot be empty';


                      if(!_validateConf && !_validatePass && !_validateEmail){
                        //check email structure

                        _validateEmail = !EmailValidator.validate(_emailController.text);

                        if(_validateEmail) {
                          _emailText = "email is not valid";
                        }
                        else{
                          //if none of te fields is empty we compare password and confirm password
                          if(_passwordController.text != _confirmPassController.text){
                            print('no match');
                            //if they are diffrent we display a msg
                            _validatePass = _validateConf = true;
                             _passText = "Password do not match"; _confText = "Password do not match";
                          }
                          else{
                            print('signin');
                            Users user = Users(_emailController.text.trim(), _passwordController.text.trim());
                            signup(user, context);
                          }
                        }

                      }
                    },
                    child: const Text("Sign up", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,

                    ),),
                  ),
                )),
            const SizedBox(height: 5,),

            FadeInUp(duration: const Duration(milliseconds: 1600),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 15),
                      text: "Already have an account? ",
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = ()=> Navigator.pop(context),
                          text: ' Log In',
                          style: TextStyle(decoration: TextDecoration.underline)
                        )
                      ]
                    )

                )),
          ],
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false, controller, error = false, errorText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87
        ),),
        const SizedBox(height: 5,),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            errorText: error ? errorText : null,
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)
            ),
          ),
        ),
        SizedBox(height: 30,),
      ],
    );
  }

}
