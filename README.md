## DHIS2 Deployment Playbook

### Introduction

This is a simple repository meant to help in deployment of District Health Information System 2 (DHIS2). DHIS2 is an open source, web-based platform most commonly used as a health management information system (HMIS).
More details on the application can be found from the official site [here](https://docs.dhis2.org/en/use/what-is-dhis2.html)

### What are the benefits of using this approach?

- **Automation & Efficiency:** The repository automates the entire deployment process, reducing manual intervention and ensuring consistent setups across environments.
- **Error Reduction:** By automating complex tasks, the chances of human error are minimized, leading to more reliable deployments.
- **Scalability:** Easily scale up deployments across multiple servers or environments by simply running the Ansible playbooks, making it suitable for large-scale DHIS2 implementations.
- **Flexibility:** Allows seamless switching between different deployment environments (e.g., development, staging, production) without manual configuration changes.
- **Customization:** The playbooks can be adjusted to cater to specific needs like custom PostgreSQL tuning or specific service configurations, making them highly adaptable.
- **Reusability:** The repository can be reused for future DHIS2 deployments or updates, streamlining ongoing maintenance and upgrades.

To understand this repo and know how to use it effectively, you are required to understand what [Ansible](https://docs.ansible.com) is,
how it works and specifically the following Ansible components:

- [Roles](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html)
- [Playbooks](https://docs.ansible.com/ansible/latest/user_guide/playbooks.html)
- [Inventories](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html)

Repository directory structure
------------------------

```
dhis2-deployment-playbook
└── inventories - host configurations for different environments
    ├── his_servers - generic name for this deployment
    |   ├── group_vars - for variables meant to affect a collection of servers
    |   ├── host_vars - for variables meant to affect specific servers
    |   └── hosts - essential file for grouping hosts
    |
    ├── libs - collection of roles used to defined reusable behavior
    |   ├── caddy - caddy server installation role
    |   ├── common - essential packages role
    |   ├── dhis2 - dhis2 installation role
    |   └── postgresql - postgreSQL installation role
    ├── plays - entry point for any deployment
    |   └── install_dhis2.yml - runs deployment on specified target host(s)
    ├── .pre-commit-config.yaml
    ├── ansible.cfg
    ├── ssh.cfg
    ├── requirements.yml
    └── README.md
```

Managing secrets
----------------
- Configuration files under inventories may contain values that need to be kept secret. [Ansible vault](https://docs.ansible.com/ansible/latest/vault_guide/vault.html) helps to encrypt variables and files.
- **NOTE**: this repo is essentially a template that can be improvised for individual use, that said, all secrets here have been
  encrypted with a simple password: `1234`

```bash
dhis2-dep-pb~$ ansible-vault encrypt inventories/his_servers/group_vars/all/vault.yml --ask-vault-password
dhis2-dep-pb~$ ansible-vault decrypt inventories/his_servers/group_vars/all/vault.yml --ask-vault-password
```

Prerequisites
-------------

Before running the playbooks, you will need to ensure you have `Ansible 2.14` or above installed on the [control node](https://docs.ansible.com/ansible/latest/getting_started/index.html#getting-started-with-ansible).
Check the Ansible [installation docs](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible) on how to do that.
Also, make sure your target host(if not localhost) is accessible through ssh and configure `ssh.cfg` file according to your need.

Cloning the repo:
-----------------
- First, clone the repo, cd into it and run below command to install requirements:
```bash
dhis2-dep-pb~$ ansible-galaxy collection install -r requirements.yaml
```

Sample deployment commands:
-------------------------
Once the requirements have been installed successfully, you can run deployment using one of the commands below:

`dhis2-dep-pb~$ ansible-playbook -i inventories/<inventory> plays/<playbook>`

Run deployment against all servers accessible under `dhis2_servers` group of hosts:

`dhis2-dep-pb~$ ansible-playbook -i inventories/his_servers plays/install_dhis2.yml -vv`

Limit the deployment to the control node:

`dhis2-dep-pb~$ ansible-playbook -i inventories/his_servers -l "local_host" plays/install_dhis2.yml`

Skip deploying caddy server:

`dhis2-dep-pb~$ ansible-playbook -i inventories/his_servers -l "local_host" plays/install_dhis2.yml -e dhis2_caddy_as_reverse_proxy=false`

## Todos:
- improve this documentation
