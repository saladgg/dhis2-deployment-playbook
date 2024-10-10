Setup DHIS2
----------------------
This role installs District Health Information System 2 (DHIS2) application on the target machine.
DHIS2 is an open source, web-based platform most commonly used as a health management information system (HMIS).
More details on the application can be found from the official site here_.
Other important links include:
    - api_ documentation and;
    - installation_ guide

**Assumptions:**
The following server and database have been assumed for the application:

   - `Apache Tomcat:` This will serve as the local application server.
   - `PostgreSQL:` This is the preferred database for the application. Refer to the `postgresql` role for further details.

Role Defaults
-------------

+---------------------+-------------------------+
| Attribute Name      | Default Value           |
+=====================+=========================+
| common tag          | dhis2                   |
+---------------------+-------------------------+
| Variable prefix     | ``dhis2_``              |
+---------------------+-------------------------+

- **common tag:** This attribute refers to the tag shared across all tasks in this role.
- **variable prefix:** This attribute refers to a string that is prepended to all variable names used by this role.

The role has a few variables that can be used to tweak configuration according to the application's specific needs.

Config variables
----------------

+---------------------------+---------------------------+------------------------------------------------+
| NAME                      | SAMPLE VALUE              | DESCRIPTION                                    |
+===========================+===========================+================================================+
| dhis2_app_user            | dhis2                     | Default application user                       |
+---------------------------+---------------------------+------------------------------------------------+
| dhis2_app_name            | dhis2                     | Custom application label                       |
+---------------------------+---------------------------+------------------------------------------------+
| dhis2_db_name             | dhis2_db                  | Application's database                         |
+---------------------------+---------------------------+------------------------------------------------+
| dhis2_db_user             | dhis2                     | Database user                                  |
+---------------------------+---------------------------+------------------------------------------------+
| dhis2_host_domain_address | test.his.fyj.com          | Dhis's domain name                             |
+---------------------------+---------------------------+------------------------------------------------+
| dhis2_local_service_port  | 8080                      | Port on which dhis application is being served |
+---------------------------+---------------------------+------------------------------------------------+
| dhis2_java_opts           | '-Xmx10000m -Xms3000m'    | Set JVM's min and max heap size                |
+---------------------------+---------------------------+------------------------------------------------+
| dhis2_pg_*                | <postgres related values> | PG variables. See `postgres` role              |
+---------------------------+---------------------------+------------------------------------------------+

|
**Debug/Verification commands:**

- Once deployment has been completed, run below commands on the target host:

.. code-block:: terminal
   sudo systemctl status dhis2.service (Check the service status)
   sudo sudo tail -fn200 /home/dhis2/apache_tomcat/logs/catalina.out (Check server logs)

.. _here: https://docs.dhis2.org/en/use/what-is-dhis2.html
.. _api: https://docs.dhis2.org/en/develop/using-the-api/dhis-core-version-240/introduction.html
.. _installation: https://docs.dhis2.org/en/manage/performing-system-administration/dhis-core-version-240/installation.html
