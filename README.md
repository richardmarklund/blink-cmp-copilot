# blink-cmp-copilot

Adds copilot suggestions as a source for [Saghen/blink.cmp](https://github.com/Saghen/blink.cmp)

## Setup

If you already have copilot.lua installed, you can install this plugin with packer as you would any other with the following code:

### Install

#### Lazy

```lua
{
  "giuxtaposition/blink-cmp-copilot",
}

```

#### Packer

```lua
use {
  "giuxtaposition/blink-cmp-copilot",
  after = { "copilot.lua" },
}
```

If you do not have copilot.lua installed, go to https://github.com/zbirenbaum/copilot.lua and follow the instructions there before installing this one

It is recommended to disable copilot.lua's suggestion and panel modules, as they can interfere with completions properly appearing in blink-cmp-copilot. To do so, simply place the following in your copilot.lua config:

```lua
require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})
```

### Configuration:

#### blink-cmp:

##### Source Definition

To link blink-cmp with this source, simply go into your configuration file and add blink-cmp-copilot in you providers and also remember to enable it! Here's a minimal example:

```lua
{
    "saghen/blink.cmp",
    dependencies = {
      {
        "giuxtaposition/blink-cmp-copilot",
      },
    },
    opts = {
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
          },
        },
      },
    },
  }
```
