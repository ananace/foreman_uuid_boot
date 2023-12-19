# Foreman UUID Boot

Allows booting machines based off of machine UUID instead of - or in addition to - interface MAC

Example iPXE boot URLs;

`http://foreman.example.com/unattended/iPXE?mac=${netX/mac}&uuid=${uuid}`  
`http://template-proxy.example.com:8000/unattended/iPXE?mac=${netX/mac}&uuid=${uuid}`

Also works with `http://foreman.example.com/unattended/iPXE?bootstrap=true` after extending the iPXE intermediate script with;
```patch
- chain --autofree --replace <%= foreman_url('iPXE', {}, { mac: "${net#{i}/mac}" }) %> || goto net<%= i+1 %>
+ chain --autofree --replace <%= foreman_url('iPXE', {}, { mac: "${net#{i}/mac}", uuid: "${uuid}" }) %> || goto net<%= i+1 %>
```

## Installation

See the [Plugins install instructions, advanced installation from gems](https://theforeman.org/plugins/#2.3AdvancedInstallationfromGems) for information on how to install this plugins.

To enable legacy fact searching in addition to the UUID boot facet, create a plugin configuration file under `/etc/foreman/plugins` with;
```yaml
---
:uuidboot_factsearch: true
```

## Contributing

Bug reports and pull requests are welcome on the LiU GitLab at https://gitlab.liu.se/ITI/foreman_uuid_boot or on GitHub at https://github.com/ananace/foreman_uuid_boot

## License

The gem is available as open source under the terms of the [GPL-3.0 License](https://opensource.org/licenses/GPL-3.0).
