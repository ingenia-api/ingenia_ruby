
# Ingenia Ruby gem
A Gem to wrap the Ingenia API


### Installation
```sh
gem install nowa_api
```


### Configuration

Before any call is made you must first set your ingeniapi API key:

```ruby
Nowa::Api.api_key = 'YOUR_KEY'
```



## Usage Examples

###Training
To make an API call to show ingenia that some text is known to be associated with some tags. This action also creates an Item.

```ruby
Nowa::Api.train "I enjoy icecream", [ 'food', 'icecream', 'positive' ]
```

**response:**

```plaintext
  {
    "tag_sets":
      {
        "Default":
          {
            "id":156, 
            "tags":
              {
                "food":105074, 
                "icecream"=>105075, 
                "positve"=>105076
              }
          }
      }, 
    "training_id":385872
  }
```


###Training with sets of tags
Train ingenia that a text item is associated with tags in different groups, or Tag Sets.

```ruby
Nowa::Api.train "Is icecream safe?", { 'Subject' => [ 'food', 'safety' ], 'Category' => [ 'question' ] }
```

response:

```plaintext
  {
    "tag_sets":
      {
        "Subject":
          {
            "id":158, 
            "tags":
              {
                "food":105081, 
                "safety":105075
              }
          },
        "Category":
          {
            "id":159, 
            "tags":
              {
                "question":105082
              }
          }
      }, 
    "training_id":385872
  }
```
 

###Classification
Ask Ingenia to identify which tags are most relevant to some text. This call does not create an Item.

```ruby
Nowa::Api.classify "what is the difference between ruby on rails and rake?"
```

response:   

```plaintext
  {
    "classification_status":"complete", 
    "results":{
      "Software":{
        "tags":[
          {"id":1951, "name":"ruby on rails", "score":1.0}, 
          {"id":2092, "name":"ruby", "score":1.0}, 
          {"id":4822, "name":"rake", "score":0.362}
        ], 
        "id":9
      }
    }
  }
```

notes:

- Tag set tags are ordered by score with a maximum of six tags per tag set.
- Tag scores are always to 4 decimal places - 1.0 being the strongest affinity and 0.001 the weakest.
  



## More Information

See http://ingeniapi.com/reference for more details of the API.



## License

Copyright (c) 2013 Retechnica
