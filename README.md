cb-medloot

A script that allows players to search containers within hospitals and medical areas for medical items.

Due to this script using qb-target, you must insert the following lines in qb-target/init.lua, under Config.TargetModels.

		["looting"] = {
            models = {
                "v_med_trolley",
                "v_med_trolley2",
				"prop_medstation_01",
				"v_med_cor_cemtrolly"
            },
            options = {
                {
                    type = "client",
                    event = "cb-medloot:client:loot",
                    icon = "fas fa-toolbox",
                    label = "Search",
                }
            },
            distance = 1.5
        },

You can also add more areas to search under "models" in the above code.

This is my first script so please let me know of any feedback and changes you would like to see.
