Config = {}

-- General Config
Config.Notify = 'ox' -- 'ox'/'esx'/'other'
Config.Progress = 'circle' -- 'circle'/'bar'
Config.Language = 'en' -- 'en'/'fi'

-- Locales Config
Config.Locales = {
    ['fi'] = {
        ['collect_bag'] = 'Kerää Roskapussi',
        ['put_bag'] = 'Laita Roskapussi Autoon',
        ['clock_in'] = 'Aloita Työvuoro',
        ['clock_out'] = 'Lopeta Työvuoro',
        ['clocked_in'] = 'Olet aloittanut työvuorosi ja työautosi on vapautettu käyttöösi.',
        ['clocked_out'] = 'Olet lopettanut työvuorosi ja työautosi on viety pois.',
        ['max_bags'] = 'Olet saavuttanut roskien keräämisen enimmäismäärän, mene pomon luokse ja saat maksun.',
        ['collecting_bag'] = 'Keräät roskapussia',
        ['putting_bag'] = 'Laitat roskapussin autoon',
        ['clocking_in'] = 'Aloitetaan työvuoro',
        ['clocking_out'] = 'Lopetetaan työvuoro',
        ['pay_received'] = 'Olet saanut €%s palkkaa kerättyjen roskapussien määrästä.',
        ['no_pay_received'] = 'Et kerännyt yhtään roskapussia, joten et saanut palkkaa.',
        ['garbage_job'] = 'Roskakusi Työ',
    },
    ['en'] = {
        ['collect_bag'] = 'Collect Trash Bag',
        ['put_bag'] = 'Put Trash Bag in Vehicle',
        ['clock_in'] = 'Clock-in',
        ['clock_out'] = 'Clock-out',
        ['clocked_in'] = 'You have clocked in and your vehicle has been released.',
        ['clocked_out'] = 'You have clocked out and your vehicle has been put away.',
        ['max_bags'] = 'You have reached the maximum number of bags, go to the boss and get paid.',
        ['collecting_bag'] = 'Collecting trash bag',
        ['putting_bag'] = 'Putting trash bag in the vehicle',
        ['clocking_in'] = 'Clocking in',
        ['clocking_out'] = 'Clocking out',
        ['pay_received'] = 'You have been paid €%s for the bags you collected.',
        ['no_pay_received'] = 'You didnt collect any bags so you didnt get paid.',
        ['garbage_job'] = 'Garbage Job',
    }
}

-- Model Config
Config.Models = {'prop_dumpster_01a', 'prop_dumpster_02a', 'prop_dumpster_02b'}

-- Job Config
Config.RequireJob = false
Config.Job = 'garbage'

-- Bags Config
Config.PayPerBag = 20
Config.MaxBags = 25

-- Vehicle Config
Config.VehicleModel = 'trash'
Config.VehicleSpawn = vector4(-324.4425, -1523.8933, 27.2586, 266.4719)

-- Location & Blip Config
Config.JobClock = vector3(-322.2470, -1545.8246, 31.0199)
Config.Blip = {
    Show = true,
    Sprite = 318,
    Color = 25,
    Scale = 0.8,
}