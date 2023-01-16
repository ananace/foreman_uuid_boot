# Foreman UUID Boot

Allows booting machines based off of machine UUID instead of - or in addition to - interface MAC

Example iPXE boot URLs;

`http://foreman.example.com/unattended/iPXE?uuid=${uuid}`  
`http://template-proxy.example.com:8000/unattended/iPXE?mac=${netX/mac}&uuid=${uuid}`


## Installation

See the [Plugins install instructions, advanced installation from gems](https://theforeman.org/plugins/#2.3AdvancedInstallationfromGems) for information on how to install this plugins.

## Contributing

Bug reports and pull requests are welcome on the LiU GitLab at https://gitlab.liu.se/ITI/foreman_uuid_boot or on GitHub at https://github.com/ananace/foreman_uuid_boot

## License

The gem is available as open source under the terms of the [GPL-3.0 License](https://opensource.org/licenses/GPL-3.0).
