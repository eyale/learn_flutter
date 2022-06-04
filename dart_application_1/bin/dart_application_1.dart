int sum(int a, int b) => a + b;

class Student {
  String name = "Student";
}

void main(List<String> arguments) {
  print('sum: ${sum(1, 2)}');
  var bob = Student()..name = "Bob";
  print(Student().name);
  print(bob.name);
}
