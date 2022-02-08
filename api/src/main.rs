use actix_web::{web, App, HttpResponse, HttpServer, Responder};

use std::cell::Cell;

mod database;

use crate::database::Database;

struct Counter {
    count: Cell<usize>,
}

struct User {
    age: Cell<i32>,
}

/// Use the `Data<T>` extractor to access data in a handler.
async fn update_counter() -> impl Responder {
    HttpResponse::Ok()
        .content_type("text/plain")
        .header("Access-Control-Allow-Origin", "*")
        .body("asdf")
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    // Create the database
    // Start HTTP server
    HttpServer::new(move || {
        let database = web::Data::new(Database::new(String::from("tanks")));
        App::new()
            .data(database)
            .service(web::resource("/update_counter").route(web::get().to(update_counter)))
    })
    .bind("127.0.0.1:4000")?
    .run()
    .await
}
