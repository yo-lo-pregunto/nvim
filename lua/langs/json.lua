local function json_settings()
  return {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  }
end

return {
  plugins = {
    'b0o/schemastore.nvim',
  },
  server = { 'jsonls' },
  opts = {
    settings = json_settings,
  },
}
