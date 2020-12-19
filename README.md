## Rack::Cors + Roda test app

_**This minimal app replicates the problem observed. It replicates the relevant gems, middleware and plugins found in the production app.**_

----

## This cors preflight does not return cors headers:

```
curl --head \
  -H 'Origin: https://rack-cors-roda.herokuapp.com' \
  -H 'Access-Control-Request-Method: POST' \
  -H 'Access-Control-Request-Headers: X-Requested-With' \
  -X OPTIONS \
  https://rack-cors-roda.herokuapp.com/pizza/toppings
```

## This cors preflight does:

```
curl --head \
  -H 'Origin: https://random-sample.herokuapp.com' \
  -H 'Access-Control-Request-Method: POST' \
  -H 'Access-Control-Request-Headers: X-Requested-With' \
  -X OPTIONS \
  https://www.googleapis.com/discovery/v1/apis?fields=
```

## Conclusion:

- There is a problem in the rack-cors-roda app!
  - misconfigured app?
  - rack-cors?
  - roda?
    - roda plugins?
  - puma?
  - another gem?

----

_**Note:** This curl testing methodology comes from [this SO answer](https://stackoverflow.com/a/12179364)._
