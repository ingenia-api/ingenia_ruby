Nowa-API-gem
============

Ruby public interface to classify text


# How to use and what you get back

    # require gem
    require 'nowa-api'

    # define user key, get this from retechnica
    key = 'Behdv67nNBpZe8szhwTW'

    ##########

    # when you want to classify some text call Nowa::Api.classify
    res = Nowa::Api.classify key, "This is some text to classify"

    # if we can classify in under 10 seconds we will return the tags to the caller
    # if it takes longer than ten seconds res[:status] != 'classification_complete'
    # if you send the same text again we will return the status of the classification

    ##########

    # when you want to train the system for your tags, send tags as array like so
    res = Nowa::Api.learn key, "Learn from this text", [ 'some', 'tags', 'for', 'this', 'text' ]

    # this will always return with a status 
    # you can then send the text again to the classify to get the tags that have been assigned

    ##########

    # to get status of system for what we know about you
    res = Nowa::Api.user_status key

    # returns hash of all the tags where each tag shows whether it has been learnt from 
    # and its name and the number of KIs. Also shows total number of KIs
