class Machine {
  final String type;
  final List<MachinePart> machinePart;

  Machine(
    this.type,
    this.machinePart,
  );
}

class MachinePart {
  final String partNumber;
  final String item;

  MachinePart(this.partNumber, this.item);
}
