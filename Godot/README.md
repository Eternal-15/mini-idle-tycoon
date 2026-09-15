**Mini Idle Tycoon Game**  
A small idle/clicker tycoon prototype built with the Godot Game Engine. Click to earn gold, spend it on upgrades, and watch passive income stack up while you're away.  
**Features**  
- **Click to earn gold** — each click gives you gold based on your gold-per-click upgrade level  
- **Passive income** — gold and food accrue every second automatically  
- **Upgrades**  
  - Upgrade Coin: increases gold per click (+2) and gold income per second (+5)  
  - Upgrade Food: increases food income per second (+5)  
- **Auto-save** — progress is saved to disk after every income tick and action  
- **Readable numbers** — large values are auto-shortened (e.g. 1.5K, 2.3M, 4.1B)  
**How to Run**  
1. Open the project in the Godot editor by importing project.godot  
2. Press the **Run Project** (Play) button  
**Controls**  
| | |  
|-|-|  
| **Button** | **Effect** |   
| Gold | Earn gold per click |   
| Upgrade Coin | Boost gold per click and gold/s |   
| Upgrade Food | Boost food income/s |   
   
**Project Structure**  
Assest/                  Game texture assets (sprites, backgrounds)  
 Scene/  
   main_ui.tscn           Main scene (entry point)  
   ui.tscn                Top/bottom bar UI, buttons, notification panel  
   game_manager.tscn      GameManager node scene  
 Script/  
   game_manager.gd        Core game state, upgrades, income tick, number formatting  
   save_manager.gd        JSON save/load (user://savegame.save)  
   ui.gd                  UI updates, timer hookup, button handlers  
 globalTheme.tres         Default project theme  
 project.godot            Project configuration  
   
**Architecture**  
The game is driven by two autoloads:  
- **GameManager** — holds all game state (gold_count, food_count, gold_per_tab, gold_income, food_income) and exposes actions like click_gold(), upgrade_gold(), and upgrade_food(). It emits data_changed when state changes and show_notification for transient on-screen messages.  
- **SaveManager** — serializes the GameManager state to a JSON file at user://savegame.save and restores it on startup.  
A Timer node ticks every second and calls GameManager.on_timer_tick() to apply passive income. The UI (ui.gd) listens for data_changed and refreshes the labels in response.  

**Save Data**  
Progress is stored as JSON with the following fields:  
- gold_count  
- food_count  
- gold_per_tab  
- gold_income  
- food_income  
Saves that are missing or corrupted fall back to a fresh game.  
  
## Author

**Sambad Shakya** — [GitHub](https://github.com/Eternal-15)
   
