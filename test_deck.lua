SMODS.Back {
    key = "reroll",
    pos = { x = 0, y = 0 },
    config = { booster_rerolls = 3 },
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.booster_rerolls } }
    end,
    apply = function(self, back)
        add_booster_rerolls(self.config.booster_rerolls)
    end
}