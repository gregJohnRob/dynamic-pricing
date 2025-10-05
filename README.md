
# Backend Engineering Take-Home Assignment: Dynamic Pricing Proxy

## How to Run 

My solution uses docker compose in order to run the original docker image, plus the rate-api image, and redis. To start running the docker images using the command below:

```bash
# You can append -d to run the docker images in the background
docker compose up
```

You can then run all of the tests using the below command:
```bash
docker container exec -it interview-dev ./bin/rails test
```

If you have made changes and need to rebuilt the docker docker image for the application you can use:
```bash
docker compose build --no-cache web
```

## Thought Process 

### Rate Limiting 

As mentioned on the [rate-api](https://hub.docker.com/r/tripladev/rate-api) docker page, we can only call to get rates 1,000 times per day. Since we need to handle 10,000 requests per day from our users, we will need to cache the response from the rate-api.

Because rates are only valid for 5 minutes, I wanted to use that as the TTL for the cache. 

I also saw that the rates-api accepts multiple parameters at the same time, and so made a request which would get everything for us in a single api call. 


### How to Cache

When looking at a cache, my first thought was to eventually use Redis. Redis is very performant, and because we can de-couple Redis from our service, we would be able to scale in production. 

If the service coupled cache refresh with the call to get a value, we could run into a cache stampede, where multiple calls would trigger a refresh at the same time, potentially leading to us overloading the downstream service and cache. Instead, I created a job as well as a dedicated endpoint to refresh the cache. 

## Production Ready 

### Separating Refresh From Instances

At the moment, I believe that each instance of the service would try to refresh the cache at roughly the same time due to each instance having the same job. For production, I would recommend removing the job and replace it with a lambda or cron job separate to the service.

### Improve config

While implementing, some things were hard-coded which should have been moved to config. Namely:
- rates-api token
- Cache TTL

### Logging 

Proper logging and metrics would better allow the service to be monitored in production.
