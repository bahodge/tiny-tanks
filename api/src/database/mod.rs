use std::cell::Cell;

pub struct Database {
    collections: Cell<Vec<Collection>>,
    pub name: String,
}

impl Database {
    pub fn new(name: String) -> Database {
        Database {
            name,
            collections: Cell::new(Vec::new()),
        }
    }

    // pub fn create_collection(name: String) -> Collection {
    //     let collection = Collection::new(name);
    // }
}

pub struct Collection {
    pub name: String,
    records: Vec<Record>,
}

pub struct Record {
    id: String,
}

// impl<T> Collection<T> {
//     pub fn new(name: String) -> Collection<T> {
//       Collection { name, records: Vec<T>::new()}
//     }

//     pub fn records(&self) -> &T {
//         &self.records
//     }
// }
