const testCode = '''#include <iostream>

using namespace std;

// [START section1]
int voidReadOnly() {
  int test;
}// [END section1]

int main() {
  int test;
}

''';

//------------Tutorial Codes
const startingCode = '''// [START section1]
#include <iostream>

using namespace std;

int main() {
  cout<<"Hello world!"<<endl;
  return 0;
} 
//This is a comment
/*THIS
IS
ALSO
A COMMENT*/ // [END section1]''';

const variablesAndDataTypes = '''// [START section1]
#include <iostream>
#include <string>
using namespace std;

int main() {
  // Integer
  int myNumber = 5;
  cout << "Integer: " << myNumber << endl;

  // Double
  double myDecimal = 3.14;
  cout << "Double: " << myDecimal << endl;

  // Character
  char myChar = 'A';
  cout << "Char: " << myChar << endl;

  // String
  string myString = "Hello";
  cout << "String: " << myString << endl;

  return 0;
}// [END section1]''';

const basicArithmeticOperations = '''// [START section1]
#include <iostream>
using namespace std;

int main() {
  int a = 5, b = 3;

  // Addition
  int sum = a + b;
  cout << "Sum: " << sum << endl;

  // Subtraction
  int difference = a - b;
  cout << "Difference: " << difference << endl;

  // Multiplication
  int product = a * b;
  cout << "Product: " << product << endl;

  // Division
  int quotient = a / b;
  cout << "Quotient: " << quotient << endl;

  return 0;
}// [END section1]''';

const conditionalStatements = '''// [START section1]
#include <iostream>
using namespace std;

int main() {
  int x = 5;

  // If statement
  if (x > 0) {
    cout << "x is positive" << endl;
  }

  // Else statement
  if (x > 0) {
    cout << "x is positive" << endl;
  } else {
    cout << "x is not positive" << endl;
  }

  // Else if statement
  if (x > 0) {
    cout << "x is positive" << endl;
  } else if (x < 0) {
    cout << "x is negative" << endl;
  } else {
    cout << "x is zero" << endl;
  }

  return 0;
}// [END section1]''';

const loops = '''// [START section1]
#include <iostream>
using namespace std;

int main() {
  // For loop
  for (int i = 0; i < 5; i++) {
    cout << i << endl;
  }

  // While loop
  int i = 0;
  while (i < 5) {
    cout << i << endl;
    i++;
  }

  return 0;
}// [END section1]''';

const functions = '''// [START section1]
#include <iostream>
using namespace std;

int add(int a, int b) {
  return a + b;
}

int main() {
  int result = add(3, 4);
  cout << "Result: " << result << endl;
  return 0;
}// [END section1]''';

const classes = '''// [START section1]
#include <iostream>
#include <string>
using namespace std;

class Car {
  public:
    string brand;
    int year;
    void displayInfo() {
      cout << brand << " " << year << endl;
    }
};

int main() {
  Car myCar;
  myCar.brand = "Toyota";
  myCar.year = 2020;
  myCar.displayInfo();
  return 0;
}// [END section1]''';