use actix_web::{web, App, HttpRequest, HttpResponse, HttpServer, Responder};

// async fn sessions() -> impl Responder {
//     HttpResponse::Ok()
//         .content_type("text/plain")
//         .header("Access-Control-Allow-Origin", "*")
//         .body("fak")
// }

async fn sessions(req: HttpRequest) -> &'static str {
    println!("req: {:?}", req);
    "This is /sessions!"
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    // Create the database

    // Start HTTP server
    HttpServer::new(move || {
        App::new().service(web::resource("/sessions").route(web::get().to(sessions)))
    })
    .bind("127.0.0.1:4000")?
    .run()
    .await
}
