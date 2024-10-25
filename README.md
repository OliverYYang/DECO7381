# Lingoland2

## Project Overview

Lingoland2 is an educational English learning application designed for children and their parents. This app leverages advanced computer vision technology to enable real-time text scanning, recognition, and translation. It also offers dictionary and error-checking functionalities, supports user-defined learning plans, and integrates gamification elements to enhance user engagement and motivation in learning English.

### Key Features

1. **Real-time OCR Scanner**: Capture text in real-time using the device's camera and translate it automatically.
2. **Vocabulary Library**: Users can explore and learn new words through interactive gameplay.
3. **Daily Tasks & Games**: Points or progress are awarded based on the user's interaction with words.
4. **Parental Controls**: 
5. **Safety Reminders**: 

---

## Table of Contents

- [Project Overview](#project-overview)
- [Project Structure](#project-structure)
- [File Descriptions](#file-descriptions)
- [Features](#features)
  - [1. Scanner - OCR (Real-time scanning and translation)](#1-scanner---ocr-real-time-scanning-and-translation)
  - [2. Vocabulary Library - API/Built-in Lexicon](#2-vocabulary-library---apibuilt-in-lexicon)
  - [3. Daily Tasks & Games](#3-daily-tasks--games)
  - [4. Parental Controls & Safety Instructions](#4-parental-controls--safety-instructions)
- [Technology Stack](#technology-stack)
- [Setup Instructions](#setup-instructions)
- [Project Structure](#project-structure)
- [Reference](#Reference)

---

## Project Structure

Lingoland2/
│
├── MonsterDex/
│   └── MonsterDexView.swift               
│
├── Words/
│   ├── WordViewModel.swift                
│   ├── WordViewService.swift              
│   ├── WordView.swift                     
│   └── DatabaseConnection.swift           
│
├── Game/                                  
│   ├── GameDataManagement.swift           
│   ├── GameFunction.swift                 
│   ├── GameView.swift                     
│   ├── GameView1.swift                    
│   └── GameView3.swift                    
│
├── Translation/
│   ├── TranslationService_2.swift         
│   └── VocabularyView.swift               
│
├── Scanner/                               
│   ├── Scanner.swift                      
│   ├── CameraViewController.swift         
│   ├── ScannerView.swift                  
│   └── ScannerContentView.swift           
│
├── Lingoland2/
│   ├── Review.swift                       
│   ├── SettingView.swift                  
│   ├── Lingoland2App.swift                
│   ├── UserView.swift                     
│   └── ContentView.swift                  
│
├── Assets/                                
│   └── Preview Content/
│
├── Lingoland2Tests/                       
│   └── Lingoland2Tests.swift
│
├── Lingoland2UITests/                     
│   ├── Lingoland2UITests.swift
│   └── Lingoland2LaunchTests.swift        
│
├── Frameworks/                            
└── README.md                             


---

## File Descriptions

### Scanner Section

#### 1. `Scanner.swift`
This file implements the core logic for Optical Character Recognition (OCR) using Apple's Vision framework...

#### 2. `CameraViewController.swift`
This file manages the camera feed and captures real-time video frames...

#### 3. `ScannerView.swift`
This file serves as a bridge between UIKit and SwiftUI using the `UIViewControllerRepresentable` protocol...

#### 4. `ScannerContentView.swift`
This file defines the main user interface for the scanner, displaying buttons for toggling between scan modes and showing OCR results...

### Daily Tasks Section

#### 1. `WordView.swift`
This file likely represents a detailed view for individual words. Users can interact with a single word, learning its definition, translation, and perhaps engaging in exercises or challenges related to that word.

#### 2. `WordViewModel.swift`
This file manages the logic for the WordView. It likely connects the UI elements to the underlying data, ensuring that word details, translations, and interactions are properly handled.

#### 3. `WordViewService.swift`
This file provides backend services for the WordView. It may include functions for fetching word-related data, interacting with the translation service, and managing user input or feedback.

### Game Section

#### 1. `GameView.swift`
This file is responsible for rendering the main game interface. It likely uses SwiftUI to display game elements such as words, monsters, and interactive buttons that allow users to explore different aspects of the game.


#### 2. `GameFunction.swift`
This file contains essential game mechanics and functions. It likely includes logic for managing the player's interactions, rewards, and the progression of vocabulary acquisition.

#### 3. `GameDataManagement.swift`
This file manages the core game data, including vocabulary sets, user progress, and interactions with the monster-based learning system. It handles loading, saving, and updating game data as the user progresses through the app.

### Translation Section

#### 1. `VocabularyView.swift`
This view manages the display of vocabulary lists and allows users to interact with specific words. It may present definitions, translations, and other related content to help users learn new vocabulary.

#### 1. `TranslationService_2.swift`
This file handles the integration with a translation API. It sends requests to the translation service and retrieves translated words, which are then displayed within the game.

---

## Features

### 1. Scanner - OCR (Real-time scanning and translation)

- **Description**: The real-time OCR scanner allows users to capture text using their camera. The app uses Apple's Vision framework to recognize the text and utilizes the Google Translate API to translate it into other languages (e.g., from English to Chinese).
- **Implementation Details**:
  - The scanner supports two modes:
    - **Full-text Scan Mode**: Recognizes and translates all text visible to the camera.
    - **Word Selection Mode**: Focuses on a selected rectangular area for scanning and translation. However, due to technical limitations, this feature is not yet fully implemented and will be developed further in the future. The words scanned in this mode will be added to the database.
  
### 2. Vocabulary Library - API/Built-in Lexicon

- **Description**: Users can explore and learn new words through interactive gameplay. The app contains a built-in vocabulary library, allowing users to access a wide range of words for learning and engagement. The app is designed to integrate API services to provide real-time translations and dictionary definitions.

- **Implementation Details**: 
  - **Translation API**: The app uses the GS Translation API to provide real-time translation and language support, ensuring that users can view word meanings and translations instantly.
  - **Built-in Lexicon**: The app includes a pre-loaded lexicon for using, allowing users to explore a predefined set of words.
  - **Lexicon Expansion**: As users progress, they can unlock new words and monsters, expanding their vocabulary over time. The app periodically syncs with the translation API to refresh and update its word database.

### 3. Daily Tasks & Games

- **Description**: Daily tasks and mini-games are integrated to encourage consistent learning. Users are given daily vocabulary challenges and interactive games to reinforce word learning and keep engagement high.
- **Implementation Details**: 
  - **Daily Word Challenges**: The app provides daily tasks where users must learn a certain number of new words or complete vocabulary-related exercises. These tasks are tracked and provide rewards upon completion.
  - **Mini-Games**:  The app includes vocabulary-based games, such as matching words to their definitions or translating words in real-time to defeat in-game monsters. These games are designed to be fun, educational, and adaptive to the user’s learning pace.

### 4. Parental Controls & Safety Instructions

- **Description**: Parental Controls can help parents to supervise childrens' game behaviors which can adviod them to addict about the games, This is our future target for Lingoland 
- **Safety Reminder**: Safety Reminder can reminder children's not use this application when they stay some unsecured environment, which is the future goal for Lingoland

---

## Technology Stack

- **Languages**: Swift, SwiftUI, UIKit, SQL
- **Libraries**:
  - **OCR**: Apple's Vision Framework
  - **Translation**: Google Translate API
  - **Database**: Mysql
- **Tools**: Xcode, Swift Package Manager (SPM), iPhone 13

---

## Setup Instructions

### Prerequisites

- Xcode 12 or later
- The app uses SwiftUI for the interface, which requires iOS 14 or later.
- MySQL server (local or remote)
- API keys for Google Translate and Grammarly

### Steps

**Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/Lingoland2.git

## Steps to Set Up the Database
Final version database ,Please run inside (),outside () are comments

Linux command

Connect our database
(gcloud sql connect deco7381database --user=deco7381northwind)

Enter the password of user
(123456)


SQL statement

Create our database

(CREATE DATABASE deco7381northwind;)

Enter in our database deco7381northwind

(USE deco7381northwind;)

Create table user
(
create table user(
user_id int primary key,
is_parent bool,
username varchar(50),
password varchar(20),
phone_number varchar(20),
address varchar(100),
emergency_contact varchar(20)
);
)

Create table review
(
create table review(
text varchar(200) primary key,
user_id int default 1,
translation varchar(200),
foreign key (user_id) references user(user_id)
);
)

Create table monster
(
create table monster(
monster_id int primary key,
user_id int,
monster_name varchar(50),
level int,
hp int,
foreign key (user_id) references user(user_id)
);
)

Create table dailytask
(
create table dailytask(
text varchar(200) primary key,
user_id int default 1,
translation varchar(200),
foreign key (user_id) references user(user_id)
);
)

Insert some value to test
(
INSERT INTO user(user_id,username) VALUES('1','xiaozhang');

INSERT INTO review(text,translation) VALUES('computer','电脑');

INSERT INTO review(text,translation) VALUES('book','书');

INSERT INTO review(text,translation) VALUES('box','箱子');

INSERT INTO review(text,translation) VALUES('bottle','瓶子');
)


---

## Reference

[1]    H. Burgiss, “Answer to ‘Xcode couldn’t find any provisioning profiles matching,’” Stack Overflow. Accessed: Oct. 16, 2024. [Online]. Available: https://stackoverflow.com/a/51430289
[2]    m3rk, “Answer to ‘Xcode couldn’t find any provisioning profiles matching,’” Stack Overflow. Accessed: Oct. 16, 2024. [Online]. Available: https://stackoverflow.com/a/51408373
[3]    Amazing Learning, How to Add iOS App Camera Access Permission in XCode | Camera Usage Description | [Approved], (Sep. 28, 2021). Accessed: Oct. 16, 2024. [Online Video]. Available: https://www.youtube.com/watch?v=GAHWt2HPEIM
[4]    “iOS app crashes on camera permission request (which I want to block) · Issue #1510 · pichillilorenzo/flutter_inappwebview,” GitHub. Accessed: Oct. 16, 2024. [Online]. Available: https://github.com/pichillilorenzo/flutter_inappwebview/issues/1510
[5]    “Vision,” Apple Developer Documentation. Accessed: Oct. 16, 2024. [Online]. Available: https://developer.apple.com/documentation/vision
[6]    H. Burgiss, “Xcode couldn’t find any provisioning profiles matching,” Stack Overflow. Accessed: Oct. 16, 2024. [Online]. Available: https://stackoverflow.com/q/51387873
[7]    DictionaryAPI.dev. Free Dictionary API. RapidAPI, api.dictionaryapi.dev/api/v2/entries. Accessed 18 Oct. 2024. [Online] Available: https://api.dictionaryapi.dev/api/v2/entries
[8]    Google Cloud. Cloud Translation API. Google, translation.googleapis.com/language/translate/v2. Accessed 18 Oct. 2024. [Online] Available: https://translation.googleapis.com/language/translate/v2


