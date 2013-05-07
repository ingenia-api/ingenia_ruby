
# Ingenia Ruby gem

A Gem to wrap the API calls of Ingenia.


## Installation
```sh
gem install nowa_api
```



## Conventions used in this document 

All text in UPPERCASE represents a changeable field, either user supplied or as part of a response.




## Configuration

Before any call is made you must first set API key. At the moment this done in module code so the key must be changed if more than one key is being used.

```ruby
Nowa::Api.api_key = 'YOUR_KEY'
```



## Errors and Exceptions

Exceptions raised by the HTTP, JSON or API calls are all funnelled through a Nowa::Api::CallFailed exception.




## Usage Examples

**Train**

```ruby
Nowa::Api.train "Learn from this text", [ 'some', 'tags', 'for', 'this', 'text' ]
```

response:

```plaintext
  {
    "tag_sets":
      {
        "Default":
          {
            "id":156, 
            "tags":
              {
                "some":105074, 
                "tags"=>105075, 
                "for"=>105076, 
                "this"=>105077, 
                "text"=>105078
              }
          }
      }, 
    "training_id":385872
  }
```

notes:
  
Tag set "id" fields and tag TAG_N_ID fields represent the internal ID of those data structures. These
values are not currently used by any API as passable arguments and so do not need to be stored by the
end user.



**More complicated train with sets of tags**

```ruby
Nowa::Api.train "Learn from this text", { 'Subject' => [ 'learning', 'examples' ], 'Category' => [ 'help' ] }
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
                "learning":105081, 
                "examples":105075
              }
          },
        "Category":
          {
            "id":159, 
            "tags":
              {
                "help":105082
              }
          }
      }, 
    "training_id":385872
  }
```
 

**Classify**

```ruby
Nowa::Api.classify "This is some text to classify about ruby on rails and rake"
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
  
Classification status can be one of:
*  complete: normal response with all fields filled.
*  unrecognised: no classification was possible, empty results state.
*  timeout: classifier was too busy at the time the call was made.
*  not_run: some other error stopped the classifications from returning

Tag sets are not guarenteed to be in any particular order.
Tag set tags are ordered by score with a maximum of six tags per tag set.
Tag scores are always to 4 decimal places.
  



## More Information

See http://ingenia.com/reference for full low level API specifications.



## License

Copyright (c) 2013 Retechnica
