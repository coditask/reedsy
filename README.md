# README

#Setup
###Ruby requirement: **3.1.0**

Download the application. And run
```
rake db:migrate
rake db:seed
rails s
```

### API endpoints
```
GET /v1/store/:store_id/items.json
```
Returns all the items of a specific merchandise store
####Request parameters
| Parameter 	 | Type 	    | Required  	 | Default	 | Example |
|-------------|-----------|-------------|----------|---------|
| page 	      | Integer 	 | No	         | 	1       | 2       |
| per	        | Integer	  | No	         | 	25      | 10      |

####Response
```json
[
  {
    "code": "MUG",
    "name": "Reedsy Mug",
    "price": 600
  },
  {
    "code": "TSHIRT",
    "name": "Reedsy T-shirt",
    "price": 1500
  },
  {
    "code": "HOODIE",
    "name": "Reedsy Hoodie",
    "price": 2000
  }
]
```

```
PATCH /v1/store/:store_id/items/:id/update_price
```
Updates the price of a item
####Request parameters
| Parameter 	 | Type 	    | Required  	 | Example |
|-------------|-----------|-------------|---------|
| price 	     | Integer 	 | Yes	        | 1200    |

####Response
Success
```
:no_content
```
Error: price is not passed
```
:unprocessable_entity
```

```
GET /v1/store/:store_id/items/add_price
```
Returns the total price of all passed items
####Request parameters
| Parameter 	 | Type 	   | Required  	 |Example|
|-------------|----------|-------------|-------|
| item_codes 	      | String 	 | No	         |   MUG, TSHIRT, HOODIE    |

####Response
```json
{
  "items": "MUG, TSHIRT, HOODIE",
  "total": "41.00€"
}
```