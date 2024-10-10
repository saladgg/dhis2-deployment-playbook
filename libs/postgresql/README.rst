Setup PostgreSQL
================
This role installs PostgreSQL database.
PostgreSQL is a robust open-source database system extending SQL for complex data,
ensuring safe storage and scalability.
More details can be found from the official site here_

Role Defaults
-------------

+---------------------+-------------------------+
| Attribute Name      | Default Value           |
+=====================+=========================+
| common tag          | postgres                |
+---------------------+-------------------------+

- **common tag:** This attribute refers to the tag shared across all tasks in this role.

postgresql.conf
~~~~~~~~~~~~~~~~~
This is the main configuration file for every PostgreQL installation. You may be interested
to override a few important variables to fit your installation needs:

+-------------------------+---------------+------------------------------------------------------+
| NAME                    | SAMPLE VALUE  | DESCRIPTION                                          |
+=========================+===============+======================================================+
| max_connections         | 200           | Max num of connections which PG will allow           |
+-------------------------+---------------+------------------------------------------------------+
| shared_buffers          | 2400MB        | Exclusive mem for PostgreSQL caching                 |
+-------------------------+---------------+------------------------------------------------------+
| work_mem                | 20MB          | Memory used for internal sort and hash operations    |
+-------------------------+---------------+------------------------------------------------------+
| maintenance_work_mem    | 512MB         | Amount of mem PG can use for maintenance operations  |
+-------------------------+---------------+------------------------------------------------------+
| temp_buffers            | 16MB          | Max num of temporary buffers used by each DB session |
+-------------------------+---------------+------------------------------------------------------+
| effective_cache_size    | 3000MB        | An estimate available disk cache memory by OS        |
+-------------------------+---------------+------------------------------------------------------+

|
**Debug/Verification commands:**

Once the role has been implemented, run below commands on the target host

.. code-block:: terminal
   psql --version  (Confirm that you have the right pg version installed)
   sudo systemctl status postgresql.service (Check that postgresql service is running)
   sudo tail -fn100 /var/log/postgresql/postgresql-<version>-main.log (Check pg logs)

.. _here: https://www.postgresql.org/about/
