define ss_php::config(
  $file = $::ss_php::globals_cli_inifile,
  $config = {}
) {
  create_resources(::ss_php::config::setting, to_hash_settings($config, $file), {
    file => $file
  })
}
