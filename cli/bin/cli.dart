import "package:command_runner/command_runner.dart";

const version = "0.1.0";

void main(List<String> arguments) async {
  var runner = CommandRunner();
  await runner.run(arguments);
}
