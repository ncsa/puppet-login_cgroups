# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include login_cgroups
class login_cgroups (
  Array[String] cpu_settings,
  Array[String] memory_settings,
){

  include ::systemd

  systemd::dropin_file { '40-cpu.conf':
    ensure => 'present',
    unit => 'user-.slice',
    content => join(concat([
      '# File managed by Puppet',
      '[Slice]'],
      $cpu_settings), "\n"),
    notify_service => false,
    daemon_reload => true,
  }

  systemd::dropin_file { '50-memory.conf':
    ensure => 'present',
    unit => 'user-.slice',
    content => join(concat([
      '# File managed by Puppet',
      '[Slice]'],
      $memory_settings), "\n"),
    notify_service => false,
    daemon_reload => true,
  }

}
