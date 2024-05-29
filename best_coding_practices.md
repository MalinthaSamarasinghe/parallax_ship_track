- [Best Coding Practices](#best-coding-practices)
  - [Design Related](#design-related)
    - [Refactor code into widgets rather than methods](#refactor-code-into-widgets-rather-than-methods)
    - [Use const keyword whenever possible](#use-const-keyword-whenever-possible)
    - [Using SizedBox instead of Container in Flutter](#using-sizedbox-instead-of-container-in-flutter)
    - [Try to avoid `setState()` method](#try-to-avoid-setstate-method)
  - [Other](#other)
    - [Use relative imports instead of absolute imports](#use-relative-imports-instead-of-absolute-imports)
    - [Use ternary operator for single-line cases](#use-ternary-operator-for-single-line-cases)
  

## Best Coding Practices

### Design Related

#### Refactor code into widgets rather than methods

```dart
Column(
  children: [
     Text('Hello'),
  ],
);
```
❌ Refactor into method
```dart
Text buildHello() => Text('Hello');
```
✅ Refactor into widget
```dart
class HelloWidget extends StatelessWidget {
  const HelloWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Hello');
  }
}
```

#### Use const keyword whenever possible

Using `const constructor` for widgets can reduce the work required for garbage collectors. This may initially seem like a small performance improvement but it really adds up and makes a difference when the app is big enough or there is a view that gets frequently rebuilt.

```dart
const Container(
  width: 100,
  child: const Text('Hello World')
);
```

#### Using SizedBox instead of Container in Flutter
There are multiple use cases where you will require to use a placeholder. Here is the ideal example below,
```dart
return _isNotLoaded ? Container() : YourAppropriateWidget();
```
The Container is a great widget that you will be using extensively in Flutter. Container() brodens up to fit the constraints given by the parent and is not a const constructor.

On the contrary, the SizedBox is a const constructor and builds a fixed-size box. The width and height parameters can be null to specify that the size of the box should not be constrained in the corresponding dimension.

Thus, when we have to implement the placeholder, SizedBox should be used rather than using a container.
```dart
return _isNotLoaded ? SizedBox() : YourAppropriateWidget();
```

#### Try to avoid `setState()` method

// Todo:

### Other

#### Use relative imports instead of absolute imports

When using relative and absolute imports together then It is possible to create confusion when the same class gets imported from two different ways. To avoid this case we should use a relative path in the lib/ folder.

```dart
//Do
import '../../themes/style.dart';

//Do not
import 'package:myapp/themes/style.dart';
```

#### Use ternary operator for single-line cases

```dart
String alert = isReturningCustomer ? 'this one if true!' : 'this one if false';
```