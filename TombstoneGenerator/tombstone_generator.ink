// Title: Tombstone Generator
// Author: Anthony Jauneaud @iamleyeti
// Date: 2020 07 26
// PLEASE COMMENT YOUR TEXT. For yourself and for others.


// Let's start by declaring your variables. Make sure they are readable and understandable.

VAR birth_Date = 0
VAR death_Date = 0
VAR age_Death = 0

-> intro

= intro
    // This intro is our entry point, it will be seen only once.
A cemetery somewhere in the west. You walk between the tombs. The tombstone in front of your reads:

    // Here, we pick all our variables and do our logic so it's not bothering later.
~birth_Date = RANDOM(1830, 1870)
~age_Death = RANDOM(5, 55)
~death_Date = ( birth_Date + age_Death )

-> tombstone

= tombstone
    // I personally use = as chapters and -() as parts in a chapter. But you can do whatever you want.

-(incipit)
    // Use {~} to shuffle randomly in your alternatives.
    // Use <> to glue this text to the next.
{~Here lies|Rest in peace|RIP|To my dear|To the dearest|To our dearest|To my dearest|Pay your respects to|To|To my|To our|To the lovely} <>

-(name)
    // For simplicity sake, I've selected only male names.
{~Mark|Steven|Philip|Philippe|Michael|Arthur|Morgan|John|Jack|Jonathan|Howard|Howie|Luke|Seymour|Charles|Charlie|Sam|Samuel|Robin} <>

{~Green|Collins|Bailey|Wright|Price|Adams|Sanchez|Scott|Walker|Hannon|McLeod|McGovern|McDonald|Donalds|Louis|Galveston|Rivers|Lee|Wayne|Hawkes|Hawks|Collington|Brailey|Belloq|}

    // Here, we will go for three different ways to write the date. You can't have variables in alternatives {~} (and it will be clearler anyway).
{~ -> date_01 | -> date_02 | -> date_03}

-(date_01)
{~Born in|Born} {birth_Date}. {~Died in|Died} {death_Date}.
-> comment

-(date_02)
    // You can have empty sentences in your {~} shuffle alternatives.
{~circa|||} {birth_Date} - {death_Date}
-> comment

-(date_03)
Died at {age_Death}.
-> comment

-(comment)
    // You can do alternatives in alternatives but it makes everything a bit less clear.
{~Served his country well|"Whosoever believeth in Him should not perish, but have eternal life." - John 3-15|"Thy remembrance shall endure into all generations." - Psalm 102|"They can no longer die; for they are like the angels." - Luke 20-36|"The Lord is my shepherd; I shall not want." - Psalm 23|You'll be {~not|truly||} missed|Beloved by friends and enemies|Beloved by his family|Reunited with {~God|Satan|his loved ones|his family|his father|his mother|his dog|his cat}}.

+ [Read another tombstone…]
    -> tombstone
+ [Leave the cemetery…]
You spit on the ground and leave the premises. You will find him… somewhere else.
    -> END