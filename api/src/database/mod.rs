#[derive(Clone)]
pub struct Database {
    // collections: Vec<Collection>,
    name: String,
}

impl Database {
    pub fn new(name: String) -> Database {
        Database {
            name,
            // collections: Vec.new(),
        }
    }

    // pub fn create_collection(name: String) -> Collection {
    //     let collection = Collection::new(name);
    // }
}

pub struct Collection<T> {
    records: Vec<T>,
    name: String,
}

// impl<T> Collection<T> {
//     pub fn new(name: String) -> Collection<T> {
//       Collection { name, records: Vec<T>::new()}
//     }

//     pub fn records(&self) -> &T {
//         &self.records
//     }
// }
