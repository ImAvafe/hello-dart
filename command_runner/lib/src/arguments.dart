import '../command_runner.dart';
import "dart:collection";
import 'dart:async';

enum OptionType { flag, option }

abstract class Argument {
  String get name;
  String? get help;

  Object? get defaultValue;
  String? get valueHelp;

  String get usage;
}

class Option extends Argument {
  Option(
    this.name, {
    required this.type,
    this.help,
    this.abbreviation,
    this.defaultValue,
    this.valueHelp,
  });

  @override
  final String name;

  final OptionType type;

  @override
  final String? help;

  final String? abbreviation;

  @override
  final Object? defaultValue;

  @override
  final String? valueHelp;

  @override
  String get usage {
    if (abbreviation != null) {
      return '-$abbreviation, --$name: $help';
    }

    return '--$name: $help';
  }
}

abstract class Command extends Argument {
  @override
  String get name;

  String get description;

  bool get requiresArgument => false;

  late CommandRunner runner;

  @override
  String? help;

  @override
  String? defaultValue;

  @override
  String? valueHelp;

  final List<Option> _options = [];

  UnmodifiableSetView<Option> get options =>
      UnmodifiableSetView(_options.toSet());

  void addFlag(
    String name, {
    String? help,
    String? abbreviation,
    String? valueHelp,
  }) {
    _options.add(
      Option(
        name,
        help: help,
        abbreviation: abbreviation,
        defaultValue: false,
        valueHelp: valueHelp,
        type: OptionType.flag,
      ),
    );
  }

  void addOption(
    String name, {
    String? help,
    String? abbreviation,
    String? defaultValue,
    String? valueHelp,
  }) {
    _options.add(
      Option(
        name,
        help: help,
        abbreviation: abbreviation,
        defaultValue: defaultValue,
        valueHelp: valueHelp,
        type: OptionType.option,
      ),
    );
  }

  FutureOr<Object?> run(ArgumentResults arguments);

  @override
  String get usage {
    return '$name: $description';
  }
}

class ArgumentResults {
  Command? command;
  String? commandArgument;
  Map<Option, Object> options = {};

  bool flag(String name) {
    for (var option in options.keys.where(
      (option) => option.type == OptionType.flag,
    )) {
      if (option.name == name) {
        return options[option] as bool;
      }
    }

    return false;
  }

  bool hasOption(String name) {
    return options.keys.any((option) => option.name == name);
  }

  ({Option option, Object? input}) getOption(String name) {
    var mapEntry = options.entries.firstWhere(
      (entry) => entry.key.name == name || entry.key.abbreviation == name,
    );

    return (option: mapEntry.key, input: mapEntry.value);
  }
}
