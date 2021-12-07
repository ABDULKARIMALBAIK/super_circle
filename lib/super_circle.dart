// Copyright 2021 ABDULKARIM ALBAIK Author. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

library super_circle;

/* Imports */

import 'package:flutter/material.dart';
import 'package:widget_mask/widget_mask.dart';



/* Main Class */

///Circular animated colored widget with different shape
class SuperCircle extends StatefulWidget {
  const SuperCircle({
    this.size = 300,
    this.backgroundCircleColor = Colors.white,
    this.rotateBegin = 0.0,
    this.rotateEnd = 1.0,
    this.spreadShadowBegin = 10.0,
    this.spreadShadowEnd = 22.0,
    this.speedChangeColor = 8000,
    this.speedRotateCircle = 8000,
    this.speedChangeShadowColorInner = 2000,
    this.speedChangeShadowColorOuter = 2000,
    this.child = const SizedBox(),
  }) :
      assert(size >= 150 && size <= 700),
      // assert(backgroundCircleColor != null , 'SuperCircle backgroundCircleColor OK'),  //INFO: is always true
      assert(rotateBegin >= 0.0 && rotateBegin <= 1.0),
      assert(rotateEnd >= 0.0 && rotateEnd <= 1.0),
      assert(spreadShadowBegin >= 2),
      assert(spreadShadowEnd <= 40),
      assert(speedChangeColor >= 100),
      assert(speedRotateCircle >= 100),
      assert(speedChangeShadowColorInner >= 100),
      assert(speedChangeShadowColorOuter >= 100);
      // assert(child != null , 'SuperCircle child OK');   //INFO: is always true



  /* Variables */

  ///[size] size of the circle (width and height are equal).
  final double size;


  ///[backgroundCircleColor] background color of the circle.
  final Color backgroundCircleColor;


  ///[rotateBegin] The initial value of the rotation.
  ///The value between 0.0 and 1.0
  final double rotateBegin;


  ///[rotateEnd] The final value of the rotation.
  ///The value between 0.0 and 1.0
  final double rotateEnd;


  ///[spreadShadowBegin] The initial value of spread shadow.
  final double spreadShadowBegin;


  ///[spreadShadowEnd] The final value of spread shadow.
  final double spreadShadowEnd;


  ///[speedChangeColor] The speed value of changing color of the circle.
  final int speedChangeColor;


  ///[speedRotateCircle] The speed value of rotation of the circle.
  final int speedRotateCircle;


  ///[speedChangeShadowColorInner] The speed value of changing color of the inner shadow.
  final int speedChangeShadowColorInner;


  ///[speedChangeShadowColorOuter] The speed value of changing color of the outer shadow.
  final int speedChangeShadowColorOuter;


  ///[child] A widget which it is inside the circle.
  final Widget child;



  @override
  State<StatefulWidget> createState() => _SuperCircleState();

}




class _SuperCircleState extends State<SuperCircle> with TickerProviderStateMixin {

  /* Animation controllers section */

  ///[animationControllerColors] Animation controller to control speed changing color of the circle and shadows.
  late AnimationController animationControllerColors;

  ///[animationControllerRotate] Animation controller to control speed rotation of the circle.
  late AnimationController animationControllerRotate;

  ///[animationControllerShadowOuter] Animation controller to control speed changing blurRadius and spreadRadius of the outer shadow.
  late AnimationController animationControllerShadowOuter;

  ///[animationControllerShadowInner] Animation controller to control speed changing blurRadius and spreadRadius of the inner shadow.
  late AnimationController animationControllerShadowInner;




  /* Animation objects section */

  ///[backgroundColor] Animation object to changing color of the circle and shadows.
  late Animatable<Color?> backgroundColor;

  ///[spreedShadowOuterColor] Animation object to changing blurRadius and spreadRadius of the outer shadow.
  late Animatable<double> spreedShadowOuterColor;

  ///[spreedShadowInnerColor] Animation object to changing blurRadius and spreadRadius of the inner shadow.
  late Animatable<double> spreedShadowInnerColor;




  /* Dispose controllers */

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    //Dispose
    disposeControllers();
  }




  /* Initialize animation controllers and objects */

  @override
  void initState() {
    super.initState();

    //Initialize
    initAnimationObjects();
    initAnimationControllers();
  }




  /* Call Variables By widget object */

  @override
  // TODO: implement widget
  SuperCircle get widget => super.widget;





  /* Build Widget tree */

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      child: Stack(
        children: [

          _shadowLayer(),
          _childLayer(),
          _circleLayer()
        ],
      ),
    );
  }




  /* Methods */

  ///Shadow Widget
  Widget _shadowLayer(){
    return Center(
      child: AnimatedBuilder(
        animation:  animationControllerShadowInner,
        builder: (ctx,child){
          return AnimatedBuilder(
            animation: animationControllerShadowOuter,
            builder: (ctx,build){
              return AnimatedBuilder(
                animation: animationControllerColors,
                builder: (ctx,child){
                  return Container(
                    width: widget.size - 30,
                    height: widget.size - 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [

                          ///////// * Outer Shadow Color * /////////
                          BoxShadow(
                            color: backgroundColor.evaluate(AlwaysStoppedAnimation(animationControllerColors.value))!,
                            spreadRadius: spreedShadowOuterColor.evaluate(AlwaysStoppedAnimation(animationControllerShadowOuter.value)),
                            blurRadius: spreedShadowOuterColor.evaluate(AlwaysStoppedAnimation(animationControllerShadowOuter.value)), //12.0,
                          ),

                        ]
                    ),
                    child: Container(
                      height: widget.size - 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [

                          ///////// * Inner Shadow Color * /////////
                          BoxShadow(
                            color: backgroundColor.evaluate(AlwaysStoppedAnimation(animationControllerColors.value))!,
                          ),

                          ///////// * background Color * /////////
                          BoxShadow(
                            color: widget.backgroundCircleColor,
                            spreadRadius: spreedShadowInnerColor.evaluate(AlwaysStoppedAnimation(animationControllerShadowInner.value)),
                            blurRadius: spreedShadowOuterColor.evaluate(AlwaysStoppedAnimation(animationControllerShadowOuter.value)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  ///Child Widget
  Widget _childLayer(){

    return Center(
      child: Container(
        width: widget.size * 0.8,   //- 80
        height: widget.size * 0.8,   //- 80
        child: ClipRRect(
          borderRadius: BorderRadius.circular(500),
          child: widget.child,
        ),
      ),
    );
  }

  ///Circle Widget
  Widget _circleLayer(){
    return Center(
      child: RotationTransition(
        turns: Tween(begin: widget.rotateBegin, end: widget.rotateEnd).animate(animationControllerRotate),
        child: AnimatedBuilder(
          animation: animationControllerColors,
          builder: (ctx,child){
            return WidgetMask(
              blendMode: BlendMode.modulate,
              mask: Image.asset(
                'assets/images/background_circle.png',
                fit: BoxFit.cover,
                width: widget.size + 200,
                height: widget.size + 200,
              ),
              childSaveLayer: true,
              child: Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  // shape: BoxShape.circle,
                  borderRadius: BorderRadius.circular(500),
                  border: Border.all(
                    width: 30,
                    color: backgroundColor.evaluate(AlwaysStoppedAnimation(animationControllerColors.value))!,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }


  ///Dispose animation controllers of the widget.
  void disposeControllers() {
    animationControllerShadowInner.dispose();
    animationControllerShadowOuter.dispose();
    animationControllerColors.dispose();
    animationControllerRotate.dispose();
  }

  ///initialize animation controllers of the widget.
  void initAnimationControllers() {

    animationControllerColors = AnimationController(
      duration: Duration(milliseconds: widget.speedChangeColor),
      vsync: this,
    )..repeat();

    animationControllerRotate = AnimationController(
      duration: Duration(milliseconds: widget.speedRotateCircle),
      vsync: this,
    )..repeat();

    animationControllerShadowOuter = AnimationController(
      duration: Duration(milliseconds: widget.speedChangeShadowColorOuter),
      vsync: this,
    )..repeat();

    animationControllerShadowInner = AnimationController(
      duration: Duration(milliseconds: widget.speedChangeShadowColorInner),
      vsync: this,
    )..repeat();
  }

  ///initialize animation objects of the widget.
  void initAnimationObjects() {

    backgroundColor = TweenSequence<Color?>([
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.blueAccent,
          end: Colors.greenAccent,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.greenAccent,
          end: Colors.pinkAccent,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.pinkAccent,
          end: Colors.orangeAccent,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.orangeAccent,
          end: Colors.purpleAccent,
        ),
      ),


      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.purpleAccent,
          end: Colors.yellowAccent,
        ),
      ),

      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.yellowAccent,
          end: Colors.green,
        ),
      ),



      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.green,
          end: Colors.red,
        ),
      ),

      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.red,
          end: Colors.deepPurpleAccent,
        ),
      ),

      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.deepPurpleAccent,
          end: Colors.amberAccent,
        ),
      ),

      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.amberAccent,
          end: Colors.blueAccent,
        ),
      ),


    ]);

    spreedShadowOuterColor = TweenSequence<double>(
        [
          TweenSequenceItem(
            weight: 1.0,
            tween: Tween<double>(
              begin: widget.spreadShadowBegin,
              end: widget.spreadShadowEnd,
            ),
          ),

          TweenSequenceItem(
            weight: 1.0,
            tween: Tween<double>(
              begin: widget.spreadShadowEnd,
              end: widget.spreadShadowBegin,
            ),
          ),

        ]);

    spreedShadowInnerColor = TweenSequence<double>(
        [
          TweenSequenceItem(
            weight: 1.0,
            tween: Tween<double>(
              begin: widget.spreadShadowBegin,
              end: - widget.spreadShadowEnd,
            ),
          ),

          TweenSequenceItem(
            weight: 1.0,
            tween: Tween<double>(
              begin: - widget.spreadShadowEnd,
              end: widget.spreadShadowBegin,
            ),
          ),

        ]);
  }


}
