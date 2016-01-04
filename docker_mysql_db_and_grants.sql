/* For use by docker-compose */

CREATE DATABASE ebms;

CREATE DATABASE as2;

/* TODO: fix the grants, need passwords independently? */
GRANT ALL ON ebms.* TO 'ebms'@'localhost';

GRANT ALL ON as2.* TO 'as2'@'localhost';
