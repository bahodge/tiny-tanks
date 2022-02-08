use actix_web::{web, App, HttpResponse, HttpServer, Responder};

mod database;

use crate::database::Database;

/// Use the `Data<T>` extractor to access data in a handler.
async fn get_database_name(db: web::Data<Database>) -> impl Responder {
    println!("db name: {}", db.name);

    let database_name = &db.name;

    HttpResponse::Ok()
        .content_type("text/plain")
        .header("Access-Control-Allow-Origin", "*")
        .body("asdfasdf")
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    // Create the database

    // Start HTTP server
    HttpServer::new(move || {
        let db = Database::new(String::from("tanks"));
        let data = web::Data::new(db);
        App::new()
            .data(data.clone())
            .service(web::resource("/get_database_name").route(web::get().to(get_database_name)))
    })
    .bind("127.0.0.1:4000")?
    .run()
    .await
}
