Setup Caddy Server
==================
This role installs caddy server on the target host.
Caddy Server is a lightweight, open-source web server that
simplifies HTTPS configuration with automatic SSL certificate
management. It offers features like HTTP/2, reverse proxy,
and easy configuration through its Caddyfile.
More details on the application can be found from the official documentation_

Role Defaults
-------------

+---------------------+-------------------------+
| Attribute Name      | Default Value           |
+=====================+=========================+
| common tag          | caddy                   |
+---------------------+-------------------------+
| Variable prefix     | ``caddy_``              |
+---------------------+-------------------------+

|
- **common tag:** This attribute refers to the tag shared across all tasks in this role.
- **variable prefix:** This attribute refers to a string that is prepended to all variable names used by this role.

The role has a few variables that can be used to tweak the server configuration.

Config variables
----------------

+---------------------------+----------------+--------------------------+
| NAME                      | SAMPLE VALUE   | DESCRIPTION              |
+===========================+================+==========================+
| caddy_app_user            | caddy          | Default application user |
+---------------------------+----------------+--------------------------+
| caddy_app_user_group      | caddy          | Application user group   |
+---------------------------+----------------+--------------------------+
| caddy_app_service_address | 127.0.0.1:8085 | Origin server domain     |
+---------------------------+----------------+--------------------------+
| caddy_app_host_domain     | test.app.org   | Proxy server domain      |
+---------------------------+----------------+--------------------------+

|
Debug/Verification commands
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- Once the installation has been completed, run below commands on the target host:

.. code-block:: terminal
   sudo systemctl status caddy (Check the service status)
   sudo journalctl -u caddy.service (Check server logs)

.. _documentation: https://caddyserver.com/docs/
