# @summary Configure BabyBuddy instance
#
# @param hostname is the hostname for the goat server
# @param aws_access_key_id sets the AWS key to use for Route53 challenge
# @param aws_secret_access_key sets the AWS secret key to use for the Route53 challenge
# @param admin_email is the email address to access metrics
# @param ip sets the IP of the container
class babybuddy (
  String $aws_access_key_id,
  String $aws_secret_access_key,
  String $admin_email,
  String $ip = '172.17.0.4',
) {
  nginx::site { $hostname:
    proxy_target          => 'http://localhost:8081',
    aws_access_key_id     => $aws_access_key_id,
    aws_secret_access_key => $aws_secret_access_key,
    email                 => $admin_email,
  }

  docker::container { 'babybuddy':
    image => 'lscr.io/linuxserver/babybuddy:latest',
    args  => [
      "--ip ${ip}",
      '--env TZ=America/New_York',
    ],
    cmd   => '',
  }
}
