
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculadora extends StatefulWidget{
  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String userInput = "";
  String result ="0";

List<String> buttonList =[
  'AC',
  '(',
  ')',
  '/',
  '7',
  '8',
  '9',
  '*',
  '4',
  '5',
  '6',
  '+',
  '1',
  '2',
  '3',
  '-',
  'C',
  '0',
  '.',
  '=',
]; 
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 204, 238),
      body: Column(
        children: [
        SizedBox(
          height: MediaQuery.of(context).size.height/3,
          child: Column( mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              child: Text(
                userInput,
               style: TextStyle(
                 fontSize: 32,
                 color: Color.fromARGB(255, 0, 0, 0),
               ),
             ),
            ),
             Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              child: Text(
                result,
               style: TextStyle(
                 fontSize: 48,
                 color: const Color.fromARGB(255, 0, 0, 0),
                 fontWeight: FontWeight.bold
                ),
              ),
             ),
           ]),
         ),
         Divider(color: Colors.white),
         Expanded(
            child: Container( 
          padding: EdgeInsets.all(10),
          child: GridView.builder(
            itemCount: buttonList.length,
             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12, 
              mainAxisSpacing: 12,
             ), 
              itemBuilder:(BuildContext context, int index ){
               return CustomButton(buttonList[index]);
              }
           ),
          ),
         ),
       ],
      ),
    );
  }
  Widget CustomButton(String text){
    return InkWell(
      splashColor: Color(0xFF1d2630),
      onTap: (){
        setState(() {
          handleButton(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: getBgColor(text),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
           BoxShadow(
             color: Colors.white.withOpacity(0.1),
             blurRadius: 4,
             spreadRadius: 0.5,
             offset: Offset(-3, -3),
           ),
          ],

        ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: getColor(text),
            fontSize: 30,
            fontWeight: FontWeight.bold,
         ),
       ),
     ),
      ),
    );
  
  }

  getColor(String text){
    if(text == "/" || 
       text == "*" ||   
       text == "+" ||   
       text == "-" ||   
       text == "C" ||   
       text == "(" ||   
       text == ")") {
      return Color.fromARGB(255, 10, 0, 8);
    }
    return Colors.white;
  }
   getBgColor(String text){
    if(text == "AC"){
      return Color.fromARGB(255, 230, 39, 166);
    } 
    if(text == "="){
      return Color.fromARGB(255, 230, 39, 166);
    } 
     return Color.fromARGB(255, 222, 77, 222);
    }
    handleButton(String text){
      if(text == "AC"){
        userInput = "";
        result = "0";
        return;
      }
      if(text == "C"){
        if(userInput.isNotEmpty){
          userInput = userInput.substring(0, userInput.length -1);
          return;
        }
        else{
          return null;
        }
      }
      if(text == "="){
        result = Calculadora();
        userInput = result;

        if(userInput.endsWith(".0")) {
         userInput = userInput.replaceAll(".0", "");
        }
        if(result.endsWith(".0")) {
         result = result.replaceAll(".0", "");
         return;
        
      }

      userInput = userInput + text; 
    }

    String Calculadora(){
      try{
        var exp = Parser().parse(userInput);
        var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
        return evaluation.toString();
      } catch (e) {
        return "ERROR";
    }
   }
 }
}