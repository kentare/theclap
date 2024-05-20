// 1-base
# Part 1. Initial set up
1. Look at project structure
2. Look at code added in app.js
3. `mix ecto.create`, `mix ecto.migrate`
4. Change route to live "/", App
5. Show that app fails


// 2-process
# Part 2. Events and processes
1. PP about processes
2. Add mount, 2-mount
3. Add event handling, 2-event
4. Show where in render the event is sent


// 3-pubsub
// Now we will add pubsub and animation based on the pubsub events
1. Add @room "clap"
2. Replace mount, 3-mount // Added subscribe
3. Replace handle_event, 3-event // Adde broadcast
4. Add handle_info, 3-info  // Handle pubsub events
5. Show app.js


// 4-ecto 
// Show data persistency
0.1 Uncomment code in app_live.ex
1. show PP
2. generate model: mix phx.gen.live Applause Clap claps value:string user_id:string
3. Show the generated files
4. Add repo functions to Applause.ex, 4-applause
5. Add handle_parmas, 4-params
6. replace handle_event, 4-event
7. Havoc






// Extra om tid
1. Throttling
2. To disable logging add  level: :info in config.exs
3. Show latency in frontend
4. Show the new routes