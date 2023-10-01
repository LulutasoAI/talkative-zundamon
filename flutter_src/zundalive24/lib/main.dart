import 'package:flutter/material.dart';
import 'package:zundalive24/backend/flutter_information_cupsule.dart';
import 'package:zundalive24/backend/wav_player.dart';
import 'frontend_widgets/dialogbox.dart';
import 'frontend_widgets/question.dart';
import 'backend/python_communication.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  pythonCommunicationHandler python_communication_handler = pythonCommunicationHandler();
  FlutterInformationCapsule? python_response;
  WavPlayer wav_player = WavPlayer();
  
  Timer? _timer;
  Timer? _timer_2;
  String message = "考え中...";
  String questioner = "募集中";
  String question = "質問を募集中です。";
  String? wavpath;
  String? image_url;
  @override
  void initState() {
    super.initState(); // Always at the beginning
    _timer = Timer.periodic(Duration(seconds: 45), (Timer t) => check_up_on_updates());
    _timer_2 = Timer.periodic(Duration(seconds: 30), (Timer t) => initiate_comments_Fetch());
  }

  @override
  void dispose() {
    _timer?.cancel(); // Always cancel timers to prevent memory leaks
    _timer_2?.cancel();
    super.dispose();
  }

  void initiate_comments_Fetch() async{ 
    python_communication_handler.initiateCommentsFetch();
  }
  void check_up_on_updates() async {
    print("hi");
    
    FlutterInformationCapsule? response = await python_communication_handler.fetchInformationCapsuleFromServer();
    if (response == null) {
      return;
    }else{
      setState(() {
      python_response = response;
    });
    }
    
  }
  

  @override
  Widget build(BuildContext context) {
    
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double questionWidth = 0.4 * screenWidth;
    double questionHeight = 0.4 * screenHeight;
    NetworkImage? iconimage; 
    if (python_response != null) {
      print(python_response!.toJson());
      message = python_response!.text;
      questioner = python_response!.questioner;
      question = python_response!.question;
      wavpath = python_response!.wavPath;
      image_url = python_response!.image_url;

      wav_player.playWav(wavpath!).then((value) => null); 
       if(image_url != null){
      iconimage = NetworkImage(image_url!);
    }
      print(iconimage == null);
      print(image_url);
    }
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("ずんだもん24時間配信"),
      ),
      body: Stack(
        children: <Widget>[
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/zunda_background.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Main Content
          
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
               
                Row(
                  
                  children: [
                    Spacer(),
                    SizedBox(
                      width: questionWidth,
                      height: questionHeight,
                      child: QuestionWidget(
                        questionerName: questioner,
                        questionText: question,
                        iconImage: iconimage,
                      ),
                    ),
                    Image.asset('assets/zundastanding.png'),
                    Spacer(),
                  ],
                ),
              ],
            ),
          ),

          // Dialogue Box at Bottom
          VisualNovelDialogueBox(
            characterName: 'ずんだもん',
            dialogue: message,
          ),
        ],
      ),
    );
  }
}
