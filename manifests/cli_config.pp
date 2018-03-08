define php::cli_config(
  $file = $::php::globals_cli_inifile,
  $config = {}
) {
  create_resources(::php::config::setting, to_hash_settings($config, $file), {
    file => $file
  })
}
