import 'package:command_runner/command_runner.dart';

const version = "0.1.0";

void main(List<String> arguments) {
  var runner = CommandRunner();
  runner.addCommand(HelpCommand());
  runner.run(arguments);
}
