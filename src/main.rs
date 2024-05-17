use rocket::Request;

#[macro_use]
extern crate rocket;

#[derive(Debug)]
struct Auth {
    username: String,
    password: String,
}


#[catch(404)]
fn not_found(req: &Request) -> String {
    format!("Sorry, '{}' is not a valid path.", req.uri())
}

#[get("/")]
fn index() -> &'static str {
    "Hello, world!"
}

#[get("/AuthLogin?<username>&<password>")]
fn authlogin(username: String, password: String) -> String {
    
    let auth = Auth { username, password };
    println!("{:?}", auth);
    format!("Hello, {}! Your password is {}", auth.username, auth.password)

}

#[rocket::main]
async fn main() -> Result<(), rocket::Error> {
    let _rocket = rocket::build()
        .mount("/", routes![index, authlogin])
        .register("/", catchers![not_found])
        .launch()
        .await?;

    Ok(())
}
