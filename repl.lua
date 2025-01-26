return
{
  "hkupty/iron.nvim",
  config = function()
    require("iron.core").setup {
      config = {
        repl_definition = {
          scheme = { command = {"racket"} }
        },
        repl_open_cmd = "split"
      }
    }
  end
}

