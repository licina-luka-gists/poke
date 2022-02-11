A concoction of several concepts I'd been pondering for some time now

 - functional programing for browser automation (& data munging),

   this is supposed to speed up the test definition process
   
 - a HAML-serving proxy, acting as a pseudo-UI for testing JSON APIs,
   
   this is supposed to crystalize product-oriented planning in a *non-visual* manner, also speed up prototyping of server-side-first functionalities

 - inverted assertions, ie you want your tests to fail at finding unwanted behavior
 
   this enforces thinking up pessimistic test cases which inevitably lead to more "probing" into, more scrutiny of the target system

## Usage

### Proxy

The

```
routes.rb
```

file is where you can write in your custom routes for the test cases to hit and from which you can use your HAMLs (put them into ./views dir).

The route can serve as a proxy to the system under test and fetch the JSON data to be rendered by the HAML template and, in turn, be tested by the browser-automating test.

To proxy a request run

```ruby
Client.new.hit 'get',
               'localhost/api/json/something',
               { 'Authorization' => "Bearer #{request.cookies['token']}" }
```

assuming one of the previous cases tested the system authentication functionality and that the browser is carrying the auth token in a cookie - if it's not a cookie an auth-test case can manually intercept and set it as cookie anyway.

### Runner

Write your cases, following the ProjectNameHere::Basic example,
then run


```
make
```

## Contributing

?
