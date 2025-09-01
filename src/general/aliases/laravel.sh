#!/bin/bash

alias pa='php artisan'

# Available commands:
alias ar:clear='php artisan clear-compiled'         # Remove the compiled class file
alias ar:down='php artisan down'                    # Put the application into maintenance mode
alias ar:env='php artisan env'                      # Display the current framework environment
alias ar:help='php artisan help'                    # Displays help for a command
alias ar:inspire='php artisan inspire'              # Display an inspiring quote
alias ar:list='php artisan list'                    # Lists commands
alias ar:migrate='php artisan migrate'              # Run the database migrations
alias ar:optimize='php artisan optimize'            # Cache the framework bootstrap files
alias ar:serve='php artisan serve'                  # Serve the application on the PHP development server
alias ar:test='php artisan test'                    # Run the application tests
alias ar:tinker='php artisan tinker'                # Interact with your application
alias ar:up='php artisan up'                        # Bring the application out of maintenance mode
#  Auth
alias ar:auth:clear='php artisan auth:clear-resets' # Flush expired password reset tokens
#  Cache
alias ar:ca:clear='php artisan cache:clear'   # Flush the application cache
alias ar:ca:forget='php artisan cache:forget' # Remove an item from the cache
alias ar:ca:table='php artisan cache:table'   # Create a migration for the cache database table
#  Config
alias ar:co:cache='php artisan config:cache' # Create a cache file for faster configuration loading
alias ar:co:clear='php artisan config:clear' # Remove the configuration cache file
#  Db
alias ar:db:seed='php artisan db:seed' # Seed the database with records
alias ar:db:wipe='php artisan db:wipe' # Drop all tables, views, and types
#  Event
alias ar:ev:cache='php artisan event:cache'       # Discover and cache the application's events and listeners
alias ar:ev:clear='php artisan event:clear'       # Clear all cached events and listeners
alias ar:ev:generate='php artisan event:generate' # Generate the missing events and listeners based on registration
alias ar:ev:list='php artisan event:list'         # List the application's events and listeners
#  Key
alias ar:key:generate='php artisan key:generate' # Set the application key
#  Make
alias ar:ma:channel='php artisan make:channel'           # Create a new channel class
alias ar:ma:class='php artisan make:class'               # Create a new PHP class
alias ar:ma:command='php artisan make:command'           # Create a new Artisan command
alias ar:ma:component='php artisan make:component'       # Create a new view component class
alias ar:ma:controller='php artisan make:controller'     # Create a new controller class
alias ar:ma:enum='php artisan make:enum'                 # Create a new model enum
alias ar:ma:event='php artisan make:event'               # Create a new event class
alias ar:ma:exception='php artisan make:exception'       # Create a new custom exception class
alias ar:ma:factory='php artisan make:factory'           # Create a new model factory
alias ar:ma:interface='php artisan make:interface'       # Create a new PHP interface
alias ar:ma:job='php artisan make:job'                   # Create a new job class
alias ar:ma:listener='php artisan make:listener'         # Create a new event listener class
alias ar:ma:mail='php artisan make:mail'                 # Create a new email class
alias ar:ma:middleware='php artisan make:middleware'     # Create a new middleware class
alias ar:ma:migration='php artisan make:migration'       # Create a new migration file
alias ar:ma:model='php artisan make:model'               # Create a new Eloquent model class
alias ar:ma:notification='php artisan make:notification' # Create a new notification class
alias ar:ma:observer='php artisan make:observer'         # Create a new observer class
alias ar:ma:policy='php artisan make:policy'             # Create a new policy class
alias ar:ma:provider='php artisan make:provider'         # Create a new service provider class
alias ar:ma:request='php artisan make:request'           # Create a new form request class
alias ar:ma:resource='php artisan make:resource'         # Create a new resource
alias ar:ma:rule='php artisan make:rule'                 # Create a new validation rule
alias ar:ma:seeder='php artisan make:seeder'             # Create a new seeder class
alias ar:ma:test='php artisan make:test'                 # Create a new test class
alias ar:ma:trait='php artisan make:trait'               # Create a new PHP trait
#  Migrate
alias ar:mi:fresh='php artisan migrate:fresh'       # Drop all tables and re-run all migrations
alias ar:mi:install='php artisan migrate:install'   # Create the migration repository
alias ar:mi:refresh='php artisan migrate:refresh'   # Reset and re-run all migrations
alias ar:mi:reset='php artisan migrate:reset'       # Rollback all database migrations
alias ar:mi:rollback='php artisan migrate:rollback' # Rollback the last database migration
alias ar:mi:status='php artisan migrate:status'     # Show the status of each migration
#  Notifications
alias ar:no:table='php artisan notifications:table' # Create a migration for the notifications table
#  Optimize
alias ar:op:clear='php artisan optimize:clear' # Remove the cached bootstrap files
#  Package
alias ar:pa:discover='php artisan package:discover' # Rebuild the cached package manifest
#  Queue
alias ar:qu:failed='php artisan queue:failed'         # List all of the failed queue jobs
alias ar:qu:failed-t='php artisan queue:failed-table' # Create a migration for the failed queue jobs database table
alias ar:qu:flush='php artisan queue:flush'           # Flush all of the failed queue jobs
alias ar:qu:forget='php artisan queue:forget'         # Delete a failed queue job
alias ar:qu:listen='php artisan queue:listen'         # Listen to a given queue
alias ar:qu:restart='php artisan queue:restart'       # Restart queue worker daemons after their current job
alias ar:qu:retry='php artisan queue:retry'           # Retry a failed queue job
alias ar:qu:table='php artisan queue:table'           # Create a migration for the queue jobs database table
alias ar:qu:work='php artisan queue:work'             # Start processing jobs on the queue as a daemon
#  Route
alias ar:ro:cache='php artisan route:cache' # Create a route cache file for faster route registration
alias ar:ro:clear='php artisan route:clear' # Remove the route cache file
alias ar:ro:list='php artisan route:list'   # List all registered routes
#  Schedule
alias ar:sc:run='php artisan schedule:run' # Run the scheduled commands
#  Session
alias ar:se:table='php artisan session:table' # Create a migration for the session database table
#  Storage
alias ar:st:link='php artisan storage:link' # Create the symbolic links configured for the application
#  Stub
alias ar:stub:publish='php artisan stub:publish' # Publish all stubs that are available for customization
#  Vendor
alias ar:ve:publish='php artisan vendor:publish' # Publish any publishable assets from vendor arckages
# view
alias ar:vi:cache='php artisan view:cache' # Compile all of the application's Blade templates
alias ar:vi:clear='php artisan view:clear' # Clear all compiled view files
# thinker
alias ar:thinker='php artisan thinker'
