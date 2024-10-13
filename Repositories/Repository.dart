
abstract class Repository<T> {
	List<T> _items = [];

	void add(T item) => _items.add(item);

	List<T> getAll() => _items;

	void update(T item, T newItem) {
		var index = _items.indexWhere((element) => element == item);
		_items[index] = newItem;
	}

	void delete(T item) => _items.remove(item);


  // void displayAll(){
  //   List<T> all = getAll();

  //   all.forEach(print);
  // }
}