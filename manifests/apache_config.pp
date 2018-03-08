define php::apache_config(
  $file = $::php::globals_apache_inifile,
  $config = {}
) {
  create_resources(::php::config::setting, to_hash_settings($config, $file), {
    file => $file
  })
}
