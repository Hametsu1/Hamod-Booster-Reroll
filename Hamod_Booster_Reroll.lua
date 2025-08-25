HBR = {}
HBR.create_UIBox = function(self)
    if not G.GAME.booster_rerolls_total or G.GAME.booster_rerolls_total == 0 then return false end

    local reroll_display_color = G.C.WHITE
    if G.GAME.booster_rerolls_total == 0 then
        reroll_display_color = G.C.RED
    end
    
    local _size = math.max(1, SMODS.OPENED_BOOSTER.ability.extra + (G.GAME.modifiers.booster_size_mod or 0))
    G.pack_cards = CardArea(
        G.ROOM.T.x + 9 + G.hand.T.x, G.hand.T.y,
        math.max(1,math.min(_size,5))*G.CARD_W*1.1,
        1.05*G.CARD_H,
        {card_limit = _size, type = 'consumeable', highlight_limit = 1, negative_info = true})

    local t = {n=G.UIT.ROOT, config = {align = 'tm', r = 0.15, colour = G.C.CLEAR, padding = 0.15}, nodes={
        {n=G.UIT.R, config={align = "cl", colour = G.C.CLEAR,r=0.15, padding = 0.1, minh = 2, shadow = true}, nodes={
            {n=G.UIT.R, config={align = "cm"}, nodes={
            {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
                {n=G.UIT.C, config={align = "cm", r=0.2, colour = G.C.CLEAR, shadow = true}, nodes={
                    {n=G.UIT.O, config={object = G.pack_cards}},}}}}}},
        {n=G.UIT.R, config={align = "cm"}, nodes={}},
        {n=G.UIT.R, config={align = "tm"}, nodes={
            {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={}},
            {n=G.UIT.C,config={align = "tm", padding = 0.05}, nodes={
                UIBox_dyn_container({
                    {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 4}, nodes={
                        {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                            {n=G.UIT.O, config={object = DynaText({string = localize(self.group_key or ('k_booster_group_'..self.key)), colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.7, maxw = 4, pop_in = 0.5})}}}},
                        {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                            {n=G.UIT.O, config={object = DynaText({string = {localize('k_choose')..' '}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}},
                            {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'pack_choices'}}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}}}},}}
                }),}},
            {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 4.8}, nodes={ -- breitere Spalte
    {n=G.UIT.R,config={minh =0.2}, nodes={}}, -- Spacer oben
    {n=G.UIT.R,config={align = "cm", padding = 0.1}, nodes={
        -- Skip-Button
        {n=G.UIT.C,config={align = "cm", padding = 0.1}, nodes={
            {n=G.UIT.R,config={align = "tm",padding = 0.2, minh = 1.2, minw = 1.8, r=0.15,colour = G.C.GREY, one_press = true, button = 'skip_booster', hover = true,shadow = true, func = 'can_skip_booster'}, nodes = {
                {n=G.UIT.T, config={text = localize('b_skip'), scale = 0.5, colour = G.C.WHITE, shadow = true, func = 'set_button_pip'}}
            }}
        }},

        
        {n=G.UIT.C,config={align = "cm", padding = 0}, 
            nodes=
            {
                {n=G.UIT.C,config={align = "cm", padding = 0},
                    nodes = {
                        -- Reroll pack button
                        {
                            n=G.UIT.R,
                            config={
                                ref_table = self,
                                align = "tm",
                                padding = 0.15,
                                minh = 0.30,
                                minw = 1.55,
                                r=0.15,
                                colour = G.C.RED,
                                one_press = false,
                                button = 'reroll_pack',
                                hover = true,
                                shadow = true,
                                func = 'can_reroll_pack'
                            }, 
                            nodes = {
                                {
                                    n=G.UIT.R,
                                    config={align = "cm", maxw = 1.3},
                                    nodes={
                                        {
                                            n=G.UIT.T,
                                            config={text = localize('k_reroll'), scale = 0.4, colour = G.C.WHITE, shadow = true, func = 'set_button_pip'}
                                        },
                                    }
                                },
                            }
                        },
                        -- Redraw hand button
                        {
                            n=G.UIT.R,
                            config={
                                ref_table = self,
                                align = "tm",
                                padding = 0.15,
                                minh = 0.30,
                                minw = 1.55,
                                r=0.15,
                                colour = G.C.RED,
                                one_press = false,
                                button = 'redraw_hand',
                                hover = true,
                                shadow = true,
                                func = 'can_redraw_hand'
                            }, 
                            nodes = {
                                {
                                    n=G.UIT.R,
                                    config={align = "cm", maxw = 1.3},
                                    nodes={
                                        {
                                            n=G.UIT.T,
                                            config={text = localize('k_redraw'), scale = 0.4, colour = G.C.WHITE, shadow = true, func = 'set_button_pip'}
                                        },
                                    }
                                },
                            }
                        },
                    }
                },
                -- Display rerolls remaining
                {n=G.UIT.C,config={align = "cm", padding = 0.2},
                    nodes = {
                        {n=G.UIT.R, config={align = "cm", maxw = 1.3},
                            nodes=
                            {
                                {n=G.UIT.T, config={ref_table = G.GAME, ref_value = 'booster_rerolls', scale = 0.4, colour = reroll_display_color, shadow = true, func = 'set_button_pip'}}
                            }
                        }
                    }
                }
            }             
        },
    }}
    }}}}}}}}
    return t
end

G.FUNCS.can_reroll_pack = function(e)
    local c1 = e.config.ref_table
    if G.pack_cards and (G.pack_cards.cards[1]) and G.GAME.booster_rerolls > 0 and not HBR.is_rerolling_disabled(c1) then 
        e.config.colour = G.C.GREEN
        e.config.button = 'reroll_pack' 
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end

end

G.FUNCS.reroll_pack = function(e)
    stop_use()
    local c1 = e.config.ref_table
    G.GAME.booster_rerolls = G.GAME.booster_rerolls - 1
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
            local card_count = #G.pack_cards.cards
            for i = #G.pack_cards.cards,1, -1 do
                local c = G.pack_cards:remove_card(G.pack_cards.cards[i])
                c:remove()
                c = nil
            end

            play_sound('other1')
            
            for i = 1, card_count do
                local _card_to_spawn = c1:create_card(self, i)
                local card

                if type((_card_to_spawn or {}).is) == 'function' and _card_to_spawn:is(Card) then
                    card = _card_to_spawn
                else
                    card = SMODS.create_card(_card_to_spawn)
                end

                G.pack_cards:emplace(card)
                card:juice_up()
            end
            return true
        end
    }))  
end

G.FUNCS.can_redraw_hand = function(e)
    local c1 = e.config.ref_table
    if #G.hand.cards > 0 and G.pack_cards and (G.pack_cards.cards[1]) and G.GAME.booster_rerolls > 0 and not HBR.is_rerolling_disabled(c1) then 
        e.config.colour = G.C.PALE_GREEN
        e.config.button = 'redraw_hand' 
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end

end

G.FUNCS.redraw_hand = function(e)
    stop_use()
    local c1 = e.config.ref_table
    local card_count = #G.hand.cards
    G.GAME.booster_rerolls = G.GAME.booster_rerolls - 1
    
    G.FUNCS.draw_from_hand_to_deck()
    
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.35,
        func = function()
            G.FUNCS.draw_from_deck_to_hand(card_count)
            return true
        end
    }))
end

HBR.is_rerolling_disabled = function(booster)
    return booster.disable_reroll
end

function add_booster_rerolls(amount)
    if not G.GAME.booster_rerolls_total then G.GAME.booster_rerolls_total = 0 end
    if not G.GAME.booster_rerolls then G.GAME.booster_rerolls = G.GAME.booster_rerolls_total end
    
    if amount == 0 then return end
    
    G.GAME.booster_rerolls_total = G.GAME.booster_rerolls_total + amount
    if G.GAME.booster_rerolls_total < 0 then G.GAME.booster_rerolls_total = 0 end

    if G.GAME.booster_rerolls > G.GAME.booster_rerolls_total then G.GAME.booster_rerolls = G.GAME.booster_rerolls_total
    elseif amount > 0 then G.GAME.booster_rerolls = G.GAME.booster_rerolls + amount end
end

function reset_booster_rerolls()
    if not G.GAME.booster_rerolls_total then G.GAME.booster_rerolls_total = 0 end
    G.GAME.booster_rerolls = G.GAME.booster_rerolls_total
end

-- Load test deck, if it's there
local init, error = SMODS.load_file("test_deck.lua")
if error then
    print("HBR: Test deck not found. Skip")
else
    if init then init() end
    print("HBR: Test deck loaded")
end