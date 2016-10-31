

getConfigVal = (field, value) ->
  val = value
  if typeof val['use_env_variable'] is 'string'
    envVal = process.env[val.use_env_variable]
    if !envVal
      throw new Error "Environment variable #{val['use_env_variable'] } is null!"
    else
      val = process.env[val.use_env_variable]
  if val is 'false'
    val = false
  if val is 'true'
    val = true
  val

module.exports = (envConfig) ->
  config = {}
  for f, v of envConfig
    config[f] = getConfigVal(f, v)

  config
