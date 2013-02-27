
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
    "tag_sets": {
      "TAG_SET_NAME": {
        "id": TAG_SET_ID,
        "tags", { 
          "TAG_1": TAG_1_ID, 
          "TAG_2": TAG_2_ID, 
          ..., 
          "TAG_N": TAG_N_ID 
        }
      }
    }
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
  
  See above.


**Classify**

```ruby
Nowa::Api.classify "This is some text to classify"
```

response:   

```plaintext
  {
    "classification_status":"STATUS",
    "results":{
      "TAG_SET_NAME":{
        "tags":[
          { "id": TAG_ID_1, "name": "TAG_NAME_1", "score": SCORE_1 },
          { "id": TAG_ID_2, "name": "TAG_NAME_2", "score": SCORE_2 },
          ...
          { "id": TAG_ID_N, "name": "TAG_NAME_N", "score": SCORE_N }
        ],
        "id":9
      }
    }
  }
```

notes:
  
  Classification status can be one of:
  *  classified: normal response with all fields filled.
  *  unrecognised: no classification was possible, empty results state.
  *  timeout: classifier was too busy at the time the call was made.

  Tag sets are not guarenteed to be in any particular order.
  Tag set tags are ordered by score with a maximum of six tags per tag set.
  Tag scores are always to 4 decimal places.
  



## More Information

See http://ingenia.com/reference for full low level API specifications.



## License

Copyright (c) 2013 Retechnica
