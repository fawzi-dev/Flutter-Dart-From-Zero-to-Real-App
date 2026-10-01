// The model: one object per item, so a name and its quantity can never desync.
class GroceryItem {
  final String name;
  final int quantity;
  bool bought; // not final — checking things off is its whole purpose

  GroceryItem({
    required this.name,
    required this.quantity,
    this.bought = false,
  });
}
