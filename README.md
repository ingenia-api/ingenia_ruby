# Ingenia Ruby gem
A gem to wrap the [Ingenia API](https://www.ingeniapi.com/documentation) 

This readme covers the basics of the Ingenia API, but you can do so many more interesting things by using the examples of the API documentation as a guide.
 


### Installation
```sh
gem install ingenia_api https://www.ingeniapi.com/documentation
```


### Configuration

Before any call is made, first set your ingeniapi API key:

```ruby
Ingenia::Api.api_key = 'YOUR_KEY'
```

Optionally setup the version of the API you wish to use, the default is 2.0
```ruby
Ingenia::Api.version = 2.0
```


## Usage Examples

###Training
To make an API call to show ingenia that some text is known to be associated with some tags. This action also creates an Item.

```ruby
Ingenia::Api.train("I enjoy ice cream", [ 'food', 'ice cream', 'positive' ])
```

**response:**

```plaintext
  {
     "bundle_id":525,
     "created_at":"2015-06-30T09:10:36Z",
     "id":"62eb0d5ddef05b9a45ba61c6733dc0b3",
     "last_classified_at":"2015-06-30T09:10:36Z",
     "updated_at":"2015-06-30T09:10:36Z",
     "text":"I enjoy ice cream",
     "tag_sets":[
        {
           "New Tag Set":{
              "id":1803,
              "tags":[
                 {
                    "id":175983,
                    "name":"food",
                    "user_selected":"t",
                    "user_assigned":true,
                    "score":"0.0",
                    "machine_score":"0",
                    "rule_score":null,
                    "user_assigned_score":"0"
                 },
                 {
                    "id":175984,
                    "name":"ice cream",
                    "user_selected":"t",
                    "user_assigned":true,
                    "score":"0.0",
                    "machine_score":"0",
                    "rule_score":null,
                    "user_assigned_score":"0"
                 },
                 {
                    "id":175985,
                    "name":"positive",
                    "user_selected":"t",
                    "user_assigned":true,
                    "score":"0.0",
                    "machine_score":"0",
                    "rule_score":null,
                    "user_assigned_score":"0"
                 }
              ]
           }
        }
     ]
  }
```


###Training with sets of tags
Train ingenia that a text item is associated with tags in different groups, or Tag Sets.

```ruby
Ingenia::Api.train("Is ice cream safe?", { 'Subject' => [ 'food', 'safety' ], 'Category' => [ 'question' ] })
```

**response:**

```plaintext
  {
     "bundle_id":525,
     "created_at":"2015-06-30T09:16:13Z",
     "id":"d834435bac0aa8b2d64e6c9fe2a67544",
     "last_classified_at":"2015-06-30T09:16:13Z",
     "updated_at":"2015-06-30T09:16:13Z",
     "text":"Is ice cream safe?",
     "tag_sets":[
        {
           "Subject":{
              "id":1880,
              "tags":[
                 {
                    "id":175986,
                    "name":"food",
                    "user_selected":"t",
                    "user_assigned":true,
                    "score":"0.0",
                    "machine_score":"0",
                    "rule_score":null,
                    "user_assigned_score":"0"
                 },
                 {
                    "id":175987,
                    "name":"safety",
                    "user_selected":"t",
                    "user_assigned":true,
                    "score":"0.0",
                    "machine_score":"0",
                    "rule_score":null,
                    "user_assigned_score":"0"
                 }
              ]
           }
        },
        {
           "Category":{
              "id":1881,
              "tags":[
                 {
                    "id":175988,
                    "name":"question",
                    "user_selected":"t",
                    "user_assigned":true,
                    "score":"0.0",
                    "machine_score":"0",
                    "rule_score":null,
                    "user_assigned_score":"0"
                 }
              ]
           }
        }
     ]
  }
```
 

###Classification
Ask Ingenia to identify which tags are most relevant to some text. This call does not create an Item.

Classification will only work once you have done some training and Ingenia has an understanding of your Tags.

```ruby
Ingenia::Api.classify("what is the difference between ruby on rails and rake?")
```

**response:** 

```plaintext
{
  "status": "okay",
  "api_version": "2.0",
  "data": {
    "classification_status": "complete",
    "text": "what is the difference between ruby on rails and rake?",
    "results": {
      "Software": {
        "tags": [
          {
            "machine_score": 1.0,
            "name": "ruby",
            "id": 80953,
            "rule_score": 0,
            "score": 1.0
          },
          {
            "machine_score": 1.0,
            "name": "ruby in rails",
            "id": 80958,
            "rule_score": 0,
            "score": 1.0
          },
          {
            "machine_score": 0.6325,
            "name": "rake",
            "id": 80951,
            "rule_score": 0,
            "score": 0.6325
          }
        ],
        "id": "42"
      }
    }
  }
}
```

notes:

- Tag set tags are ordered by score with a maximum of six tags per tag set.
- Tag scores are always to 4 decimal places - 1.0 being the strongest affinity and 0.001 the weakest.

###Similar To
Find Items that are similar to a given Item. Specify whether Ingenia should find similar items by their tags or items which have the most similar text.

```ruby
item = Ingenia::Item.create(json: { text: "Ice cream makes a great dessert in Summer", tags: [ 'food', 'dessert'] })
Ingenia::Item.similar_to(item['id'], :word)

```

**response:** 

```plaintext

  [
    {"item" => {
      "id" => "d834435bac0aa8b2d64e6c9fe2a67544",
      "text" => "Is ice cream safe?"},
      "mode" => "word",
      "similarity" => 0.411
    }
  ]
```

Alternatively, we can also retrieve items which are similar without creating new items with
```ruby
Ingenia::Api.similar_to(text: "Ice cream makes a great dessert in Summer", mode: 'word')

```


**response:**

```plaintext

  "status": "okay",
  "api_version": "2.0",
  "data": [
    {
      "item": {
        "id": "ce3330e8-5d4a-492d-b5de-0a5dd6511c7e",
        "text": "Everyone likes ice cream on their Summer holidays."
      },
      "mode": "word",
      "similarity": 0.673
    },
    {
      "item": {
        "id": "4290a3e4-6a62-4f5e-900d-0a98ad4f8c22",
        "text": "The best cakes are decorated with cream."
      },
      "mode": "word",
      "similarity": 0.202
    }
  ]
}
```


## Items
Items are text items, optionally with tags, that you want to permanently store on Ingenia.

When you create one Ingenia will return a unique id that lets you keep track of the item - you should store this on your system.

### Create a plain Item
```ruby
Ingenia::Item.create(json: { text: "How long do elephants remember?"})
```

### Create an Item with Tags (training)
This creats the tags if they do not already exist

```ruby
Ingenia::Item.create(json: { text: "Dolphins Have Longest Memories in Animal Kingdom", tags: ["animals", "memory"]})
```

### Create an Item with Tags in multiple TagSets (training)
This creates both the tag set and tags if they dont already exist.

```ruby
Ingenia::Item.create(json: { text: "True or False? Sea Lions Never Forget", tag_sets: { category: ["question"], subject: ["animals", "memory"] } } )
```


### Create an Item with Tags by id
To create an item with tags by id, you must first have created the tags and have their ids, then pass them as an array.

```ruby
Ingenia::Item.create(json: { text: "The Octopus Can Turbocharge Its Memory", tag_ids: [175994, 175995] } )
```


### Item CRUD
	item = Ingenia::Item.create(json: { text: "How do you make cheese?" })
	
	# Store the item id
	id = item['id']
	
	# update the item
	item = Ingenia::Item.update(id, json: { text: "How do you eat cheese?"})

	# Get an item, together with it's most recent classifications
	item = Ingenia::Item.get(id)
	
	# Remove an item
	Ingenia::Item.destroy(id)
	

## Tags
Tags, or categories, are meaningful words or expressions that you want to associate with your content.

### Create a tag
```ruby
  tag = Ingenia::Tag.create(name: "Science", tag_set_id: 1803)
```
### Tag CRUD
	tag = Ingenia::Tag.create(name: "Science", tag_set_id: 1803)
		
	# Store the tag id
	id = tag['id']
	
	# update the tag
	tag = Ingenia::Tag.update(id, name: "Scientific Theory")
	
	# Get a tag
	tag = Ingenia::Tag.get(id)
	
	# Remove a tag
	Ingenia::Tag.destroy(id)
	

## Tag Sets
Tag sets are thematically consistent groups of tags, such as, say, world countries, business sectors, product types, companies, concepts, topics, etc. 
Tag Sets are used to groups tags that share a common meaning. For example, tags that relate to the subject of an item ("science", "marketing") could be separated from ones that relate to urgency, sender or document type.  

Each tag must belong to at least one set. 

Classification calls will show tags grouped by their tagsets.

### Create a TagSet
```ruby
Ingenia::TagSet.create(name: "Topic")
```

### TagSet CRUD
	tagset = Ingenia::TagSet.create(name: "Urgency")
		
	# Store the tagset id
	id = tagset['id']
	
	# update the tagset
	tagset = Ingenia::TagSet.update(id, name: "Sender Type")
	
	# Get a tagset
	tagset = Ingenia::TagSet.get(id)
	
	# Remove a tagset
	Ingenia::TagSet.destroy(id)


## More Information

See http://ingeniapi.com/reference for more details of the API.



## License

&#169; 2015 Retechnica
