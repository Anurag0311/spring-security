INSERT INTO users (username, password, enabled) VALUES ('user', 'pass', true);
INSERT INTO authorities (username, authority) VALUES ('user', 'ROLE_USER');


INSERT INTO users(username, password, enabled)
    values('admin',
    'pass',
    true);
INSERT INTO authorities (username, authority)
    values('admin', 'ROLE_ADMIN');


--INSERT INTO authorities (username, authority)
--    values('user', 'ROLE_USER');
--
--INSERT INTO authorities (username, authority)
--    values('admin', 'ROLE_ADMIN');

