# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

**Ruby version**
  3.2.2

**System dependencies**
  
- Redis server - 6.0.16
- Elastic Search - 7.17.9

**Configuration**

**Database creation**
  
- rails db:create
- rails db:migrate
- rails db:seed

**How to run the test suite**
- rspecs

**Services (job queues, cache servers, search engines, etc.)**
- redis-server
- bundle exec sidekiq

**Deployed to Heroku**

https://amprotocol-assessment.herokuapp.com/

Elastic search is not working on heroku unable to configure ES on heroku. However its working on local

**Postman Api**
[Postman Collection link] (https://www.postman.com/navigation-saganist-4951077/workspace/assessment/request/16358007-c84f1747-f73f-40ca-931b-78c50b5f0c4f “Postman”)

**About the project**
- I have not used api/v1 convention since its an assessment and there won't be any other version of this api.
- I have wrote rspecs to a certain degree just. I deliberately didn't cover each and every endpoint to save time since its just an assessment.However I have covered all the major endpoints.
- I deliberatly pushed .env to git so you won't have to struggle in configurating news and sendinblue. 
- Incase if I have skipped anything feel free to reach out to me.