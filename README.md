# DHIS2 Deployment Playbook

[![CI](https://github.com/saladgg/dhis2-deployment-playbook/actions/workflows/ci.yaml/badge.svg)](https://github.com/saladgg/dhis2-deployment-playbook/actions/workflows/ci.yaml)
[![Ansible](https://img.shields.io/badge/Ansible-%3E%3D2.14-blue?logo=ansible)](https://docs.ansible.com)
[![DHIS2](https://img.shields.io/badge/DHIS2-v41.0.1-orange)](https://dhis2.org)
[![License](https://img.shields.io/github/license/saladgg/dhis2-deployment-playbook)](LICENSE)

An Ansible-based automation playbook for deploying [DHIS2](https://docs.dhis2.org/en/use/what-is-dhis2.html) (District Health Information System 2), an open-source, web-based health management information system (HMIS).

## Benefits

- **Automation & Efficiency:** Automates the entire deployment process, reducing manual intervention and ensuring consistent setups across environments.
- **Error Reduction:** Minimizes human error, leading to more reliable deployments.
- **Scalability:** Easily scale deployments across multiple servers by running the playbooks against different inventories.
- **Flexibility:** Seamlessly switch between development, staging, and production environments without manual configuration changes.
- **Customization:** Adjust PostgreSQL tuning, Java options, and service configurations to fit specific needs.
- **Reusability:** Reuse for future DHIS2 deployments, updates, or upgrades.

## Stack

| Component          | Version          |
|--------------------|------------------|
| DHIS2              | 41.0.1           |
| Java               | OpenJDK 21       |
| Tomcat             | 9 (user instance)|
| PostgreSQL         | 15               |
| PostGIS            | 3                |
| Reverse Proxy      | Caddy            |
| Target OS          | Ubuntu 24.04 LTS |

## Prerequisites

- **Ansible 2.14+** on the [control node](https://docs.ansible.com/ansible/latest/getting_started/index.html#getting-started-with-ansible). See the [installation docs](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible).
- SSH access to target hosts (if not deploying to localhost). Configure `ssh.cfg` using `ssh.cfg.template` as a reference.
- Familiarity with Ansible [Roles](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html), [Playbooks](https://docs.ansible.com/ansible/latest/user_guide/playbooks.html), and [Inventories](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html).

## Repository Structure

```
dhis2-deployment-playbook
├── inventories - host configurations for different environments
|   └── his_servers - generic name for this deployment
|       ├── group_vars - for variables meant to affect a collection of servers
|       ├── host_vars - for variables meant to affect specific servers
|       └── hosts - essential file for grouping hosts
|
├── libs - collection of roles used to define reusable behavior
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

## Getting Started

Clone the repo and install Ansible Galaxy dependencies:

```bash
git clone https://github.com/saladgg/dhis2-deployment-playbook.git
cd dhis2-deployment-playbook
ansible-galaxy collection install -r requirements.yml
```

## Usage

Run deployment against all hosts in `dhis2_servers` group:

```bash
ansible-playbook -i inventories/his_servers plays/install_dhis2.yml -vv
```

Limit to the control node only:

```bash
ansible-playbook -i inventories/his_servers -l "local_host" plays/install_dhis2.yml
```

Skip deploying Caddy reverse proxy:

```bash
ansible-playbook -i inventories/his_servers -l "local_host" plays/install_dhis2.yml -e dhis2_caddy_as_reverse_proxy=false
```

General form:

```bash
ansible-playbook -i inventories/<inventory> plays/<playbook>
```

## Managing Secrets

Configuration files under `inventories/` may contain values that need to be kept secret. [Ansible Vault](https://docs.ansible.com/ansible/latest/vault_guide/vault.html) is used to encrypt these variables.

> **Note:** This repo is a template for individual use. All secrets are encrypted with the password: `1234`
>
> **Warning:** Before using this in any real environment, you **must** re-encrypt all vault files with a strong password:
> ```bash
> ansible-vault rekey <vault_file> --ask-vault-password
> ```

Encrypt or decrypt a vault file:

```bash
ansible-vault encrypt inventories/his_servers/group_vars/all/vault.yml --ask-vault-password
ansible-vault decrypt inventories/his_servers/group_vars/all/vault.yml --ask-vault-password
```
