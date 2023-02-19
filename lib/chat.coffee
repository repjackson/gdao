@Docs = new Meteor.Collection 'docs'

if Meteor.isClient 
    $.cloudinary.config
        cloud_name:"facet"
    
    Template.registerHelper '_when', () -> moment(@_timestamp).fromNow()
    Template.registerHelper '_author', () -> Meteor.users.findOne @_author_id

    Template.home.onCreated ->
        @autorun => @subscribe 'chat', ->
        @autorun => @subscribe 'users', ->
            
    Template.message_item.events
        'click .vote_up': ->
            Docs.update @_id,
                $inc:
                    points:1
                $addToSet:
                    upvoter_ids:Meteor.userId()
        'click .vote_down': ->
            Docs.update @_id,
                $inc:
                    points:-1
                $addToSet:
                    downvoter_ids:Meteor.userId()
                    
    Template.home.events
        'hover .tada': (e,t)-> $(e.currentTarget).closest('.tada').transition('pulse', 500)
        'click .fly_right': (e,t)-> $(e.currentTarget).closest('.grid').transition('fade right', 500)
        'click .zoom': (e,t)-> $(e.currentTarget).closest('.grid').transition('drop', 500)
        'click .fade_left': (e,t)-> 
            $(e.currentTarget).closest('.card').transition('fade left', 500)
            $(e.currentTarget).closest('.grid').transition('fade left', 500)
        'click .fade_down': (e,t)-> $(e.currentTarget).closest('.grid').transition('fade down', 500)
        'click .fly_down': (e,t)-> $(e.currentTarget).closest('.grid').transition('fly down', 500)
        # 'click .button': ->
        #     $(e.currentTarget).closest('.button').transition('bounce', 1000)
    
        # 'click a(not:': ->
        #     $('.global_container')
        #     .transition('fade out', 200)
        #     .transition('fade in', 200)
    
        'click .log_view': ->
            # console.log Template.currentData()
            # console.log @
            Docs.update @_id,
                $inc: views: 1
            
            
    Template.home.events
        'keyup .new_message': (e)->
            if e.which is 13
                val = $('.new_message').val().trim()
                if val.length > 0
                    Docs.insert 
                        model:'message'
                        body:val
                val = $('.new_message').val('')
                $('body').toast("#{val} message added")
                
    Template.home.helpers
        message_docs: ->
            Docs.find 
                model:'message'
    
if Meteor.isServer
    Cloudinary.config
        cloud_name: 'facet'
        api_key: Meteor.settings.cloudinary_key
        api_secret: Meteor.settings.cloudinary_secret
    
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
            
            
            
            