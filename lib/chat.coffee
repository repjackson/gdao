@Docs = new Meteor.Collection 'docs'

if Meteor.isClient 
    Template.home.onCreated ->
        @autorun => @subscribe 'chat', ->
    Template.home.helpers
        message_docs: ->
            Docs.find 
                model:'message'
    
if Meteor.isServer
    Meteor.publish 'chat', ->
        Docs.find 
            model:'message'