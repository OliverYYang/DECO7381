Overview:
This project is an educational app that combines language learning with gamified elements to engage users, particularly children, in acquiring new vocabulary. The app leverages various game views and data models to provide an interactive experience where users can explore different words, interact with monsters (presumably representing language elements), and track their vocabulary learning progress.

Table of Contents:
Overview
Setup Instructions
Features
File Descriptions
Credits
License
Setup Instructions


1.Requirements:

Swift 5.x or higher
Xcode 12.x or higher
Internet connection for using the translation API


2.Installation:

Clone the repository:
https://github.com/OliverYYang/DECO7381.git

Open the Xcode project and build the app.
Ensure that all dependencies, including the translation API and any other external services.


3.Running the App:
Once built, run the app on a simulator or a physical iOS device.


Features:
Vocabulary Learning: Users can explore and learn new words through interactive gameplay.
MonsterDex: A visual dictionary where users can track learned words, represented as monsters.
Translation Service: Real-time translation functionality using a translation API.
Gamification: Points or progress are awarded based on the user's interaction with words.
User-Friendly Interface: Built with SwiftUI, the app provides an intuitive interface for young users.


File Descriptions
1. GameDataManagement.swift
This file manages the core game data, including vocabulary sets, user progress, and interactions with the monster-based learning system. It handles loading, saving, and updating game data as the user progresses through the app.

2. GameFunction.swift
This file contains essential game mechanics and functions. It likely includes logic for managing the player's interactions, rewards, and the progression of vocabulary acquisition.

3. GameView.swift
This file is responsible for rendering the main game interface. It likely uses SwiftUI to display game elements such as words, monsters, and interactive buttons that allow users to explore different aspects of the game.

4. MonsterDexView.swift
This view functions as a "dictionary" of sorts, displaying the monsters that correspond to different vocabulary words. As users learn new words, they unlock new monsters that are added to this view.

5. TranslationService_2.swift
This file handles the integration with a translation API. It sends requests to the translation service and retrieves translated words, which are then displayed within the game.

6. VocabularyView.swift
This view manages the display of vocabulary lists and allows users to interact with specific words. It may present definitions, translations, and other related content to help users learn new vocabulary.

7. WordView.swift
This file likely represents a detailed view for individual words. Users can interact with a single word, learning its definition, translation, and perhaps engaging in exercises or challenges related to that word.

8. WordViewModel.swift
This file manages the logic for the WordView. It likely connects the UI elements to the underlying data, ensuring that word details, translations, and interactions are properly handled.

9. WordViewService.swift
This file provides backend services for the WordView. It may include functions for fetching word-related data, interacting with the translation service, and managing user input or feedback.


Credits:
Developer:Zixin Song
Contributors:
Special Thanks: Github, GS Translation API, Freedict API, Google Cloud Platform for database.