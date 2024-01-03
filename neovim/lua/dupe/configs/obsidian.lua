require('obsidian').setup(
    {
        workspaces = {
          {
            name = "datastore",
            path = "~/datastore",
          },
        },
        daily_notes = {
            folder="daily notes",
        },
    }
)
