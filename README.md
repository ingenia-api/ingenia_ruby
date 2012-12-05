# Ingenia Ruby gem
Ruby public interface to classify text

## Installation
```sh
gem install nowa_api
```


<!-- ## Configuration
**Set your API key**
```ruby

``` -->

## Usage Examples

**Train**

```ruby
Nowa::Api.learn '<API_KEY>', "Learn from this text", [ 'some', 'tags', 'for', 'this', 'text' ]
```

**More complicated train with sets of tags**

```ruby
Nowa::Api.learn '<API_KEY>', "Learn from this text", { 'Subject' => [ 'learning', 'examples' ], 'Category' => [ 'help' ] }
```
      

**Classify**

```ruby
Nowa::Api.classify '<API_KEY>', "This is some text to classify"
```
   
**Status**

```ruby
Nowa::Api.user_status key
```
returns hash of all the tags where each tag shows whether it has been learnt from 
and its name and the number of KIs. Also shows total number of KIs
 
## Manual tests

Note: windows does not correctly handle single and double quotes, so the following examples will not work on windows

## classify

  request:
    
    curl "http://ingeniapi.com/classify?auth_token=<API KEY>" -d 'api_version=1.0&text=text to classify'

  response:
    
    {
        "classification_status":"complete",
        "results":{
            "category":{
                "education":0.148,
                "economics":0.013
            },
            "geography":{
                "europe":1.0
            } 
        },
        "api_version":"1.0",
        "status":"okay"
    }


## train

  - with simple tag array

  request: 
    
    curl -X POST "http://ingeniapi.com/train?auth_token=<API KEY>" -d 'api_version=1.0&text=text to train&tags=["University","Exam"]'

  response:

    { 
      "training_id":350288,
      "api_version":"1.0",
      "status":"okay"
    }

  - with complex tagset

  request:

    curl -X POST "http://ingeniapi.com/train?auth_token=<API KEY>" -d 'api_version=1.0&text=text to train&tag_sets={"Type":["University","Exam"],"Topics":["Software"],"Keywords":["Distinction"]}'

  response:

    { 
      "training_id":350289,
      "api_version":"1.0",
      "status":"okay"
    }

