Future = Npm.require('fibers/future')

Meteor.methods
    STRIPE_single_charge: (charge, user) ->
        # console.log 'charge', charge
        # console.log 'user', user
        if Meteor.isDevelopment
            Stripe = StripeAPI(Meteor.settings.private.stripe_test_secret)
        else
            Stripe = StripeAPI(Meteor.settings.private.stripe_live_secret)
        # account = Meteor.users.findOne(data.church)
        # #console.log(data)
        # console.log '------------------------------------------------------'
        # console.log account
        # if !account.stripe
        #     retVal = error:
        #         error: 'Donation Failed'
        #         message: 'Not ready for donations, please contact your Organization.'
        #     return retVal
        # console.log account.stripe
        charge_card = new Future
        # fee_addition = 0
        # if account.profile.isJGFeesApply
        #     fee_addition = Math.round(data.amount * 100 * 0.019 + 70)
        # else
        #     fee_addition = Math.round(data.amount * 100 * 0.019 + 30)
        # #console.log(fee_addition);
        charge_data =
            amount: charge.amount
            currency: 'usd'
            source: charge.source
            description: "credit topup"
            # destination: account.stripe.stripeId
        Stripe.charges.create charge_data, (error, result) ->
            if error
                charge_card.return error: error
            else
                charge_card.return result: result
            return
        new_charge = charge_card.wait()
        console.log new_charge
        new_charge


    credit_topup: (charge) ->
        console.log 'charge', charge
        # console.log 'user', user
        if Meteor.isDevelopment
            Stripe = StripeAPI(Meteor.settings.private.stripe_test_secret)
        else
            Stripe = StripeAPI(Meteor.settings.private.stripe_live_secret)
        charge_card = new Future
        # fee_addition = 0
        # if account.profile.isJGFeesApply
        #     fee_addition = Math.round(data.amount * 100 * 0.019 + 70)
        # else
        #     fee_addition = Math.round(data.amount * 100 * 0.019 + 30)
        # #console.log(fee_addition);
        charge_data =
            amount: charge.amount
            currency: 'usd'
            source: charge.source
            description: "credit topup"
            # destination: account.stripe.stripeId
        Stripe.charges.create charge_data, (error, result) ->
            if error
                charge_card.return error: error
            else
                charge_card.return result: result
            return
        new_charge = charge_card.wait()
        console.log new_charge
        new_charge
        
        
    buy_membership: (charge) ->
        console.log 'charge', charge
        # console.log 'user', user
        if Meteor.isDevelopment
            Stripe = StripeAPI(Meteor.settings.private.stripe_test_secret)
        else
            Stripe = StripeAPI(Meteor.settings.private.stripe_live_secret)
        charge_card = new Future
        # fee_addition = 0
        # if account.profile.isJGFeesApply
        #     fee_addition = Math.round(data.amount * 100 * 0.019 + 70)
        # else
        #     fee_addition = Math.round(data.amount * 100 * 0.019 + 30)
        # #console.log(fee_addition);
        charge_data =
            amount: charge.amount
            currency: 'usd'
            source: charge.source
            description: "riverside membership"
            # destination: account.stripe.stripeId
        Stripe.charges.create charge_data, (error, result) ->
            if error
                charge_card.return error: error
            else
                charge_card.return result: result
            return
        new_charge = charge_card.wait()
        console.log new_charge
        if new_charge
            Docs.insert
                model:'transaction'
                transaction_type:'membership'
                amount:25000
                charge: new_charge
            Meteor.users.update Meteor.userId(),
                $inc: points:500
    
    
    buy_meal: (charge, meal_id) ->
        console.log 'charge', charge
        # console.log 'user', user
        if Meteor.isDevelopment
            Stripe = StripeAPI(Meteor.settings.private.stripe_test_secret)
        else
            Stripe = StripeAPI(Meteor.settings.private.stripe_dao_live_secret)
        charge_card = new Future
        # fee_addition = 0
        # if account.profile.isJGFeesApply
        #     fee_addition = Math.round(data.amount * 100 * 0.019 + 70)
        # else
        #     fee_addition = Math.round(data.amount * 100 * 0.019 + 30)
        # #console.log(fee_addition);
        charge_data =
            amount: charge.amount
            currency: 'usd'
            source: charge.source
            description: "buy tiffen"
            # destination: account.stripe.stripeId
        Stripe.charges.create charge_data, (error, result) ->
            if error
                charge_card.return error: error
            else
                charge_card.return result: result
            return
        new_charge = charge_card.wait()
        console.log 'new chaarge', new_charge
        if new_charge
            Docs.insert
                model:'mealorder'
                meal_id:meal_id
                transaction_type:'1 tiffen'
                amount:11
                charge: new_charge
    
    send_tip: (charge, dollar_debit_id) ->
        console.log 'charge', charge
        # console.log 'user', user
        if Meteor.isDevelopment
            Stripe = StripeAPI(Meteor.settings.private.stripe_test_secret)
        else
            Stripe = StripeAPI(Meteor.settings.private.stripe_dao_live_secret)
        charge_card = new Future
        # fee_addition = 0
        # if account.profile.isJGFeesApply
        #     fee_addition = Math.round(data.amount * 100 * 0.019 + 70)
        # else
        #     fee_addition = Math.round(data.amount * 100 * 0.019 + 30)
        # #console.log(fee_addition);
        charge_data =
            amount: charge.amount
            currency: 'usd'
            source: charge.source
            description: "tip"
            # destination: account.stripe.stripeId
        Stripe.charges.create charge_data, (error, result) ->
            if error
                charge_card.return error: error
            else
                charge_card.return result: result
            return
        new_charge = charge_card.wait()
        console.log new_charge
        if new_charge
            Docs.update dollar_debit_id,
                $set:
                    charge: new_charge
        
    buy_product: (charge) ->
        console.log 'charge', charge
        # console.log 'user', user
        if Meteor.isDevelopment
            Stripe = StripeAPI(Meteor.settings.private.stripe_test_secret)
        else
            Stripe = StripeAPI(Meteor.settings.private.stripe_live_secret)
        charge_card = new Future
        # fee_addition = 0
        # if account.profile.isJGFeesApply
        #     fee_addition = Math.round(data.amount * 100 * 0.019 + 70)
        # else
        #     fee_addition = Math.round(data.amount * 100 * 0.019 + 30)
        # #console.log(fee_addition);
        charge_data =
            amount: charge.amount
            currency: 'usd'
            source: charge.source
            description: charge.product_title
            # destination: account.stripe.stripeId
        Stripe.charges.create charge_data, (error, result) ->
            if error
                charge_card.return error: error
            else
                charge_card.return result: result
            return
        new_charge = charge_card.wait()
        console.log new_charge
        if new_charge
            Docs.insert
                model:'order'
                transaction_type:'shop_purchase'
                payment_type:'usd'
                is_usd:true
                amount:charge.amount
                product_id:charge.product_id
                charge: new_charge
            # Meteor.users.update Meteor.userId(),
            #     $inc: points:500
            Docs.update charge.product_id, 
                $inc:inventory:-1
    
    
    
    buy_ticket: (charge) ->
        console.log 'charge', charge
        # console.log 'user', user
        if Meteor.isDevelopment
            Stripe = StripeAPI(Meteor.settings.private.stripe_test_secret)
        else
            Stripe = StripeAPI(Meteor.settings.private.stripe_live_secret)
        charge_card = new Future
        # fee_addition = 0
        # if account.profile.isJGFeesApply
        #     fee_addition = Math.round(data.amount * 100 * 0.019 + 70)
        # else
        #     fee_addition = Math.round(data.amount * 100 * 0.019 + 30)
        # #console.log(fee_addition);
        charge_data =
            amount: charge.amount
            currency: 'usd'
            source: charge.source
            description: charge.event_title
            # destination: account.stripe.stripeId
        Stripe.charges.create charge_data, (error, result) ->
            if error
                charge_card.return error: error
            else
                charge_card.return result: result
            return
        new_charge = charge_card.wait()
        console.log new_charge
        if new_charge
            Docs.insert
                model:'order'
                transaction_type:'ticket_purchase'
                payment_type:'usd'
                is_usd:true
                amount:charge.amount
                event_id:charge.event_id
                charge: new_charge
            # Meteor.users.update Meteor.userId(),
            #     $inc: points:500
            Docs.update charge.event_id, 
                $inc:
                    tickets_purchased:1
                    
                    
                    
                    
# stripe = require('stripe')('sk_test_5103F9t2l80WEvLLPcQfRPWGFslvo4htyZRCjRQ4YQ8DnRO0Qp18WNWRw7KSOxX9N0f45WU0eYeGXpkAx9MnXkaa700I9qwX0HQ');
# Meteor.methods
#   stripe: ()=>
#     paymentIntent = stripe.paymentIntents.create({
#       amount: 1000,
#       currency: 'usd',
#       payment_method_types: ['card'],
#       receipt_email: 'jenny.rosen@example.com',
#     });


# stripe = require('stripe')
# # ('sk_test_5103F9t2l80WEvLLPcQfRPWGFslvo4htyZRCjRQ4YQ8DnRO0Qp18WNWRw7KSOxX9N0f45WU0eYeGXpkAx9MnXkaa700I9qwX0HQ');

# YOUR_DOMAIN = 'http://localhost:4242';

# # app.post('/create-checkout-session', async (req, res) => {
# Meteor.methods 
#     stripe: (req, res) =>
#         console.log 'stripe', stripe
#         session = stripe.checkout.sessions.create({
#             line_items: [
#                 {
#                 # // Provide the exact Price ID (for example, pr_1234) of the product you want to sell
#                     price: 'business',
#                     quantity: 1,
#                 },
#             ],
#             mode: 'payment',
#             success_url: "#{YOUR_DOMAIN}/success.html",
#             cancel_url: "#{YOUR_DOMAIN}/cancel.html",
#       })

Meteor.methods
    calc_user_stats: (user_id)->
        user = Meteor.users.findOne user_id
        gift_count =
            Docs.find(
                model:'gift'
                _author_id: user_id
            ).count()

        credit_count =
            Docs.find(
                model:'gift'
                target_id: user_id
            ).count()

        Meteor.users.update user_id,
            $set:
                gift_count:gift_count
                credit_count:credit_count


        gift_count_ranking =
            Meteor.users.find(
                {},
                sort:
                    gift_count: -1
                fields:
                    username: 1
            ).fetch()
        gift_count_ranking_ids = _.pluck gift_count_ranking, '_id'

        console.log 'gift_count_ranking', gift_count_ranking
        console.log 'gift_count_ranking ids', gift_count_ranking_ids
        my_rank = _.indexOf(gift_count_ranking_ids, user_id)+1
        console.log 'my rank', my_rank
        Meteor.users.update user_id,
            $set:
                global_gift_count_rank:my_rank


        credit_count_ranking =
            Meteor.users.find(
                {},
                sort:
                    credit_count: -1
                fields:
                    username: 1
            ).fetch()
        credit_count_ranking_ids = _.pluck credit_count_ranking, '_id'

        console.log 'credit_count_ranking', credit_count_ranking
        console.log 'credit_count_ranking ids', credit_count_ranking_ids
        my_rank = _.indexOf(credit_count_ranking_ids, user_id)+1
        console.log 'my rank', my_rank
        Meteor.users.update user_id,
            $set:
                global_credit_count_rank:my_rank


    calc_user_points: (user_id)->
        user = Meteor.users.findOne user_id
        debits = Docs.find({
            model:'debit'
            amount:$exists:true
            _author_id:user_id})
        debit_count = debits.count()
        total_debit_amount = 0
        for debit in debits.fetch()
            total_debit_amount += debit.amount

        console.log 'total debit amount', total_debit_amount

        credits = Docs.find({
            model:'debit'
            amount:$exists:true
            recipient_id:user_id})
        credit_count = credits.count()
        total_credit_amount = 0
        for credit in credits.fetch()
            total_credit_amount += credit.amount

        console.log 'total credit amount', total_credit_amount

        read_doc_count = 
            Docs.find(
                read_by_user_ids: $in: [user._id]
            ).count()
        console.log 'read user doc count', read_doc_count


        calculated_user_balance = total_credit_amount-total_debit_amount+read_doc_count


        Meteor.users.update user_id,
            $set:
                points:calculated_user_balance
                total_credit_amount: total_credit_amount
                total_debit_amount: total_debit_amount
                total_read_docs: read_doc_count






    calc_global_stats: ()->
        gs = Docs.findOne model:'global_stats'
        unless gs 
            Docs.insert 
                model:'global_stats'
        gs = Docs.findOne model:'global_stats'
        
        total_points = 0
        
        point_users = 
            Meteor.users.find 
                points: $exists:true
        for point_user in point_users.fetch()
            total_points += point_user.points
    
        console.log 'total points', total_points
        Docs.update gs._id,
            $set:total_points:total_points