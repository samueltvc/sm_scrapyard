Config = {} -- DONT TOUCH 

Config.Item = "scrap"

Config.Locations = {
 Ped = vector4(-421.8859, -1689.0726, 18.0291, 41.10), -- PED LOCATION
}

Config.Notify = {
 ----------------------------------------------------
 label = "Scrapyard",
 ----------------------------------------------------
 targetlabel = "Scrap Vehicle",
 progresslabel = "Scraping Vehicle..."
 ----------------------------------------------------
}

Config.SellShops = {
    { 
        coords = vec3(411.44, 313.27, 103.01-0.9), -- Coords of sell shop
        heading = 201.2, -- Heading of ped in pawn shop
        ped = 'a_m_m_og_boss_01', -- Ped model name
        label = 'Sell Shop', -- Label at top of context menu/blip if enabled
        blip = {
            enabled = false, -- Enable blip?
            sprite = 11, -- https://docs.fivem.net/docs/game-references/blips/
            color = 11, -- https://docs.fivem.net/docs/game-references/blips/
            scale = 0.75 -- Scale/size of blip (0.75 default)
        },
        items = {
            { item = 'scrap', label = 'Scrap', price = 10, currency = 'money' } -- money / black_money
        }
    },
}
