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

There are four variables inside the ``G.GAME`` object:
```lua
-- Total number of rerolls
G.GAME.booster_rerolls_total

-- Remaining rerolls. Resets back to the total number of rerolls at the start of each Ante
G.GAME.booster_rerolls

-- Total number of redraws
G.GAME.booster_redraws_total

-- Remaining redraws. Resets back to the total number of redraws at the start of each Ante
G.GAME.booster_redraws
```

Other mods can call the following functions:  

```lua
-- args can either be a single number or an object: args = {rerolls = 1, redraws = 1}
-- Increases the number of total rerolls/redraws by the specified amount. Can be negative.
-- If the total would be < 0 it's set to 0.
-- If remaining rerolls/redraws are above their total, they get set to the number of total rerolls/redraws
-- If amount is positive, remaining rerolls/redraws are increased by the same amount
add_booster_rerolls(args)

-- args can either be ommited or be an object: args = {rerolls = true, redraws = true}
-- Resets the number of remaining rerolls/redraws to their total. This is executed at the start of each Ante automatically
reset_booster_rerolls(args)
```

The tooltips can be included in the ``loc_vars`` function of another GameObject like this:

```lua
info_queue[#info_queue+1] = {key = "tt_booster_reroll", set = "Other"}
info_queue[#info_queue+1] = {key = "tt_booster_redraw", set = "Other"}
```

Boosters allow rerolling/redrawing by default, but modded Boosters can set the properties ``disable_reroll`` or ``disable_redraw`` respectively, to disable the functionality.

### Example:
```lua
-- Increases total rerolls and redraws by 3.
add_booster_rerolls(3)
add_booster_rerolls({rerolls = 3, redraws = 3})

-- Increases only total rerolls by 2
add_booster_rerolls({rerolls = 2})

-- Reduces only total redraws by 1
add_booster_rerolls({redraws = -1})

-- Resets remaining rerolls and redraws to their respective total
reset_booster_rerolls()
reset_booster_rerolls({rerolls = true, redraws = true})

-- Resets only remaining rerolls
reset_booster_rerolls({rerolls = true})

-- Resets only remaining redraws
reset_booster_rerolls({redraws = true})
```

---

## ⚠️ Notes  

- The buttons only show up if ``G.GAME.booster_rerolls_total > 0`` or ``G.GAME.booster_redraws_total > 0``
- Requires the latest version of **smods**.  
- Compatibility with other mods that modify boosters is **not guaranteed**.  
- Please report bugs or suggestions via the [Issue Tracker](./issues).  

---
