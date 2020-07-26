// Title: Escape Game Template
// Author: Anthony Jauneaud — @iamleyeti
// Date: 2020 07 26
// PLEASE COMMENT YOUR TEXT. For yourself and for others.

// First, let's declare some variables. Remember to have clear names. You can use values — here for the timer —, strings of text — here for the difficulty —, or booleans (TRUE / FALSE statements) — here for the key.

VAR time = 30
    // In escape game, time is not always a bad thing or going down. We could have several resources. Be creative here.
VAR difficulty = "normal"
    // Usually, I would not recommend using strings for variables like these, but for our template, it's clearer.
VAR inventory_Key = false
    // I recommend have booleans as much as possible because they are cleaner and it's really hard to mess them up.

-> intro

= intro
    // We declared variables but because we want to have a loop here, we need to make sure every game starts with the same values.  
    ~difficulty = "normal"
    ~time = 30
    ~inventory_Key = false
This is a template for an escape game.

-(difficulty_selection)
You are currently playing on the {difficulty} difficulty, which means a {time} seconds timer.
+ [Start] // Choices starting with +  will always be there. They are useful to create a hub or a recurring actions.
    -> start
+ [Easy]
    ~difficulty = "easy"
    ~time = 60
    -> difficulty_selection
+ [Normal]
    ~difficulty = "normal"
    ~time = 30
    -> difficulty_selection
+ [Hard]
    ~difficulty = "hard"
    ~time = 15
    -> difficulty_selection


= start
The glacial touch of water wakes you up.
You open your eyes. You are in a room with only one opening to your right: a locked door. Water is rising. It looks like you have <>
{ difficulty == "easy": roughly a minute to escape.}
{ difficulty == "normal": half a minute to escape.}
{ difficulty == "hard": only a few seconds to escape. Soon, you'll be dead.}
    // Have one line per possible variable content is great when you use booleans. For values, we will see one example below.
    -> action_hub

= action_hub
    // We're making a LETHAL escape game so we need to have a check on our main resource: time.
{ time < 1: -> game_over }
You look around you.
    + [Do nothing.]
        ~time -= 10
        -> time_logic -> // This divert will make sure players die if they are out of time.
        {&You wait|You scream|You remember that time you said "To you as well" to a barista asking for your name|You wait|You sob|You sing a song}.
        -> action_hub
    * [Test an action.]
        -> action_01
    * [Test another action.]
        -> action_02
    * [Test a third action.]
        -> action_03
    * {inventory_Key == true} [Open the key to escape.] // Putting a variable test before a choice will make it visible ONLY if the test is positive. So our escape way is here.
        -> escape

= timer
    // If you do need to test variables with numbers, it's better to have them as such. Each step is tested before moving to the next. Perfect to have a bunch of stages here.
    {
        - time > 45:
            You still have enough time to escape… maybe {time} seconds? // See how we can reuse variables? Neat and free.
            -> action_hub
        -time > 25:
            {~Time is ticking out.|You'll be soon out of oxygen.|Water is high. You'll be dead soon.} // I love shuffle statements.
            -> action_hub
        -else: // Make sure you always have an ELSE, it saves a lot of logic, even if you don't need to (here, I need one).
            Water's up now. You… can… hardly… breathe…
            -> action_hub
    }

= action_01
    ~time -= 10
    -> time_logic -> // See this use of a -> DIVERT -> ? It allows us to check a passage and come back here. Make sure the passage in question ends with ->-> which basically means "go back to where you were before".
You try something. It doesn't work.
    -> timer

= action_02
    ~time -= 10
    -> time_logic ->
You try something and find a key.
    ~inventory_Key = true // Have very clear variables is necessary so I always know that true here is a good thing. Do not have variables called KEY and where TRUE or FALSE can mean different thing.
    -> timer

= action_03
    ~time -= 10
    -> time_logic ->
You try something else and it is not a success.
    -> timer

= time_logic
    { time < 1: -> game_over } // I like using variables and diverts together. So here, we want to make sure that when TIME is below 1 (and not equal to ZERO), the player dies.
    ->->

= game_over
Your lungs are empty. You head is suddenly light. Your last thought is vaguely happy. You die.
Game over.
    -> ending

= escape
You successfuly open the door and escape. Well played!
    -> ending

= ending
    + [Start over.]
        -> intro
-> END