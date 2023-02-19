@Docs = new Meteor.Collection 'docs'

if Meteor.isClient 
    Template.registerHelper '_when', () -> moment(@_timestamp).fromNow()
    Template.registerHelper '_author', () -> Meteor.users.findOne @_author_id

    Template.home.onCreated ->
        @autorun => @subscribe 'chat', ->
        @autorun => @subscribe 'users', ->
    Template.home.events
        'keyup .new_message': (e)->
            if e.which is 13
                val = $('.new_message').val().trim()
                if val.length > 0
                    Docs.insert 
                        model:'message'
                        body:val
    Template.home.helpers
        message_docs: ->
            Docs.find 
                model:'message'
    
if Meteor.isServer
    Docs.allow
        insert: (userId, doc) -> 
            true    
            # doc._author_id is userId
        update: (userId, doc) ->
            true
            # if doc.model in ['calculator_doc','simulated_rental_item','healthclub_session']
            #     true
            # else if Meteor.user() and Meteor.user().roles and 'admin' in Meteor.user().roles
            #     true
            # else
            #     doc._author_id is userId
        # update: (userId, doc) -> doc._author_id is userId or 'admin' in Meteor.user().roles
        remove: (userId, doc) -> 
            true
            # doc._author_id is userId or 'admin' in Meteor.user().roles
    
    Meteor.publish 'chat', ->
        Docs.find 
            model:'message'
            
    Meteor.publish 'users', ->
        Meteor.users.find {},
            fields:
                username:1
                image_id:1
                tags:1
            
            
            
            