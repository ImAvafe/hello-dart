import 'dart:collection';
import 'dart:io';
import 'arguments.dart';

class CommandRunner {
  final Map<String, Command> _commands = <String, Command>{};

  UnmodifiableSetView<Command> get commands =>
      UnmodifiableSetView<Command>(<Command>{..._commands.values});

  Future<void> run(List<String> input) async {
    final ArgumentResults results = parse(input);

    if (results.command != null) {
      Object? output = await results.command!.run(results);
      print(output.toString());
    }
  }

  void addCommand(Command command) {
    _commands[command.name] = command;
    command.runner = this;
  }

  ArgumentResults parse(List<String> input) {
    var results = ArgumentResults();
    results.command = _commands[input.first];
    return results;
  }

  String get usage {
    final executableFile = Platform.script.path.split('/').last;
    return 'Usage: dart bin/$executableFile <command> [argument?] [...options?]';
  }
}
