// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/icon_content.dart';
import '../components//reusable_card.dart';
import '../components//constants.dart';
import 'results_page.dart';
import '../components/bottom_button.dart';
import '../components/round_icon_button.dart';
import '../calculator_brain.dart';

enum Gender {
  Male,
  Female
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender gender;
  int height = 180;
  int weight = 60;
  int age  = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('BMI CALCULATOR'),
        ),
        body: Column(
          crossAxisAlignment:  CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: ReusableCard(
                        onPress: () {
                          setState(() {
                            gender = Gender.Male;
                          });
                        },
                        colour: gender == Gender.Male ? kActiveColor : kInactiveCardColour,
                        cardChild: IconContent(
                          icon: FontAwesomeIcons.mars,
                          gender: "MALE",
                        ),
                      ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      onPress: () {
                        setState(() {
                          gender = Gender.Female;
                        });
                      },
                      colour: gender == Gender.Female ? kActiveColor : kInactiveCardColour,
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.venus,
                        gender: "FEMALE",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ReusableCard(
                colour: kActiveColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Height", style: kLabelTextStyle,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: <Widget>[
                        Text(
                          height.toString(),
                          style: kNumberTextStyle,
                        ),
                        Text(
                          "cm",
                          style: kLabelTextStyle,
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Color(0xFF8DD8E98),
                        thumbColor: Color(0xFFEB1555),
                        overlayColor: Color(0x29EB1555),
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 16),
                      ),
                      child: Slider(
                          value: height.toDouble(),
                          min: 120.0,
                          max: 220.0,
                          onChanged: (double newValue) {
                            setState(() {
                              height = newValue.round();
                            });
                          },),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: ReusableCard(
                      colour: kActiveColor,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Weight",
                            style: kLabelTextStyle,
                          ),
                          Text(weight.toString(),
                          style:  kNumberTextStyle,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIconButton(icon: FontAwesomeIcons.minus, onPressed: (){
                                setState(() {
                                  weight--;
                                });
                              },),
                              SizedBox(
                                width: 10.0,
                              ),
                              RoundIconButton(icon: FontAwesomeIcons.plus, onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              },)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      colour: kActiveColor,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("AGE", style: kLabelTextStyle,),
                          Text(age.toString(), style: kNumberTextStyle,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RoundIconButton(icon: FontAwesomeIcons.minus, onPressed: () {
                                setState(() {
                                  age--;
                                });
                              }),
                              SizedBox(
                                width: 10.0,
                              ),
                              RoundIconButton(icon: FontAwesomeIcons.plus, onPressed: () {
                                setState(() {
                                  age++;
                                });
                              }),
                            ],
                          )
                        ],
                      )
                        ,
                    ),
                  ),
                ],
              ),
            ),
            BottomButton(buttonTitle: "Calculate", onTap: () {
              CalculatorBrain calc = CalculatorBrain(height: height, weight: weight);

              Navigator.push(context, MaterialPageRoute(builder: (context)=> ResultsPage(
                  bmiResult: calc.calculateBMI(),
                  resultText: calc.getResult(),
                  interpretation: calc.getInterpretation(),
              ),
    ));
            },
    ),

          ],
        ));
  }
}



