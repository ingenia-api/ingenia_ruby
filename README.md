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
                "icecream":105075, 
                "positve":105076
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

**response:**

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

Classification will only work once you have done some training and Ingenia has an understanding of your Tags.

```ruby
Nowa::Api.classify "what is the difference between ruby on rails and rake?"
```

**response:** 

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

###Similar To
Find Items that are similar to a given Item, by both tags and words.

```ruby
item = Nowa::Item.create("What is similar to me?")
Nowa::Api.similar_to item['id']
```

**response:** 

```plaintext
  {"ki"=>{"id"=>394688}, "mode"=>"tag", "distance"=>0.4}
```

  

## Items
Items are text items, optionally with tags, that you want to permanently store on Ingenia for use with similar-to or to be continually classified. 

When you create one Ingenia will return a unique id that lets you keep track of the item - you should store this on your system.

### Create a plain Item
```ruby
Nowa::Item.create("How long do elephants remember?")
```

### Create an Item with Tags
To create an item with tags, you must first have created the tags and have their ids, then pass them as an array.

```ruby
Nowa::Item.create("How long to elephants remember?", [32, 51, 6])
```

### Item CRUD
	item = Nowa::Item.create("How do you make cheese?")
	
	# Store the item id
	id = item['id']
	
	# update the item
	item = Nowa::Item.update(id, "How do you eat cheese?")
	
	# Get an item, together with it's most recent classifications
	item = Nowa::Item.get(id)
	
	# Remove an item
	Nowa::Item.delete(id)
	

## Tags
Tags, or categories, are meaningful words or expressions that you want to associate with your content.

### Create a tag
```ruby
Nowa::Tag.create("Science", 10)
```

### Tag CRUD
	tag = Nowa::Tag.create("Science", 10)
		
	# Store the tag id
	id = tag['id']
	
	# update the tag
	tag = Nowa::Tag.update(id, "Scientific Theory")
	
	# Get a tag
	tag = Nowa::Tag.get(id)
	
	# Remove a tag
	Nowa::Tag.delete(id)
	

## Tag Sets
Tag sets are thematically consistent groups of tags, such as, say, world countries, business sectors, product types, companies, concepts, topics, etc. 
Tag Sets are used to groups tags that share a common meaning. For example, tags that relate to the subject of an item ("science", "marketing") could be separated from ones that relate to urgency, sender or document type.  

Each tag must belong to at least one set. 

Classification calls will show tags grouped by their tagsets.

### Create a TagSet
```ruby
Nowa::TagSet.create("Topic")
```

### TagSet CRUD
	tagset = Nowa::TagSet.create("Urgency")
		
	# Store the tagset id
	id = tagset['id']
	
	# update the tagset
	tagset = Nowa::TagSet.update(id, "Sender Type")
	
	# Get a tagset
	tagset = Nowa::TagSet.get(id)
	
	# Remove a tagset
	Nowa::TagSet.delete(id)


## More Information

See http://ingeniapi.com/reference for more details of the API.



## License

&#169; 2013 Retechnica
