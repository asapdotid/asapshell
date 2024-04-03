#!/bin/bash

alias pa='php artisan'

# Available commands:
alias pa:clear-compiled='php artisan clear-compiled'        # Remove the compiled class file
alias pa:down='php artisan down'                            # Put the application into maintenance mode
alias pa:env='php artisan env'                              # Display the current framework environment
alias pa:help='php artisan help'                            # Displays help for a command
alias pa:inspire='php artisan inspire'                      # Display an inspiring quote
alias pa:list='php artisan list'                            # Lists commands
alias pa:migrate='php artisan migrate'                      # Run the database migrations
alias pa:optimize='php artisan optimize'                    # Cache the framework bootstrap files
alias pa:serve='php artisan serve'                          # Serve the application on the PHP development server
alias pa:test='php artisan test'                            # Run the application tests
alias pa:tinker='php artisan tinker'                       # Interact with your application
alias pa:up='php artisan up'                               # Bring the application out of maintenance mode
#  Auth
alias pa:auth:clear='php artisan auth:clear-resets'        # Flush expired password reset tokens
#  Cache
alias pa:cache:clear='php artisan cache:clear'             # Flush the application cache
alias pa:cache:forget='php artisan cache:forget'           # Remove an item from the cache
alias pa:cache:table='php artisan cache:table'             # Create a migration for the cache database table
#  Config
alias pa:config:cache='php artisan config:cache'            # Create a cache file for faster configuration loading
alias pa:config:clear='php artisan config:clear'            # Remove the configuration cache file
#  Db
alias pa:db:seed='php artisan db:seed'                      # Seed the database with records
alias pa:db:wipe='php artisan db:wipe'                      # Drop all tables, views, and types
#  Event
alias pa:event:cache='php artisan event:cache'              #Discover and cache the application's events and listeners
alias pa:event:clear='php artisan event:clear'              #Clear all cached events and listeners
alias pa:event:generate='php artisan event:generate'        #Generate the missing events and listeners based on registration
alias pa:event:list='php artisan event:list'                #List the application's events and listeners
#  Key
alias pa:key:generate='php artisan key:generate'            # Set the application key
#  Make
alias pa:make:channel='php artisan make:channel'              # Create a new channel class
alias pa:make:command='php artisan make:command'              # Create a new Artisan command
alias pa:make:component='php artisan make:component'          # Create a new view component class
alias pa:make:controller='php artisan make:controller'        # Create a new controller class
alias pa:make:event='php artisan make:event'                  # Create a new event class
alias pa:make:exception='php artisan make:exception'          # Create a new custom exception class
alias pa:make:factory='php artisan make:factory'              # Create a new model factory
alias pa:make:job='php artisan make:job'                      # Create a new job class
alias pa:make:listener='php artisan make:listener'            # Create a new event listener class
alias pa:make:mail='php artisan make:mail'                    # Create a new email class
alias pa:make:middleware='php artisan make:middleware'        # Create a new middleware class
alias pa:make:migration='php artisan make:migration'          # Create a new migration file
alias pa:make:model='php artisan make:model'                  # Create a new Eloquent model class
alias pa:make:notification='php artisan make:notification'    # Create a new notification class
alias pa:make:observer='php artisan make:observer'            # Create a new observer class
alias pa:make:policy='php artisan make:policy'                # Create a new policy class
alias pa:make:provider='php artisan make:provider'            # Create a new service provider class
alias pa:make:request='php artisan make:request'              # Create a new form request class
alias pa:make:resource='php artisan make:resource'            # Create a new resource
alias pa:make:rule='php artisan make:rule'                    # Create a new validation rule
alias pa:make:seeder='php artisan make:seeder'                # Create a new seeder class
alias pa:make:test='php artisan make:test'                    # Create a new test class
#  Migrate
alias pa:migrate:fresh='php artisan migrate:fresh'               # Drop all tables and re-run all migrations
alias pa:migrate:install='php artisan migrate:install'           # Create the migration repository
alias pa:migrate:refresh='php artisan migrate:refresh'           # Reset and re-run all migrations
alias pa:migrate:reset='php artisan migrate:reset'               # Rollback all database migrations
alias pa:migrate:rollback='php artisan migrate:rollback'         # Rollback the last database migration
alias pa:migrate:status='php artisan migrate:status'             # Show the status of each migration
#  Notifications
alias pa:notification:table='php artisan notifications:table'         # Create a migration for the notifications table
#  Optimize
alias pa:optimize:clear='php artisan optimize:clear'              # Remove the cached bootstrap files
#  Package
alias pa:package:discover='php artisan package:discover'        # Rebuild the cached package manifest
#  Queue
alias pa:queue:failed='php artisan queue:failed'                # List all of the failed queue jobs
alias pa:queue:failed-t='php artisan queue:failed-table'        # Create a migration for the failed queue jobs database table
alias pa:queue:flush='php artisan queue:flush'                  # Flush all of the failed queue jobs
alias pa:queue:forget='php artisan queue:forget'                # Delete a failed queue job
alias pa:queue:listen='php artisan queue:listen'                # Listen to a given queue
alias pa:queue:restart='php artisan queue:restart'              # Restart queue worker daemons after their current job
alias pa:queue:retry='php artisan queue:retry'                  # Retry a failed queue job
alias pa:queue:table='php artisan queue:table'                  # Create a migration for the queue jobs database table
alias pa:queue:work='php artisan queue:work'                    # Start processing jobs on the queue as a daemon
#  Route
alias pa:route:cache='php artisan route:cache'                  # Create a route cache file for faster route registration
alias pa:route:clear='php artisan route:clear'                  # Remove the route cache file
alias pa:route:list='php artisan route:list'                    # List all registered routes
#  Schedule
alias pa:schedule:run='php artisan schedule:run'                 # Run the scheduled commands
#  Session
alias pa:session:table='php artisan session:table'              # Create a migration for the session database table
#  Storage
alias pa:storage:link='php artisan storage:link'                # Create the symbolic links configured for the application
#  Stub
alias pa:stub:publish='php artisan stub:publish'            # Publish all stubs that are available for customization
#  Vendor
alias pa:vendor:publish='php artisan vendor:publish'        # Publish any publishable assets from vendor packages
# view
alias pa:view:cache='php artisan view:cache'                   # Compile all of the application's Blade templates
alias pa:view:clear='php artisan view:clear'                   # Clear all compiled view files
