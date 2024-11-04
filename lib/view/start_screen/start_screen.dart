import 'package:flutter/material.dart';
import 'package:quiz_app/utility/app_color.dart';
import 'package:quiz_app/utility/assets.dart';
import 'package:quiz_app/view/quiz_screen/quiz_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:const  EdgeInsets.all(20),
        decoration:const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors:[
            AppColors.lightGrey,
            AppColors.blue,
            AppColors.darkBlue
          ])
        ),
        child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(Assets.flash,height: 350,width: double.infinity,fit: BoxFit.cover,),
                const SizedBox(height: 20,),
               const Text("Welcome our",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                const Text("Quiz App",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                const Spacer(),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      maximumSize:const Size(300, 45),
                      minimumSize:const Size(300, 45),
                      backgroundColor: Colors.white,
                    ),
                      onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizScreen()));
                      },
                      child:const Text("Continue",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: AppColors.darkBlue),)),
                )
              ],
            )),

      ),
    );
  }
}
