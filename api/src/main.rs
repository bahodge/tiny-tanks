use actix_web::{web, App, HttpResponse, HttpServer, Responder};

use std::cell::Cell;

struct Counter {
    count: Cell<usize>,
}

struct User {
    age: Cell<i32>,
}

/// Use the `Data<T>` extractor to access data in a handler.
async fn update_counter(counter: web::Data<Counter>, user: web::Data<User>) -> impl Responder {
    println!("user.age: {:?}", user.age.get());

    counter.count.set(counter.count.get() + 1);
    println!("current count {}", counter.count.get());
    HttpResponse::Ok()
        .content_type("text/plain")
        .header("Access-Control-Allow-Origin", "*")
        .body(String::from(counter.count.get().to_string()))
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    // Start HTTP server
    HttpServer::new(move || {
        App::new()
            .data(Counter {
                count: Cell::new(0),
            })
            .data(User { age: Cell::new(31) })
            .service(web::resource("/update_counter").route(web::get().to(update_counter)))
    })
    .bind("127.0.0.1:4000")?
    .run()
    .await
}
