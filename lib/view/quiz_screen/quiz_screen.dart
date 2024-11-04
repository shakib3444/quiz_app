import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app/api_service.dart';
import 'package:quiz_app/utility/assets.dart';
import 'package:quiz_app/view/result_screen/result_screen.dart';

import '../../utility/app_color.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    quiz = getQuizApp();
    startTimer();
  }

  late Future quiz;
  int seconds =60;
  var currentIndexQuestion = 0;
  Timer? timer;
  bool isLoading = false;
  var  correctAnswer = 0;
  var  incorrectAnswer = 0;

  var optionList = [];
  var optionColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  resetColor(){
     optionColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
  }
  startTimer(){
    timer = Timer.periodic(const Duration(seconds: 1), (timer){
      setState(() {
        if(seconds >0 ){
          seconds--;
        }else{
          gotoNextQuestion();
        }
      });
    });
  }

  gotoNextQuestion(){
    setState(() {
      isLoading = false;
      resetColor();
      currentIndexQuestion++;
      timer!.cancel();
      seconds = 60;
      startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              AppColors.blue,
              AppColors.darkBlue
            ])),
        child: FutureBuilder(
            future: quiz,
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );

              }else if(snapshot.hasError){
                return Center(child: Text("Error:${snapshot.error}"),);
              }else if (snapshot.hasData) {
                final data = snapshot.data["results"];
                if(isLoading == false){
                  optionList=data[currentIndexQuestion]["incorrect_answers"];
                  optionList.add(data[currentIndexQuestion]["correct_answer"]);
                  optionList.shuffle();
                  isLoading= true;

                }
                return SafeArea(
                    child: ListView(

                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //top bar
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //back icon
                                IconButton(onPressed: ()=>Navigator.pop(context), icon:const Icon(Icons.arrow_back_ios,color: Colors.white,)),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Text("$seconds",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white),),
                                      SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: CircularProgressIndicator(value: seconds/60,valueColor:const AlwaysStoppedAnimation(Colors.white),),),

                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Center(child: Image.asset(Assets.idea,height: 150,width: 150,fit: BoxFit.contain,)),
                            const SizedBox(height: 20,),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Question:${currentIndexQuestion+1} of ${data.length}",style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white),)),
                            const SizedBox(height: 20,),

                            Text(data[currentIndexQuestion]["question"],
                              style:const TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.white),
                            ),

                            const SizedBox(height: 20,),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:optionList.length ,
                                itemBuilder: (context,index){
                                  var correctAnswer = data[currentIndexQuestion]["correct_answer"];
                                  return GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        if(correctAnswer.toString() == optionList[index].toString()){
                                          optionColor[index] = Colors.green;
                                          this.correctAnswer++;
                                        }else{
                                          optionColor[index] = Colors.red;
                                          incorrectAnswer++;
                                        }
                                        if(currentIndexQuestion<data.length -1){
                                          Future.delayed(const Duration(milliseconds: 400),(){
                                            gotoNextQuestion();
                                          });
                                        }else{
                                          timer!.cancel();
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ResultScreen(
                                              correctAnswer: this.correctAnswer,
                                              incorrectAnswer: incorrectAnswer,
                                              totalQuestion: currentIndexQuestion+1)));
                                        }

                                      });
                                    },
                                    child: Container(
                                      margin:const EdgeInsets.only(bottom: 20),
                                      alignment: Alignment.center,
                                      width:MediaQuery.sizeOf(context).width-100,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: optionColor[index],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(optionList[index].toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),

                                    ),
                                  );
                                })


                          ],
                        )
                      ],
                ));
              } else {
                return const Center(
                  child: Center(child: Text("No Data Found")),
                );
              }
            }),
      ),
    );
  }
}
