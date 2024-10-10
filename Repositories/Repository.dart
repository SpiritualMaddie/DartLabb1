// Abstrakt klass kan ha metodimplementationer men kan inte instansieras.
// Endast konkreta klasser som ärver från Repository kan skapas.
abstract class Repository<T> {
	List<T> _items = [];

	void add(T item) => _items.add(item);

	List<T> getAll() => _items;

	void update(T item, T newItem) {
		var index = _items.indexWhere((element) => element == item);
		_items[index] = newItem;
	}

	void delete(T item) => _items.remove(item);
}

// // lagrar och tar endast emot Person-objekt
// class PersonRepository extends Repository<Person> {}

// // lagrar och tar endast emot Vehicle-objekt
// class VehicleRepository extends Repository<Vehicle> {}

// // Notera implementationen återanvänds. Ingen repeterad kod :-)