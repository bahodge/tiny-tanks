// use std::cell::Cell;

pub struct Database {
    // collections: Cell<Vec<Collection>>,
    pub name: String,
}

impl Database {
    pub fn new(name: String) -> Database {
        Database {
            name,
            // collections: Cell::new(Vec::new()),
        }
    }
}

pub struct Collection {
    pub name: String,
    records: Vec<Record>,
}

pub struct Record {
    id: String,
}
