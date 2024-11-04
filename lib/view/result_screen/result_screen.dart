import 'package:flutter/material.dart';
import 'package:quiz_app/view/start_screen/start_screen.dart';

import '../../utility/app_color.dart';
import '../../utility/assets.dart';

class ResultScreen extends StatelessWidget {
  final  correctAnswer;
  final  incorrectAnswer;
  final  totalQuestion;
   const ResultScreen({super.key,required this.correctAnswer,required this.incorrectAnswer,required this.totalQuestion});




  @override
  Widget build(BuildContext context) {
    double correctPercentage = (correctAnswer/totalQuestion*100);
    return Scaffold(
      body: Container(
        padding:const  EdgeInsets.all(20),
        decoration:const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors:[
                  AppColors.blue,
                  AppColors.darkBlue
                ])
        ),
        child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: Image.asset(Assets.flash,height: 200,width:200,fit: BoxFit.contain,)),
                  const SizedBox(height: 20,),
                  const Text("Congratulation",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                   Text(correctPercentage.toStringAsFixed(1),style:const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                   Text("correctAnswer:${correctAnswer.toString()}",style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green),),
                   Text("incorrectAnswer:${incorrectAnswer.toString()}",style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red),),
                  const Spacer(),
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          maximumSize:const Size(300, 45),
                          minimumSize:const Size(300, 45),
                          backgroundColor: Colors.white,
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const StartScreen()));
                        },
                        child:const Text("Back to Home",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: AppColors.darkBlue),)),
                  )
                ],
              ),
            )),

      ),

    );
  }
}
