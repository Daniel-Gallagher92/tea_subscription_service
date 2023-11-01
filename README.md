![image](https://github.com/Daniel-Gallagher92/tea_subscription_service/assets/64923238/c767d806-470f-42be-aec2-f1553dd2a7f2)

![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)
![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![Postgresql](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)

# Tea Subscription Service API
This application serves as a back end API that exposed endpoints for a front end team to allow an end user to create a new subscription, cancel and active subscription as well as view all of their subscriptions including both active and inactive subscriptions. 

## RESTful Endpoints

<details close>


### Get a Customer's Subscriptions

```http
GET /api/v1/customers/:customer_id/subscriptions
```

<details close>
<summary>  Details </summary>
<br>
    
Parameters: <br>
```
No Parameters
```

| Code | Description |
| :--- | :--- |
| 200 | `OK` |

Example Value:

```json
{
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "title": "Green Tea Subscription",
                "price": 15.00,
                "status": "cancelled",
                "frequency": "biweekly",
                "customer_id": 1,
                "tea_id": 1
            }
        },
        {
            "id": "2",
            "type": "subscription",
            "attributes": {
                "title": "Black Tea Subscription",
                "price": 20.00,
                "status": "active",
                "frequency": "weekly",
                "customer_id": 1,
                "tea_id": 2
            }
        },
        {
            "id": "3",
            "type": "subscription",
            "attributes": {
                "title": "White Tea Subscription",
                "price": 30.00,
                "status": "cancelled",
                "frequency": "monthly",
                "customer_id": 1,
                "tea_id": 3
            }
        }
    ]
}
```

</details>

---

### Create a Subscription

```http
POST /api/v1/customers/:customer_id/teas/:tea_id/subscriptions"
```

<details close>
<summary>  Details </summary>
<br>
    
Parameters: <br>
```
CONTENT_TYPE=application/json
```

| Code | Description |
| :--- | :--- |
| 201 | CREATED |

Example Value:

```json
{
    "data": {
        "id": "1",
        "type": "subscription",
        "attributes": {
            "title": "White Tea Subscription",
            "price": 30.00,
            "status": "active",
            "frequency": "Monthly",
            "customer_id": 1,
            "tea_id": 3
        }
    }
}
```
</details>

---

### Update a Subscription

```http
PATCH /api/v1/customers/:customer_id/teas/:tea_id/subscriptions/:subscription_id
```

<details close>
<summary>  Details </summary>
<br>
    
Parameters: <br>
```
CONTENT_TYPE=application/json
```

Example Payload: <br>
```
{
  "subscription": {
    "status": "cancelled"
  }
}
```
| Code | Description |
| :--- | :--- |
| 200 | OK |

Example Value:

```json
{
    "data": {
        "id": "1",
        "type": "subscription",
        "attributes": {
            "title": "White Tea Subscription",
            "price": 30.00,
            "status": "cancelled",
            "frequency": "Monthly",
            "customer_id": 1,
            "tea_id": 3
        }
    }
}
```
</details>
</details>
## Database Schema  
<img width="1006" alt="Screenshot 2023-11-01 at 4 40 06 PM" src="https://github.com/Daniel-Gallagher92/tea_subscription_service/assets/64923238/fecb544f-a09d-4303-b0b8-6aff70257af0">


## Status Codes

Tea Subscriptions returns the following status codes in its API:

| Status Code | Description |
| :--- | :--- |
| 200 | `OK` |
| 201 | `CREATED` |
| 400 | `BAD REQUEST` |
| 404 | `NOT FOUND` |
| 500 | `INTERNAL SERVER ERROR` |

## Prerequisites
Running this project requires:
- Rails 7.0.8
- Ruby 3.2.2
- Gems: jsonapi-serializer | factory_bot_rails | faker | shoulda-matchers

## Installation

1. Fork and clone this repository
2. `cd` into the root directiory
3. `bundle install`
4. `rails db:{drop,create,migrate,seed}`
5. Run the test suite with `bundle exec rspec`. There should be 27 passing tests.
6. Start the local server by running `rails s`
7. Explore each endpoint using a base url of `localhost:3000` in Postman or curl.
