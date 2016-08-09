# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

### Data

plz rails generate model user id:string:uniq name:string email:string photo:string

plz rails generate model task id:string:primary_key created_at:datetime modified_at:datetime name:string notes:text completed:boolean assignee_status:string completed_at:datetime due_on:datetime due_at:datetime workspace:string:index num_hearts:integer assignee_id:string:index parent_id:string:index hearted:boolean
