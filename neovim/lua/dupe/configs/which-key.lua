local which_key = require "which-key"

which_key.setup {
    delay = 500,
    filter = function(mapping)
        return mapping.desc and mapping.desc ~= ""
    end,
}
