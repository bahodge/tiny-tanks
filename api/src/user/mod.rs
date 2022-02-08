use serde::Serialize;

#[derive(Serialize)]
pub struct User {
    id: String,
    name: String,
}

impl User {
    pub fn new(name: String) -> User {
        User {
            id: String::from("asdf"),
            name,
        }
    }
}
#[derive(Serialize)]
pub struct UsersResponsePayload {
    data: Vec<User>,
}

impl UsersResponsePayload {
    pub fn new(data: Vec<User>) -> UsersResponsePayload {
        UsersResponsePayload { data }
    }
}
