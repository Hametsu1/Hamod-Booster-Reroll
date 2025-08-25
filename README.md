<img width="836" height="170" alt="Booster_Reroll" src="https://github.com/user-attachments/assets/10061f7f-700a-4608-8a0f-d25ca6233da2" />

A **Steamodded (smods)** mod for **Balatro** that adds two new buttons to Boosters:  

- **Reroll** – Rerolls the contents of the Booster  
- **Redraw** – Redraw hand (only enabled when the Booster draws cards from the deck)

It also exposes a simple API so other mods can integrate reroll functionality.  

---

## 📥 Installation  

1. Make sure you have **[Steamodded (smods)](https://github.com/Steamodded/smods)** installed.  
2. Download the latest release from the [Releases](./releases) page.  
3. Extract the files into your Balatro `mods` folder:  
   ```text
   %appdata%/Balatro/mods/
   ```
4. Launch the game and make sure the mod is enabled in the mod menu.  

---

## 🧩 API for Mod Developers

There are two variables inside the ``G.GAME`` object:
```lua
-- Total number of rerolls
G.GAME.booster_rerolls_total

-- Remaining rerolls. Resets back to the total number of rerolls at the start of each Ante
G.GAME.booster_rerolls
```

Other mods can call the following functions:  

```lua
-- Increases the number of total rerolls by the specified amount. Can be negative.
-- If the total would be < 0 it's set to 0.
-- If remaining rerolls are above total rerolls, they get set to the number of total rerolls
-- If amount is positive, remaining rerolls are increased by the same amount
add_booster_rerolls(amount)

-- Resets the number of remaining rerolls to the number of total rerolls
reset_booster_rerolls()
```

The tooltip can be included in the ``loc_vars`` function of another GameObject like this:

```lua
info_queue[#info_queue+1] = {key = "tt_booster_reroll", set = "Other"}
```

Boosters allow rerolling by default, but modded Boosters can set the property ``disable_reroll`` to disable the functionality.

### Example:
```lua
-- Increases total rerolls by 3.
add_booster_rerolls(3)

-- Reduces total rerolls by 1.
add_booster_rerolls(-1)
```

---

## ⚠️ Notes  

- The buttons only show up if ``G.GAME.booster_rerolls_total > 0``
- Requires the latest version of **smods**.  
- Compatibility with other mods that modify boosters is **not guaranteed**.  
- Please report bugs or suggestions via the [Issue Tracker](./issues).  

---
