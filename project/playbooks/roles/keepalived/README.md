# Ansible Role: Keepalived

#### Version: 1.0.0

[![](https://img.shields.io/badge/role-sparknsh.keepalived-blue.svg)](https://galaxy.ansible.com/sparknsh/keepalived)

Development of this project is managed in a private repository then pushed out to [GitLab](https://gitlab.com/sparknsh/ansible-role-keepalived) and [GitHub](https://github.com/sparknsh/ansible-role-keepalived) when we have a new version for you. If you have any issues please contact [sparknsh](https://www.sparknsh.com/contact?type=issue&name=ansible-role-keepalived)

## Role Variables

```yaml
keepalived__nonlocal_bind: false
keepalived__conf_tpl: keepalived.conf.j2
keepalived__routers: []
```

#### Example

```yaml
keepalived__nonlocal_bind: true
keepalived__routers:
  - name: vrrp_1
    check_script:
      - name: chk_haproxy
        script: 'killall -0 haproxy'
        interval: 2
        weight: 2
        fall: 1
        rise: 1
    vip_int: "{{ ansible_default_ipv4.interface }}"
    master_node: machine-1
    router_pri_master: 150
    router_pri_backup: 100
    advert_int: 1
    nopreempt: true
    auth_pass: password
    use_unicast: true
    unicast_src_ip: "{{ ansible_default_ipv4.address }}"
    unicast_peers:
      - 192.168.201.101
    router_id: 50
    vip_addresses:
      - 192.168.202.100
      - 192.168.202.101
    vip_addresses_excluded:
      - 172.16.3.5/24 dev ens224 label ens224:2
```

## Example Playbook

```yaml
- hosts: all
  vars_files:
    - vars/main.yml
  roles:
     - { role: sparknsh.keepalived }
```

## License

MIT

## Author Information

This role was created in 2019 by [sparknsh](https://www.sparknsh.com) at [Rebel Media, Inc.](https://www.rebelmedia.io/)
