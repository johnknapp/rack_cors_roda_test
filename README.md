# Minimal Rack::Cors + Roda app

_**This minimal roda app demonstrates a cors preflight and subsequent POST request using curl.**_

----

### 1) A cors preflight request inquires about access:

- The `-H Origin:` header identifies the caller making the preflight request. (i.e. The app which wishes to make cross origin requests to this endpoint.)
- The `-X OPTIONS` method specifier defines this as a preflight request.

```
curl --head \
  -H 'Origin: https://pizza-app.example.com' \
  -H 'Access-Control-Request-Method: POST' \
  -H 'Access-Control-Request-Headers: X-Requested-With' \
  -X OPTIONS \
  https://rack-cors-roda.herokuapp.com/pizza/toppings
```

### 2) Preflight response headers indicate what's possible:

- [The origin which may consume data from this endpoint](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Origin).
- [Methods the origin can use with this endpoint](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Methods).
- [Headers the endpoint will allow the origin to read](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Expose-Headers). (A default set is allowed.)
- [Seconds before another preflight request is required](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Max-Age). (Technically, the number of seconds a preflight response can be cached by the browser.)
- [Which headers are allowed during the subsequent request](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Headers).

```
Access-Control-Allow-Origin: https://rack-cors-roda.herokuapp.com
Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS, HEAD
Access-Control-Expose-Headers:
Access-Control-Max-Age: 7200
Access-Control-Allow-Headers: X-Requested-With
```

### 3) A subsequent POST request to that endpoint:

```
curl \
  --request POST 'https://rack-cors-roda.herokuapp.com/pizza/toppings' \
  --header 'Content-Type: text/plain' \
  --data-raw '{ "topping": "cheese" }'
```

### 4) Returns a JSON response:

`{"your_topping":"cheese"}`

----

### Notes:

- Testing your cors configuration using curl or postman does not guarantee browser requests will work. (YMMV)
- The cors standard is defined within the [JavaScript Fetch API](https://fetch.spec.whatwg.org/).
- Configuring cors on your API necessitates coordination with your front-end app.
- [A cors preflight request](https://developer.mozilla.org/en-US/docs/Glossary/Preflight_request) lets the browser inquire if cors is supported and whether cors headers are understood. (Browsers make preflight requests as needed so front-end developers don't usually need to code them.)
- This curl testing methodology comes from [this SO answer](https://stackoverflow.com/a/12179364).
- Using the [rack-cors gem](https://github.com/cyu/rack-cors):
  - Multiple origins are allowed
  - Multiple allow blocks are allowed
  - Origins must include scheme and no trailing slash
  - Using wildcard origin (`Origins '*'`) enables requests from anywhere (i.e. calls to a public API)
  - Cookies sent from a cors endpoint with wildcard origin are not accepted by the calling browser. (This prevents abuse from public APIs with wildcard origins.)
