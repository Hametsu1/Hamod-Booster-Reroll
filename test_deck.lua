SMODS.Back {
    key = "reroll",
    pos = { x = 0, y = 0 },
    config = { booster_rerolls_total = 3, booster_rerolls = 3 },
    loc_vars = function(self, info_queue, back)
        return { vars = {  } }
    end,
    apply = function(self, back)
        G.GAME.booster_rerolls_total = self.config.booster_rerolls_total
        G.GAME.booster_rerolls = self.config.booster_rerolls
    end
}