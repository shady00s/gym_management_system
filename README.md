# Gym management system


# Introduction

CRM system aims to manage players subscriptions and logging for small scale Gym.


# Application main idea

The system's idea is transforming an Excel table to a system with restrictions that is compatible with what the client needs.
Each excel table (team) contained 8 columns (ID, name. duration (From-To, bill Id, bill date, bill value).
The old system's idea was that each table would contain all year transactions and players re-subscriptions.

# Old system limitations and flaws
Unfortunately there is no data for phone numbers or previous logs for players recorded in the file and the ID system was to ignore any player that is subscribed for one session only by giving them  (*) as ID and some players are repeated with different IDs with a missing beginning date for some of the  players and some transactions are corrupted due to wrong/unwanted data ( ex: writing some texts in multiple columns instead of writing them in one cell, writing a text instead of the beginning date or end date, ..etc.).


# Application Architecture 
So, the first step was creating a NodeJS server to handle the data from excel file to import it to the system and save the data as backup data in a PostgreSQL database and the server was returning Array of players with all the players' valid transactions/subscriptions from many teams if they are  subscribed to multiple teams.

## Files Architecture  
 ###   App (Flutter)                         `        `                      Server ( NodeJS) 
  ![app](https://github.com/shady00s/gym_management_system/assets/64488184/54c6d6b4-e541-44d9-aa2a-52532b1f34dc)  ![server](https://github.com/shady00s/gym_management_system/assets/64488184/85b3d1d1-045e-4435-8a99-f8711cca0f55)
  
  

## Database ERD
 
![gymDatabase](https://github.com/shady00s/gym_management_system/assets/64488184/acb1760c-fdde-41a6-814e-9e3ccf0f749f)



  
After that I created an SQL Offline database in `Flutter` with `Drift` library which is a great library for creating an SQL Databases in flutter and the UI with `Fluent UI` package that gives windows widgets shape with `Riverpod` as state management.
As for the client's requests, here are the features that are in the system:


# Requiremenets

 ## -	Create players with needed data.

  - As recording the phone numbers, gender, and a profile image for player 
  
  -	Create Subscriptions for every team which can also be used for multiple teams (Like sessions and invitations).


## -	Control invitations and freeze players.

  - By tracking how many invitations a player consumes and deactivating player's subscription when the player activates it
  - Prevent human errors if the receptionist accidentally chooses an old date or a date that exceeds player subscription end date.
  -	Create profile for every invitation or one session to prevent repeating data

  
## -	Logging system

  -	The logging system provides multiple ways to enter the Gym. 
      -	By ID card (QR code)
      -	By searching with phone number
      -	Searching by ID
      -	Searching by Name
      
  -	The system provides the receptionist with status of player after logging.
      -	If the player's subscription ended before two days, then give alert and enter the gym or subscribe. 
      -	If player subscription is ended after two days, then give alert to re-subscribe with no entrance until re-subscription.
      -	Prevent players from logging to the gym if subscription is frozen.

      
## -	Gym status screen

  -	Screen that is responsible for telling the owner about the current situation of the gym by calculating each and every subscription value on every date for the year and show who is the best performance team which has the biggest income and show the number of players.

  
## -	Player status screen

  -	Screen that is responsible for monitoring the number of:
      -	new players 
      -	active players (players who have valid subscriptions).
      -	ended subscription players.
  With the ability to filter by (subscription value, duration, player gender and team).

  
## -	Import Excel 

  -	Provide the ability to import data from excel.

  
## -	Creating subscriptions

## -	Creating teams.

## -	Players log history 

  -	Get all the players that logged to the gym at specific date.

## Screenshots 
![Screenshot 2023-09-28 020607](https://github.com/shady00s/gym_management_system/assets/64488184/0404af12-b9a5-4d20-91ba-92031997cfb7)
![Screenshot 2023-09-28 020843](https://github.com/shady00s/gym_management_system/assets/64488184/7dd54c53-5973-4fea-aa45-5a2f62d8b7fe)
![Screenshot 2023-09-28 020822](https://github.com/shady00s/gym_management_system/assets/64488184/8b49e16c-3806-46ed-9bc8-0a48523517cf)
![Screenshot 2023-09-28 020743](https://github.com/shady00s/gym_management_system/assets/64488184/bd0872a1-c789-4d33-8488-4db8eac899d8)
![Screenshot 2023-09-28 020659](https://github.com/shady00s/gym_management_system/assets/64488184/1b577f93-8d5d-42e5-83c7-0491d2d656e7)
