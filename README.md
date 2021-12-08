# [super_circle](https://pub.dev/packages/super_circle/install)

Amazing animated colored circular widget, you can use it in your profile , loading screen or with any widget you want.

Add Super Circle => Better UI/UX


[![pub](https://img.shields.io/pub/v/super_circle?color=blue&logo=flutter&logoColor=blue&style=flat-square)](https://pub.dev/packages/super_circle/install)
[![license](https://img.shields.io/github/license/ABDULKARIMALBAIK/super_circle?color=yellow&logo=github&style=flat-square)](https://pub.dev/packages/super_circle/install)
[![repo_size](https://img.shields.io/github/languages/code-size/ABDULKARIMALBAIK/super_circle?color=green&label=repo_size&logo=github&style=flat-square)](https://pub.dev/packages/super_circle/install)


## URLS


# Features

**Animation**

This widget animate any widget with pro UI,  you can use it to profile screen , loading screen or any widget you want.

**Configurable Widget**

You can control any part of this widget speed , rotation direction , background color


# Installing

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  super_circle: latest_version
```

Then import the package in dart code:

```dart
import 'package:super_circle/super_circle.dart';
```

More details see [pub.dev](https://pub.dev/packages/super_circle/install).


# Usage

The `super_circle` package it is so easy to use:

> :warning:: The `size` value must be `size <= MediaQuery.of(context).size.width` to give you good experience.

**Without any child widget**

```
      Center(child: SuperCircle());
```

**Add image widget**

```
      SuperCircle(
          size: 400,
          rotateBegin: 1.0,
          rotateEnd: 0.0,
          backgroundCircleColor: Colors.black,
          speedRotateCircle: 6000,
          speedChangeShadowColorInner: 2000,
          speedChangeShadowColorOuter: 2000,
          child: Container(
            width: 400,
            height: 400,
            color: Colors.red,
            child: Image.network(
              'http://placekitten.com/g/200/300',
              width: 400,
              height: 400,
              fit: BoxFit.cover,
            ),
          ),
        )
```

**Add icon widget**

```
     SuperCircle(
       size: 400,
       rotateBegin: 0.0,
       rotateEnd: 1.0,
       backgroundCircleColor: Colors.white,
       speedRotateCircle: 4000,
       speedChangeShadowColorInner: 3000,
       speedChangeShadowColorOuter: 3000,
       child: Container(
         width: 300,
         height: 300,
         child: Icon(Icons.security , color: Colors.red, size: 30,),
       ),
     )
```


# Widget Properties

**child**

*Widget*

A widget which it is inside the circle.


**size**

*double*

size of the circle (width and height are equal).


**backgroundCircleColor**

*Color*

background color of the circle.


**rotateBegin**

*double*

The initial value of the rotation , the value between 0.0 and 1.0 .


**rotateEnd**

*double*

The final value of the rotation , the value between 0.0 and 1.0 .


**spreadShadowBegin**

*double*

The initial value of spread shadow.


**spreadShadowEnd**

*double*

The final value of spread shadow.


**speedChangeColor**

*int*

The speed value of changing color of the circle.


**speedRotateCircle**

*int*

The speed value of rotation of the circle.


**speedChangeShadowColorInner**

*int*

The speed value of changing color of the inner shadow.


**speedChangeShadowColorOuter**

*int*

The speed value of changing color of the outer shadow.


---
