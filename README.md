
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

## Thought Process 

### Rate Limiting 

As mentioned on the [rate-api](https://hub.docker.com/r/tripladev/rate-api) docker page, we can only call to get rates 1,000 times per day. Since we need to handle 10,000 requests per day from our users, we will need to cache the response from the pricing model. 


### How to Cache

When looking at a cache, my first thought was to eventually use Redis. Redis is very performant, and because we can de-couple Redis from our service, we would be able to scale in production. 

## Production Ready 

### Separating Refresh From Instances

At the moment, I believe that each instance of the service would try to refresh the cache at roughly the same time due to each instance having the same job. To work around this you could instead create an endpoint and move the job onto a lambda which runs separate from the main application. 
