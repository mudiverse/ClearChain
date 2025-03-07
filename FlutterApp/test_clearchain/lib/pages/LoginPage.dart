import 'package:flutter/material.dart';
import 'package:test_clearchain/text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body:  Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //text logo
             Image.asset('assets/logo.png',width: 50,height: 50,),
            const SizedBox(height: 20,),
            Text('Clear Chain',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            ),
            const SizedBox(height: 20),
            ///email
            const MyTextField(
              hinttext: 'Email',
              obscureText: false,
            ),
            ///pass
            const SizedBox(height: 20,),
            const MyTextField(
              hinttext: 'Password',
              obscureText: true,
            ),
            ///submit button
            const SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(onPressed: (){},
                  child:const Text('Submit',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  )

              ),
            )
            ///text
          ],
        ),
      ),
    );
  }
}
