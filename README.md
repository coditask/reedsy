# README

#Preface
Hello, my name is Ravi Kumar and 34 years old. I have completed my masters in Communication and Signal processing from IIT Bombay, India.
Just after finishing my masters, I moved to Tokyo to work as Web developer for Rakuten. After living there for 3 years, I moved to Germany.I have a long experience of working with ruby on Rails.
I like to traveling, listening to the music, learning about finance and stock market. In my studies, I consider securing a place in India's best engineering college is an achievement for me.\
I have long experience of working with Ruby on Rails.

I started my career with an established huge company Rakuten in Tokyo. After working there for 3 years I decided to move to Germany.
Since then I have worked in different companies and sectors. 
Currently, I am working at YogaEasyGmbH in Hamburg. I have mostly the back-end experience with little bit of front-end technologies with Angular.
With Rails, I have experience of creating APIs, integrating payment systems, search engines like Solr.
Some of the good projects I have worked on are
- Allowing 3DSecure payments for creditcards at YogaEasy.
- Integrating Okta Omniauth login
- Adding coupon redemptions at YogaEasy

#Setup
###Ruby requirement: **3.1.0*

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