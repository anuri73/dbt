create table source
(
    id    serial
        constraint source_pk
            primary key,
    value varchar(258)
);